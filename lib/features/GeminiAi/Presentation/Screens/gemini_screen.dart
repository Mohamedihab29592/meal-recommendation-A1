import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/suggested_recipe_cubit.dart';

class MealSuggestionScreen extends StatelessWidget {
  final TextEditingController ingredientController = TextEditingController();

  MealSuggestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Suggestion'),
        backgroundColor: Colors.greenAccent.shade700,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIngredientInput(context),
              const SizedBox(height: 20),
              BlocBuilder<SuggestedRecipeCubit, SuggestedRecipeState>(
                builder: (context, state) {
                  if (state is SuggestedRecipeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SuggestedRecipeSuccess) {
                    return _buildRecipeDetails(context, state);
                  } else if (state is SuggestedRecipeError) {
                    return Center(
                      child: Text(
                        'Error: ${state.errorMessage}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIngredientInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: ingredientController,
          decoration: const InputDecoration(
            labelText: 'Enter ingredients',
            hintText: 'E.g., chicken, rice, tomato...',
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.food_bank),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              final ingredients = ingredientController.text;
              context
                  .read<SuggestedRecipeCubit>()
                  .fetchSuggestedRecipe(ingredients);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.greenAccent.shade700,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: const Text(
              'Get Recipe Suggestion',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecipeDetails(
      BuildContext context, SuggestedRecipeSuccess state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        _buildSectionHeader('Meal Name'),
        _buildCardContent(state.suggestedRecipe.mealName),
        const SizedBox(height: 10),
        _buildSectionHeader('Description'),
        _buildCardContent(state.suggestedRecipe.description),
        const SizedBox(height: 10),
        _buildSectionHeader('Ingredients'),
        _buildIngredientList(state.suggestedRecipe.ingredients),
        const SizedBox(height: 10),
        _buildSectionHeader('Instructions'),
        _buildInstructionList(state.suggestedRecipe.instructions),
        if (state.suggestedRecipe.nutritionalInformation != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildSectionHeader('Nutritional Information'),
              _buildCardContent(state.suggestedRecipe.nutritionalInformation!),
            ],
          ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.greenAccent.shade700,
      ),
    );
  }

  Widget _buildCardContent(String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Text(
        content,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildIngredientList(List<String> ingredients) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: ingredients
            .map((ingredient) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.check, size: 18, color: Colors.green),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          ingredient,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildInstructionList(List<String> instructions) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: instructions
            .asMap()
            .entries
            .map((entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${entry.key + 1}. ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
