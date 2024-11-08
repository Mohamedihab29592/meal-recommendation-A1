import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meal_recommendations/core/models/meal.dart';
import 'package:meal_recommendations/features/favourite/data/repository/favourite_repository.dart';
import 'package:meal_recommendations/features/layout/presentation/blocs/layout_bloc.dart';
import 'package:meal_recommendations/features/auth/register/data/data_source/data_source.dart';
import 'package:meal_recommendations/features/auth/register/data/repo/repo.dart';
import 'package:meal_recommendations/features/auth/register/domain/base_repo/user_repo.dart';
import 'package:meal_recommendations/features/auth/register/persentation/controller/sign_up_bloc.dart';
import 'package:meal_recommendations/features/auth/Login_Screen/presenation/controller/Login_bloc/bloc/Login%20BLoc.dart';

import '../../features/auth/Login_Screen/data/data_source/LoginDataSourceImpl.dart';
import '../../features/auth/Login_Screen/data/repository/LoginRepositoryImpl.dart';
import '../../features/auth/Login_Screen/domain/repositories/BaseLoginDataSource.dart';
import '../../features/auth/Login_Screen/domain/repositories/BaseLoginRepository.dart';
import '../../features/favourite/presentation/controller/favorite_bloc.dart';

final GetIt di = GetIt.instance;

void setupServiceLocator()async {

  //data source
  di.registerLazySingleton<RemoteDataSourceFirebase>(
          ()=> RemoteDataSourceFirebase());

  di.registerLazySingleton<BaseLoginDataSource>(() => LoginDataSourceImpl());

  //  repositories
  di.registerLazySingleton<UserRepository>(
          ()=> UserRepositoryImpl(di())
  );


  di.registerLazySingleton<BaseLoginRepository>(
        () => LoginRepositoryImpl(loginDataSource: di<BaseLoginDataSource>()),
  );


  //  blocs or cubits
  _setupForBlocs();
  di.registerLazySingleton<UserBloc>(() => UserBloc(di()));

  di.registerLazySingleton<LoginBloc>(
      () => (LoginBloc(di.get<BaseLoginRepository>())));
  // note :: here meal bloc of favourite screen
  // di.registerLazySingleton<MealBloc>(() => MealBloc(di<MealLocalRepository>(), di<MealRemoteRepository>()));
  // Make sure you initialize Hive and open the box first
  await Hive.initFlutter();
  Box<Meal> favoriteBox = await Hive.openBox<Meal>('myFavMeals');

  // Register favorite box as a singleton
  di.registerLazySingleton(() => FavoriteRepository(favoriteBox));

  // Register FavoriteBloc with the Hive box
  di.registerFactory(() => FavoriteBloc(di.get<FavoriteRepository>()));



  //External Libraries like dio

  di.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

}

void _setupForBlocs() {
  di.registerLazySingleton<LayoutBloc>(() => LayoutBloc());
}




