import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meal_recommendations/features/home/data/local_data.dart';
import 'package:meta/meta.dart';
import '../../../../core/models/meal.dart';
import '../data/data_source.dart';
part 'meal_state.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class MealCubit extends Cubit<MealState> {
  final FirebaseService firebaseService;
  MealCubit(this.firebaseService) : super(MealInitial()) {
    _listenToMeals();
  }

  List<Meal> myMeals = [];

  Future<void> fetchMeals() async {
    try {
      emit(MealLoading());
      myMeals = await firebaseService.fetchMeals();
      emit(MealLoaded(myMeals));
    } catch (e) {
      emit(MealError('Error loading meals'));
    }
  }

  void filterMealsList(String searchQuery) {
    if (searchQuery.isEmpty) {
      emit(MealLoaded(myMeals));
    } else {
      final filteredList = myMeals
          .where((meal) =>
              meal.name?.toLowerCase().contains(searchQuery.toLowerCase()) ??
              false)
          .toList();
      emit(MealLoaded(filteredList));
    }
  }

  void _listenToMeals() {
    FirebaseFirestore.instance
        .collection('meals')
        .snapshots()
        .listen((snapshot) {
      final updatedMeals = snapshot.docs.map((doc) {
        return Meal.fromJson(doc.data());
      }).toList();
      myMeals = updatedMeals;
      emit(MealLoaded(myMeals));
    });
  }

  Future<String?> fetchSpecificMealId(String dishName) async {
    QuerySnapshot snapshot = await _fireStore
        .collection('meals')
        .where('dish_name', isEqualTo: dishName)
        .get();

    if (snapshot.docs.isNotEmpty) {
      String docId = snapshot.docs.first.id;
      if (kDebugMode) {
        print('Document ID for "$dishName": $docId');
      }
      return docId;
    } else {
      if (kDebugMode) {
        print('No document found with the dish_name "$dishName"');
      }
      return null;
    }
  }

  Future<void> updateIsFavInFireStore(String dishName, bool isFav) async {
    final docId = await fetchSpecificMealId(dishName);
    if (docId != null) {
      await _fireStore
          .collection('meals')
          .doc(docId)
          .update({'is_favourite': !isFav})
          .then((_) => debugPrint("Is Fav updated successfully"))
          .catchError(
              (error) => debugPrint("Failed to update is_favourite: $error"));
    } else {
      if (kDebugMode) {
        print("Document ID not found for the dish: $dishName");
      }
    }
  }

  Future<void> addFavMeal(Meal meal) async {
    final docId = await fetchSpecificMealId(meal.dishName ?? '');
    if (docId != null) {
      await updateIsFavInFireStore(meal.dishName ?? '', false);
      LocalData().addMealToFav(meal);
    } else {
      debugPrint(
          "Failed to add meal to favorites because it does not exist in FireStore");
    }
  }

  Future<void> removeFavMeal(Meal meal) async {
    final docId = await fetchSpecificMealId(meal.dishName ?? '');
    if (docId != null) {
      await updateIsFavInFireStore(meal.dishName ?? '', true);
      LocalData().removeFavMeal(meal);
    } else {
      debugPrint(
          "Failed to add meal to favorites because it does not exist in FireStore");
    }
  }
}
