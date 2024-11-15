import 'package:dartz/dartz.dart';
import 'package:meal_recommendations/core/firebase/firebase_error_model.dart';
import 'package:meal_recommendations/features/SeeAllScreen/presentation/controller/State/SeeAll events.dart';

import '../../../../core/models/meal.dart';

abstract class BaseSeeAllRepository {
Future<Either<FirebaseErrorModel,List<Meal>>>  FetchTrendingRecipes();

}