import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/core/helpers/secure_storage_helper.dart';
import 'package:meal_recommendations/core/services/di.dart';
import 'package:meal_recommendations/features/home/businessLogic/meal_bloc.dart';
import 'package:meal_recommendations/features/home/businessLogic/meal_event_bloc.dart';
import 'package:meal_recommendations/features/home/businessLogic/meal_state_bloc.dart';
import 'package:meal_recommendations/features/home/domain/usecases/meal_usecase.dart';
import 'package:meal_recommendations/features/home/persentation/add_meal_screen.dart';

class MealWidget extends StatelessWidget {
  const MealWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: SecureStorageHelper.getSecuredString('userId'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No user data found'));
        }

        final userId = snapshot.data!;

        return BlocProvider(
          create: (_) => MealBloc(di<MealUseCase>())..add(FetchMeals(userId)),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Meals'),
            ),
            body: BlocBuilder<MealBloc, MealState>(
              builder: (context, state) {
                if (state is MealLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MealLoaded) {
                  return ListView.builder(
                    itemCount: state.meals.length,
                    itemBuilder: (context, index) {
                      final meal = state.meals[index];
                      return ListTile(
                        title: Text(meal.dishName ?? 'No name available'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            BlocProvider.of<MealBloc>(context).add(
                              DeleteMeal(userId, meal.id ?? ''),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else if (state is MealError) {
                  return Center(child: Text(state.error));
                }
                return const Center(child: Text('No meals available'));
              },
            ),
            
          ),
        );
      },
    );
  }

 
}
