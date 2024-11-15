import 'package:dartz/dartz.dart';
import 'package:meal_recommendations/core/firebase/firebase_error_model.dart';
import 'package:meal_recommendations/core/models/meal.dart';
import 'package:meal_recommendations/features/SeeAllScreen/domain/repositories/BaseSeeAllDataSource.dart';
import 'package:meal_recommendations/features/SeeAllScreen/domain/repositories/BaseSeeAllRepository.dart';

class SeeAllRepositoryImpl implements BaseSeeAllRepository {
  BaseSeeAllDataSource seeAllDataSource;
  SeeAllRepositoryImpl({required this.seeAllDataSource});
  @override
  Future<Either<FirebaseErrorModel, List<Meal>>> FetchTrendingRecipes() async {
    final response = await seeAllDataSource.FetchTrendingRecipes();
    return response.fold((error) => Left(error), (response) => Right(response));
  }
}
