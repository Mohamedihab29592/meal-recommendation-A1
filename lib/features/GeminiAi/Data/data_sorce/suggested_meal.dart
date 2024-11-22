import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:meal_recommendations/core/models/meal.dart';
import 'package:meal_recommendations/features/GeminiAi/Data/models/ImageModel.dart';
import 'package:meal_recommendations/features/GeminiAi/Data/models/suggested_meal_model.dart';
import 'package:http/http.dart' as http;
import 'package:pexels_client/pexels_client.dart';

class RecipeRemoteDatasource {
  final String apiKey = 'AIzaSyC7KGMLOwzuPM6hZXCz7QAnBXG5bqsUiII';
  final gemini = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: 'AIzaSyC7KGMLOwzuPM6hZXCz7QAnBXG5bqsUiII',
  );

  String extractJson(String responseText) {
    final jsonStart = responseText.indexOf('{');
    final jsonEnd = responseText.lastIndexOf('}');
    if (jsonStart == -1 || jsonEnd == -1) {
      throw Exception('JSON data not found in the response');
    }
    return responseText.substring(jsonStart, jsonEnd + 1);
  }

  Future<Meal> getRecipeSuggestions(String ingredients) async {
    try {
      final prompt = '''
      I need a recipe suggestion in JSON format for a meal with$ingredients . The JSON response should strictly match the following model structure:

{
  "id": "(optional, string, unique identifier)",
  "name": "(string, recipe name)",
  "dish_name": "(optional, string, name of the dish)",
  "meal_type": "(string, type of meal, e.g., breakfast, lunch, dinner)",
  "rating": "(number, rating of the recipe)",
  "cook_time": "(integer, cooking time in minutes)",
  "serving_size": "(integer, number of servings)",
  "image_url": "(optional, string, URL of the recipe image)ensure it`s not null",
  "summary": {
    "summary": "(string, a short description of the meal)",
    "nutrations": [
      {
        "quantity_in_grams": "(integer, quantity in grams)",
        "nutrient_name": "(string, name of the nutrient)"
      }
    ]
  },
  "ingredients": [
    {
      "name": "(string, ingredient name)",
      "imageUrl": "(string, URL of the ingredient image)" ensure it`s not null,
      "pieces": "(integer) just integer don`t put any thing behind it"
    }
  ],
  "meal_steps": [
    "(string, individual cooking steps listed in order)"
  ],
}

The response must strictly adhere to the following rules:
- The JSON format should include all specified keys, even if optional fields are null or empty.
- All keys and string values must be enclosed in double quotes.
- Fractional values (e.g., "1/2") must be quoted as strings.
- No extra text, comments, or explanation should be added to the response.
- Ensure strict adherence to the JSON standard and the provided model structure.

      ''';
      /*
      '''
      I need a recipe suggestion for breakfast in JSON format that matches the structure of the model I provided below. The JSON should include the following sections:
      - `name` (recipe name),
      - `meal_type` (type of meal),
      - `rating` (rating of the recipe),
      - `cook_time` (time to cook in minutes),
      - `serving_size` (number of servings),
      - `summary` (includes a description and a list of nutritional information),
      - `ingredients` (list of ingredients with names,image_url,and quantity in pieces),
      - `meal_steps` (list of cooking instructions).

      Return the response strictly in JSON format without any additional text or comments.
      Ensure the JSON response strictly adheres to the JSON standard:
- All keys and string values must be enclosed in double quotes.
- Fractions or mixed strings like `1/2` must be quoted as `"1/2"`.

      ''';

       */

      final content = [Content.text(prompt)];

      final response = await gemini.generateContent(content);

      final jsonString = extractJson(response.text!.trim());
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      void printLongText(String text) {
        final pattern = RegExp('.{1,800}');
        for (final match in pattern.allMatches(text)) {
          print(match.group(0));
        }
      }

      printLongText(jsonString);
      return Meal.fromJson(jsonMap);
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching recipe suggestions: $e');
    }
  }

  /*
  ///Fetch Dish Name Image (Ahmed)
  Future<ImageModel> getDishImage(String dishName) async {
    String baseUrl = 'api.spoonacular.com';
    String imageUrl = '/recipes/complexSearch';

    Uri url = Uri.https(baseUrl, imageUrl, {
      'apiKey': 'e2a21c9bc1754ab9bd830d5d65bf7a7d',
      'query': dishName,
      'addRecipeInformation': 'false',
    });
    try {
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      var json = jsonDecode(response.body);
      return ImageModel.fromJson(json);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

   */
  Future<String> getDishImage(String dishName) async {
    try {
      var image = await client.searchPhotos(query: dishName);
      return image!.photos![0].src!.medium!;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
  /*
    String baseUrl = 'api.spoonacular.com';
    String imageUrl = '/recipes/complexSearch';

    Uri url = Uri.https(baseUrl, imageUrl, {
      'apiKey': 'e2a21c9bc1754ab9bd830d5d65bf7a7d',
      'query': dishName,
      'addRecipeInformation': 'false',
    });
    try {
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

     */

  Future<List> getIngredientsImages(List<String> ingredientNames) async {
    final imageUrls = [];
    for (var ingredient in ingredientNames) {
      var image = await client.searchPhotos(query: ingredient);
      if (image!.photos!.isNotEmpty) {
        imageUrls.add(image.photos?[0].src!.medium);
      }
    }
    return imageUrls;
  }
}

final client = PexelsClient(
    apiKey: '8VhNO20JXl2VGrbWz8Bv1CdY9Kjh21krvpi7Rwi50KmD8fkRs4XtIln4');
