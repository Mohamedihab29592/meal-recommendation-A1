import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:meal_recommendations/features/GeminiAi/Data/models/suggested_meal_model.dart';

class RecipeRemoteDatasource {
  final String apiKey = 'AIzaSyC7KGMLOwzuPM6hZXCz7QAnBXG5bqsUiII';
  final gemini = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: 'AIzaSyC7KGMLOwzuPM6hZXCz7QAnBXG5bqsUiII',
  );

  Future<SuggestedRecipe> getRecipeSuggestions(String ingredients) async {
    try {
      final prompt =
          'Suggest a recipe for $ingredients ,i need the data in just five sections (Name,Nutritional information, description, ingredients,instructions,) nothing more';
      final content = [Content.text(prompt)];

      final response = await gemini.generateContent(content);
      print(response.text);
      return RecipeParser().parseRecipe(response.text!);
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
