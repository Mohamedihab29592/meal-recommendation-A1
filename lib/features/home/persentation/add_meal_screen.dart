import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/helpers/secure_storage_helper.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final TextEditingController _mealNameController = TextEditingController();
  final TextEditingController _ingredientController = TextEditingController();
  final List<String> _ingredients = [];
  String? _errorMessage;

  void _addIngredient() {
    final ingredient = _ingredientController.text.trim();
    if (ingredient.isNotEmpty) {
      setState(() {
        _ingredients.add(ingredient);
        _ingredientController.clear();
      });
    }
  }

  void _submitMeal() async {
  final mealName = _mealNameController.text.trim();
  if (mealName.isEmpty || _ingredients.isEmpty) {
    setState(() {
      _errorMessage = "Please provide a meal name and at least one ingredient.";
    });
    return;
  }

  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    setState(() {
      _errorMessage = "User not authenticated. Please log in again.";
    });
    print('User is not logged in.');
    return;
  }

  final userId = user.uid; 
  print('Logged-in User ID: $userId');

  try {
    // Reference Firestore
    final firestore = FirebaseFirestore.instance;

    // Save meal to the user's collection
    await firestore
        .collection('users') 
        .doc(userId) 
        .collection('add_meals') 
        .add({
      'mealName': mealName,
      'ingredients': _ingredients, 
      'createdAt': FieldValue.serverTimestamp(),
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Meal saved successfully!')),
    );

    
    setState(() {
      _mealNameController.clear();
      _ingredients.clear(); 
      _errorMessage = null;
    });
  } catch (e) {
  
    setState(() {
      _errorMessage = "Failed to save meal: $e";
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Meal"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _mealNameController,
              decoration: const InputDecoration(
                labelText: "Meal Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ingredientController,
                    decoration: const InputDecoration(
                      labelText: "Ingredient",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _addIngredient,
                  icon: const Icon(Icons.add),
                  tooltip: "Add Ingredient",
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _ingredients.length,
                itemBuilder: (context, index) {
                  final ingredient = _ingredients[index];
                  return ListTile(
                    title: Text(ingredient),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _ingredients.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _submitMeal,
                child: const Text("Save Meal"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
