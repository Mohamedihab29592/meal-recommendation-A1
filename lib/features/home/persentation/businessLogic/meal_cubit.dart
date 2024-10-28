import 'package:bloc/bloc.dart';
import 'package:meal_recommendations/features/home/data/local_data.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/meal.dart';
import '../../data/data_source.dart';

part 'meal_state.dart';

class MealCubit extends Cubit<MealState> {
  final FirebaseService firebaseService;

  MealCubit(this.firebaseService) : super(MealInitial());
  List<Meal> myMeals = [];

  Future<void> fetchMeals() async {
    try {
      emit(MealLoading());
      myMeals = await firebaseService.fetchMeals();
      if (myMeals.isEmpty) {
        emit(MealLoaded([]));
      } else {
        emit(MealLoaded(myMeals));
      }
    } catch (e) {
      emit(MealError('Error loading meals'));
    }
  }

  filterMealsList(String searchQuery) {
    if (searchQuery.isEmpty) {
      emit(MealLoaded(myMeals));
    } else {
      final filteredList = myMeals
          .where((meal) =>
              meal.name!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
      emit(MealLoaded(filteredList));
    }
  }

  addFavMeal(Meal meal) {
    LocalData().addMealToFav(meal);
  }
}
