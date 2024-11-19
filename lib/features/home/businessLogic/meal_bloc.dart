import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:meal_recommendations/features/home/businessLogic/meal_event_bloc.dart';
import 'package:meal_recommendations/features/home/businessLogic/meal_state_bloc.dart';
import 'package:meal_recommendations/features/home/domain/usecases/meal_usecase.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  final MealUseCase mealUseCase;
  MealBloc(this.mealUseCase) : super(MealInitial()) {
    on<FetchMeals>(_onFetchMeals);
    on<AddMeal>(_onAddMeal);
    on<DeleteMeal>(_onDeleteMeal);
  }

  Future<void> _onFetchMeals(
      FetchMeals event, Emitter<MealState> emit) async {
    emit(MealLoading());
    try {
      final meals = await mealUseCase.fetchUserMeals(event.userId);
      emit(MealLoaded(meals));
    } catch (e) {
      emit(MealError('Failed to fetch meals'));
    }
  }

  // Future<void> _onAddMeal(AddMeal event, Emitter<MealState> emit) async {
  //   try {
  //     await mealUseCase.addMeal(event.userId, event.meal);
  //     add(FetchMeals(event.userId));
  //   } catch (e) {
  //     emit(MealError('Failed to add meal'));
  //   }
  // }

  Future<void> _onDeleteMeal(
      DeleteMeal event, Emitter<MealState> emit) async {
    try {
      await mealUseCase.deleteMeal(event.userId, event.mealId);
      add(FetchMeals(event.userId));
    } catch (e) {
      emit(MealError('Failed to delete meal'));
    }
  }
  Future<void> _onAddMeal(AddMeal event, Emitter<MealState> emit) async {
  try {
    final userId = event.userId;
    final meal = event.meal;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('add_meals')
        .add(meal);
    final mealBox = await Hive.openBox('meals_$userId');
    await mealBox.add(meal);

    // Refresh meals
    add(FetchMeals(userId));
  } catch (e) {
    emit(MealError('Failed to add meal: $e'));
  }
}
}