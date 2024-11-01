import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
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
import '../../features/favourite/data/repository/local/meal_local_repository.dart';
import '../../features/favourite/data/repository/remote/meal_remote_repository.dart';
import '../../features/favourite/presentation/controller/fav_meal_bloc.dart';

final GetIt di = GetIt.instance;

void setupServiceLocator() {

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

  di.registerLazySingleton<MealLocalRepository>(
          ()=> MealLocalRepository()
  );

  di.registerLazySingleton<MealRemoteRepository>(
          ()=> MealRemoteRepository()
  );
  di.registerLazySingleton<BaseLoginDataSource>(() => LoginDataSourceImpl());

  //  use cases





  //  blocs or cubits
  _setupForBlocs();
  di.registerLazySingleton<UserBloc>(() => UserBloc(di()));

  di.registerLazySingleton<LoginBloc>(
      () => (LoginBloc(di.get<BaseLoginRepository>())));
  // note :: here meal bloc of favourite screen
  di.registerLazySingleton<MealBloc>(() => MealBloc(di<MealLocalRepository>(), di<MealRemoteRepository>()));



  //External Libraries like dio

  di.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

}

void _setupForBlocs() {
  di.registerLazySingleton<LayoutBloc>(() => LayoutBloc());
}




