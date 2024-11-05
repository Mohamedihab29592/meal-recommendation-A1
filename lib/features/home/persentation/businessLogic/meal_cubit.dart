import 'package:bloc/bloc.dart';
import 'package:meal_recommendations/features/home/data/local_data.dart';
import 'package:meta/meta.dart';
import '../../../../core/models/meal.dart';
import '../../domain/usecase/add_meal_to_fav.dart';
import '../../domain/usecase/fetch_meals.dart';
import '../../domain/usecase/firestore_usecase.dart';
import '../../domain/usecase/remove_meal.dart';

part 'meal_state.dart';

class MealCubit extends Cubit<MealState> {
  final FetchMeals fetchMealsUseCase;
  final AddMealToFav addMealToFavoritesUseCase;
  final RemoveMeal removeFavoriteMealUseCase;
  final UpdateIsFavInFirestore updateIsFavUseCase;

  MealCubit(
      {required this.fetchMealsUseCase,
      required this.addMealToFavoritesUseCase,
      required this.removeFavoriteMealUseCase,
      required this.updateIsFavUseCase,
      required LocalData localData})
      : super(MealInitial()) {
    _listenToMeals();
  }

  List<Meal> myMeals = [];

  Future<void> fetchMeals() async {
    try {
      emit(MealLoading());
      myMeals = await fetchMealsUseCase();
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
    fetchMealsUseCase.listenToMeals().listen((updatedMeals) {
      myMeals = updatedMeals;
      emit(MealLoaded(myMeals));
    });
  }

  Future<void> updateIsFavInFireStore(String dishName, bool isFav) async {
    try {
      await updateIsFavUseCase(dishName, isFav);
      print("Is Fav updated successfully in FireStore");
    } catch (e) {
      print("Failed to update is_favourite: $e");
    }
  }

  Future<void> addFavMeal(Meal meal) async {
    try {
      await updateIsFavInFireStore(meal.dishName!, meal.isFavourite);
      await addMealToFavoritesUseCase(meal);
      emit(MealLoaded([...myMeals, meal]));
    } catch (e) {
      print("Failed to add meal to favorites: $e");
    }
  }

  Future<void> removeFavMeal(Meal meal) async {
    try {
      await updateIsFavUseCase(meal.dishName!, meal.isFavourite);
      await removeFavoriteMealUseCase(meal);
      emit(MealLoaded([...myMeals]));
    } catch (e) {
      print("Failed to remove meal from favorites: $e");
    }
  }
}
