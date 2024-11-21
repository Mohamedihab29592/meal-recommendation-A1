import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:meal_recommendations/features/SeeAllScreen/presentation/Widgets/Recommended%20Recipes%20Item.dart';
import 'package:meal_recommendations/features/SeeAllScreen/presentation/Widgets/Trending%20Recipes%20Item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redacted/redacted.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_text_styles.dart';
import '../../../home/data/data_source.dart';
import '../../../home/persentation/businessLogic/meal_cubit.dart';
import '../../domain/repositories/BaseSeeAllRepository.dart';
import '../Widgets/LoadingScreen.dart';
import '../controller/Bloc/SeeAll BLoc.dart';
import '../controller/State/SeeAll events.dart';
import '../controller/State/SeeAll state.dart';

class SeeAllScreen extends StatelessWidget {
  final BaseSeeAllRepository seeAllRepository;

  const SeeAllScreen({super.key, required this.seeAllRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon:  Icon(Icons.arrow_back_ios_new_outlined
            ,
            color: AppColors.primaryColor,
            size: MediaQuery.of(context).size.width * 0.073,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.mealSuggestion);
              },
              icon: Icon(
                FontAwesomeIcons.robot,
                color: AppColors.primaryColor,
                size: MediaQuery.of(context).size.width * 0.073,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<SeeAllBloc, SeeAllStates>(
        builder: (context, state) {
          if (state is SeeAllLoadingState) {
            return LoadingSeeAllScreen()
                .redacted(context: context, redact: true);
          } else if (state is SeeAllSuccessState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Text(
                  ' Trending Recipes',
                  style: AppTextStyles.font21BoldDarkBlue,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.24,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.meals.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TrendingRecipesItem(
                          meal: state.meals[index],
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  ' Recommended for you',
                  style: AppTextStyles.font21BoldDarkBlue,
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.meals.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 11),
                          child: RecommendedRecipesItem(
                            meal: state.meals[index],
                          ));
                    },
                  ),
                ),
              ],
            );
          } else if (state is SeeAllSErrorState) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          return const Center(child: Text("No data available"));
        },
      ),
    );
  }
}
