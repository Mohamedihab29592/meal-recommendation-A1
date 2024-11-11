import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:meal_recommendations/core/network/internet_checker.dart';
import 'package:meal_recommendations/features/auth/login/data/data_source/login_datasource.dart';
import 'package:meal_recommendations/features/auth/login/presenation/bloc/login_bloc.dart';
import 'package:meal_recommendations/features/auth/register/data/repo/repo.dart';
import 'package:meal_recommendations/features/layout/presentation/blocs/layout_bloc.dart';
import 'package:meal_recommendations/features/auth/register/data/data_source/data_source.dart';
import 'package:meal_recommendations/features/auth/register/domain/base_repo/user_repo.dart';
import 'package:meal_recommendations/features/auth/register/persentation/controller/sign_up_bloc.dart';
import 'package:meal_recommendations/features/profile/data/profile_repository_impl.dart';
import 'package:meal_recommendations/features/profile/data/remote/profile_data_source.dart';
import 'package:meal_recommendations/features/profile/data/remote/profile_data_source_impl.dart';
import 'package:meal_recommendations/features/profile/domain/profile_repository.dart';
import 'package:meal_recommendations/features/profile/domain/usecases/change_password_use_case.dart';
import 'package:meal_recommendations/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_bloc.dart';
import 'package:meal_recommendations/features/sidebar/data/data_source/remote_data_source.dart';
import 'package:meal_recommendations/features/sidebar/data/repoImp/repo_imp.dart';
import 'package:meal_recommendations/features/sidebar/domain/repo/sidebar_repo.dart';
import 'package:meal_recommendations/features/sidebar/presentation/controller/bloc/side_bloc.dart';

import '../../features/auth/login/data/repository/login_repo.dart';

import '../../features/favourite/data/repository/local/meal_local_repository.dart';
import '../../features/favourite/data/repository/remote/meal_remote_repository.dart';
import '../../features/favourite/presentation/controller/fav_meal_bloc.dart';

final GetIt di = GetIt.instance;

void setupServiceLocator() {
  _setupForCore();

  //data source
  di.registerLazySingleton<RemoteDataSourceFirebase>(
      () => RemoteDataSourceFirebase());

  () => RemoteDataSourceFirebase();
  di.registerLazySingleton<ProfileDataSource>(() => ProfileDataSourceImpl(
        di.get<FirebaseFirestore>(),
        di.get<ChangePasswordUseCase>(),
      ));
  () => RemoteDataSourceFirebase();
  di.registerLazySingleton<RemoteSideBarDataSource>(
      () => RemoteSideBarDataSource());

  di.registerLazySingleton<LoginDataSource>(
    () => LoginDataSource(di.get<FirebaseAuth>()),
  );

  //  repositories
  di.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(di()));

  di.registerLazySingleton<LoginRepo>(
    () => LoginRepo(di.get<LoginDataSource>()),
  );
  di.registerLazySingleton<SidebarRepo>(
    () => SidebarRepoImp(di()),
  );

  di.registerLazySingleton<MealLocalRepository>(() => MealLocalRepository());

  di.registerLazySingleton<MealRemoteRepository>(() => MealRemoteRepository());

  //  use cases

// Register FirebaseAuth
  di.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );

// Register ChangePasswordUseCase
  di.registerLazySingleton<ChangePasswordUseCase>(
    () => ChangePasswordUseCase(di<FirebaseAuth>()),
  );

// Register ProfileDataSourceImpl
  di.registerLazySingleton<ProfileDataSource>(
    () => ProfileDataSourceImpl(
        FirebaseFirestore.instance, di<ChangePasswordUseCase>()),
  );

// Register ProfileRepositoryImpl
  di.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(di<ProfileDataSource>()),
  );

// Register GetUserProfileUseCase
  di.registerLazySingleton<GetUserProfileUseCase>(
    () => GetUserProfileUseCase(di<ProfileRepository>()),
  );

// Register ProfileBloc
  di.registerLazySingleton<ProfileBloc>(
    () => ProfileBloc(di<GetUserProfileUseCase>(), di<ChangePasswordUseCase>()),
  );

  //  blocs or cubits
  _setupForBlocs();
  di.registerLazySingleton<UserBloc>(() => UserBloc(di()));

  // note :: here meal bloc of favourite screen
  di.registerLazySingleton<MealBloc>(
      () => MealBloc(di<MealLocalRepository>(), di<MealRemoteRepository>()));

  di.registerLazySingleton<SideBarBloc>(() => (SideBarBloc(di())));
  di.registerLazySingleton<ProfileBloc>(() =>
      ProfileBloc(di<GetUserProfileUseCase>(), di<ChangePasswordUseCase>()));
  di.registerLazySingleton<LoginBloc>(() => (LoginBloc(di.get<LoginRepo>())));
  // note :: here meal bloc of favourite screen
  di.registerLazySingleton<MealBloc>(
      () => MealBloc(di<MealLocalRepository>(), di<MealRemoteRepository>()));

  di.registerLazySingleton<SideBarBloc>(() => (SideBarBloc(di())));

  //External Libraries like dio

  _setupForExternal();
}

void _setupForExternal() {
  di.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  di.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  di.registerLazySingleton<InternetConnection>(() => InternetConnection());
}

void _setupForCore() {
  di.registerLazySingleton<InternetChecker>(
    () => InternetChecker(di.get<InternetConnection>()),
  );
}

void _setupForBlocs() {
  di.registerLazySingleton<LayoutBloc>(() => LayoutBloc());
}
