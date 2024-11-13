import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:meal_recommendations/core/firebase/firebase_error_model.dart';
import 'package:meal_recommendations/core/models/meal.dart';
import 'package:meal_recommendations/features/SeeAllScreen/domain/repositories/BaseSeeAllDataSource.dart';
import 'package:meal_recommendations/features/home/data/data_source.dart';

class SeeAllDataSourceImpl implements BaseSeeAllDataSource {

 final firebaseService= GetIt.instance<FirebaseService>();
 @override
 Future<Either<FirebaseErrorModel, List<Meal>>> FetchTrendingRecipes() async {
   try {
     List<Meal> meals = await firebaseService.fetchMeals();
     return Right(meals);
   } catch (e) {
     return Left(FirebaseErrorModel(error: e.toString()));
   }
 }


}





