
class SuggestedRecipe {
  final String mealName;
  final String description;
  final List<String> ingredients;
  final List<String> instructions;
  final String? nutritionalInformation;

  SuggestedRecipe({
    required this.mealName,
    required this.description,
    required this.ingredients,
    required this.instructions,
    this.nutritionalInformation,
  });
}

class RecipeParser {
  SuggestedRecipe parseRecipe(String apiResponse) {
    final lines = apiResponse.split('\n').map((line) => line.trim()).where((line) => line.isNotEmpty).toList();

    String mealName = '';
    String description = '';
    List<String> ingredients = [];
    List<String> instructions = [];
    String? nutritionalInformation;

    String currentSection = '';

    for (var line in lines) {
      if (line.startsWith('##')) {
        mealName = line.replaceAll('##', '').trim();
        currentSection = 'description';
      } else if (line.contains(RegExp(r'\*\*Description:\*\*', caseSensitive: false))) {
        currentSection = 'description';
        description = line.replaceAll(RegExp(r'\*\*Description:\*\*', caseSensitive: false), '').trim();
      } else if (line.contains(RegExp(r'\*\*Ingredients:\*\*', caseSensitive: false))) {
        currentSection = 'ingredients';
      } else if (line.contains(RegExp(r'\*\*Instructions:\*\*', caseSensitive: false))) {
        currentSection = 'instructions';
      } else if (line.contains(RegExp(r'\*\*Nutritional Information:\*\*', caseSensitive: false))) {
        currentSection = 'nutritionalInformation';
        nutritionalInformation = '';
      }
      else if (line.contains(RegExp(r'\*\*Nutritional Information (per serving):\*\*', caseSensitive: false))) {
        currentSection = 'nutritionalInformation';
        nutritionalInformation = '';
      }
      else {
        if (currentSection == 'description') {
          description += ' $line';
        } else if (currentSection == 'ingredients') {
          ingredients.add(line.replaceAll(RegExp(r'^[\*\-]'), '').trim());
        } else if (currentSection == 'instructions') {
          instructions.add(line.replaceAll(RegExp(r'^\d+\. '), '').trim());
        } else if (currentSection == 'nutritionalInformation') {
          nutritionalInformation = (nutritionalInformation ?? '') + '\n' + line;
        }
      }
    }

    return SuggestedRecipe(
      mealName: mealName,
      description: description.trim(),
      ingredients: ingredients,
      instructions: instructions,
      nutritionalInformation: nutritionalInformation?.trim(),
    );
  }
}
