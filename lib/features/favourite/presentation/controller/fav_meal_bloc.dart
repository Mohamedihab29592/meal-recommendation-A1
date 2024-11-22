

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/core/utils/strings.dart';
import 'package:meal_recommendations/features/favourite/domain/use_cases/fetch_save_fav_use_case.dart';
import 'package:meal_recommendations/features/favourite/presentation/controller/fav_meal_event.dart';
import 'package:meal_recommendations/features/favourite/presentation/controller/fav_meal_state.dart';
import 'package:meal_recommendations/features/home/data/local_data.dart';

class FavMealBloc extends Bloc<FavMealEvent, FavMealState> {
  final FetchAndSaveFavMealsUseCase fetchAndSaveFavMealsUseCase;

  FavMealBloc(this.fetchAndSaveFavMealsUseCase) : super(FavMealInitial()) {
    on<FetchAndSaveFavMealsEvent>(_onFetchAndSaveFavMeals);
    on<RemoveFavMealEvent>(_onRemoveFavMeal);
  }

  Future<void> _onFetchAndSaveFavMeals(
      FetchAndSaveFavMealsEvent event, Emitter<FavMealState> emit) async {
    try {
      emit(FavMealLoading());
      final favMeals = await fetchAndSaveFavMealsUseCase();
      emit(FavMealLoaded(favMeals));
    } catch (e) {
      emit(const FavMealError(AppStrings.errorFetching));
    }
  }

  Future<void> _onRemoveFavMeal(
      RemoveFavMealEvent event, Emitter<FavMealState> emit) async {
    try {
      // Emit loading state for visual feedback
      emit(FavMealLoading());

      // Fetch document ID from Firestore
      final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
      final docId = await _fetchSpecificMealId(event.meal.dishName ?? '', _fireStore);

      if (docId != null) {
        // Update Firestore
        await _fireStore
            .collection('meals')
            .doc(docId)
            .update({'is_favourite': false})
            .then((_) => debugPrint("Meal removed from Firestore"))
            .catchError(
                (error) => debugPrint("Failed to update Firestore: $error"));

        // Remove from local storage
        LocalData().removeFavMeal(event.meal);

        // Only proceed if the current state is FavMealLoaded
        if (state is FavMealLoaded) {
          final updatedFavMeals = (state as FavMealLoaded)
              .meals
              .where((meal) => meal.dishName != event.meal.dishName)
              .toList();

          // Emit updated list
          emit(FavMealLoaded(updatedFavMeals));
        } else {
          // If state isn't loaded, fetch the updated favorites again
          final favMeals = await fetchAndSaveFavMealsUseCase();
          emit(FavMealLoaded(favMeals));
        }
      } else {
        debugPrint("Failed to find the meal in Firestore.");
        emit(const FavMealError(AppStrings.errorFetching));
      }
    } catch (e) {
      debugPrint("Error removing meal: $e");
      emit(const FavMealError("error"));
    }
  }

  Future<String?> _fetchSpecificMealId(
      String dishName, FirebaseFirestore fireStore) async {
    QuerySnapshot snapshot = await fireStore
        .collection('meals')
        .where('dish_name', isEqualTo: dishName)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.id;
    } else {
      return null;
    }
  }
}