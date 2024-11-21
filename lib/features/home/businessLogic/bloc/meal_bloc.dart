import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/features/home/businessLogic/bloc/meal_event_bloc.dart';
import 'package:meal_recommendations/features/home/businessLogic/bloc/meal_state_bloc.dart';
import 'package:meal_recommendations/features/home/data/local_data.dart';
import 'package:meal_recommendations/features/home/domain/usecases/meal_usecase.dart';
import 'package:meal_recommendations/core/models/meal.dart';


class MealBloc extends Bloc<MealEvent, MealState> {
  final MealUseCase mealUseCase;

  MealBloc(this.mealUseCase) : super(MealInitial()) {
    on<FetchMeals>(_onFetchMeals);
    on<AddMeal>(_onAddMeal);
    on<DeleteMeal>(_onDeleteMeal);
    on<UpdateIsFav>(_onUpdateIsFav);
    on<RemoveFavMeal>(_onRemoveFavMeal);
  }

  Future<void> _onFetchMeals(FetchMeals event, Emitter<MealState> emit) async {
    emit(MealLoading());
    try {
      final meals = await mealUseCase.fetchUserMeals(event.userId);
      debugPrint('Meals fetched: $meals');
      emit(MealLoaded(meals));
    } catch (e) {
      emit(MealError('Failed to fetch meals: $e'));
    }
  }

  Future<void> _onAddMeal(AddMeal event, Emitter<MealState> emit) async {
    try {
      await mealUseCase.addMeal(event.userId, event.meal);
      add(FetchMeals(event.userId)); // Trigger fetching updated meals
    } catch (e) {
      emit(MealError('Failed to add meal: $e'));
    }
  }

  Future<void> _onDeleteMeal(DeleteMeal event, Emitter<MealState> emit) async {
    try {
      await mealUseCase.deleteMeal(event.userId, event.mealId);
      add(FetchMeals(event.userId)); // Trigger fetching updated meals
    } catch (e) {
      emit(MealError('Failed to delete meal: $e'));
    }
  }

  Future<void> _onUpdateIsFav(UpdateIsFav event, Emitter<MealState> emit) async {
    try {
      await updateIsFavInFireStore(event.dishName, event.isFav);
      add(FetchMeals(event.userId)); // Optionally refresh meal list after updating favorite
    } catch (e) {
      emit(MealError('Failed to update favorite status: $e'));
    }
  }

  Future<void> _onRemoveFavMeal(RemoveFavMeal event, Emitter<MealState> emit) async {
    try {
      await removeFavMeal(event.meal);
      add(FetchMeals(event.userId)); // Optionally refresh meal list after removing favorite
    } catch (e) {
      emit(MealError('Failed to remove favorite meal: $e'));
    }
  }

  // Fetch meals from Firestore
  Future<List<Meal>> fetchUserMeals(String userId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('meals')
          .get();

      final meals = snapshot.docs.map((doc) => Meal.fromDocument(doc)).toList();
      debugPrint('Fetched meals: $meals');
      return meals;
    } catch (e) {
      debugPrint('Error fetching meals: $e');
      throw Exception('Error fetching meals');
    }
  }

  // Update the favorite status of a meal in Firestore
  Future<void> updateIsFavInFireStore(String dishName, bool isFav) async {
    final docId = await fetchSpecificMealId(dishName);
    if (docId != null) {
      await FirebaseFirestore.instance
          .collection('meals')
          .doc(docId)
          .update({'is_favourite': !isFav})
          .then((_) => debugPrint("Is Fav updated successfully"))
          .catchError((error) => debugPrint("Failed to update is_favourite: $error"));
    } else {
      debugPrint("Document ID not found for the dish: $dishName");
    }
  }

  // Remove the meal from the favorites in Firestore
  Future<void> removeFavMeal(Meal meal) async {
    final docId = await fetchSpecificMealId(meal.dishName ?? '');
    if (docId != null) {
      await updateIsFavInFireStore(meal.dishName ?? '', true);
      LocalData().removeFavMeal(meal);
    } else {
      debugPrint("Failed to remove meal from favorites because it does not exist in FireStore");
    }
  }

  // Fetch specific meal document ID based on dish name
  Future<String?> fetchSpecificMealId(String dishName) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('meals')
          .where('dish_name', isEqualTo: dishName)
          .limit(1)
          .get();
      
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.id;
      } else {
        debugPrint("Meal not found for dish: $dishName");
        return null;
      }
    } catch (e) {
      debugPrint("Error fetching meal ID: $e");
      return null;
    }
  }
}
