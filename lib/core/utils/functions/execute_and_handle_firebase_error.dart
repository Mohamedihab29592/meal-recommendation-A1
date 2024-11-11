import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/firebase/firebase_error_handler.dart';
import 'package:meal_recommendations/core/firebase/firebase_error_model.dart';
import 'package:meal_recommendations/core/network/internet_checker.dart';
import 'package:meal_recommendations/core/services/di.dart';
import 'package:meal_recommendations/core/utils/strings.dart';

Future<Either<FirebaseErrorModel, T>> executeAndHandleFirebaseErrors<T>(
  Future Function() function,
) async {
  if (await di.get<InternetChecker>().isConnected) {
    try {
      final T response = await function();
      return Right(response);
    } catch (error) {
      debugPrint('********* Firebase error: $error ***********');

      return Left(FirebaseErrorHandler.handleError(error));
    }
  } else {
    return Left(
      FirebaseErrorHandler.handleError(AppStrings.noInternetConnection),
    );
  }
}
