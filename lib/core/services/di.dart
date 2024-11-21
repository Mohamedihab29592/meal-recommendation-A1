import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:meal_recommendations/features/SeeAllScreen/data/data_source/SeeallDataSourceImpl.dart';
import 'package:meal_recommendations/features/SeeAllScreen/data/repository/SeeAllRepositoryImpl.dart';
import 'package:meal_recommendations/features/SeeAllScreen/domain/repositories/BaseSeeAllDataSource.dart';
import 'package:meal_recommendations/features/SeeAllScreen/domain/repositories/BaseSeeAllRepository.dart';
import 'package:meal_recommendations/features/auth/Login_Screen/data/data_source/LoginDataSourceImpl.dart';
import 'package:meal_recommendations/features/home/businessLogic/meal_cubit.dart';
import 'package:meal_recommendations/features/home/data/data_source.dart';
import 'package:meal_recommendations/features/favourite/data/repository/fetch_save_meal_repo_impl.dart';
import 'package:meal_recommendations/features/favourite/domain/repositories/fetch_save_fav_repository.dart';
import 'package:meal_recommendations/features/favourite/domain/use_cases/fetch_save_fav_use_case.dart';
import 'package:meal_recommendations/features/home/domain/add_meal_repository.dart';
import 'package:meal_recommendations/features/home/domain/usecases/meal_usecase.dart';
import 'package:meal_recommendations/features/layout/presentation/blocs/layout_bloc.dart';
import 'package:meal_recommendations/features/auth/register/data/data_source/data_source.dart';
import 'package:meal_recommendations/features/auth/register/domain/base_repo/user_repo.dart';
import 'package:meal_recommendations/features/auth/register/persentation/controller/sign_up_bloc.dart';
import 'package:meal_recommendations/features/auth/Login_Screen/presenation/controller/Login_bloc/bloc/Login%20BLoc.dart';
import 'package:meal_recommendations/features/profile/data/profile_repository_impl.dart';
import 'package:meal_recommendations/features/profile/data/remote/profile_data_source.dart';
import 'package:meal_recommendations/features/profile/data/remote/profile_data_source_impl.dart';
import 'package:meal_recommendations/features/profile/domain/profile_repository.dart';
import 'package:meal_recommendations/features/profile/domain/usecases/change_password_use_case.dart';
import 'package:meal_recommendations/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:meal_recommendations/features/profile/domain/usecases/logout_use_case.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_bloc.dart';
import 'package:meal_recommendations/features/sidebar/data/data_source/remote_data_source.dart';
import 'package:meal_recommendations/features/sidebar/data/repoImp/repo_imp.dart';
import 'package:meal_recommendations/features/sidebar/domain/repo/sidebar_repo.dart';
import 'package:meal_recommendations/features/sidebar/presentation/controller/bloc/side_bloc.dart';
import '../../features/auth/Login_Screen/data/repository/LoginRepositoryImpl.dart';
import '../../features/auth/Login_Screen/domain/repositories/BaseLoginDataSource.dart';
import '../../features/auth/Login_Screen/domain/repositories/BaseLoginRepository.dart';
import '../../features/auth/register/data/repo/repo.dart';

import '../../features/favourite/presentation/controller/fav_meal_bloc.dart';
import '../../features/home/data/add_meal_repository_impl.dart';

final GetIt di = GetIt.instance;

void setupServiceLocator() {

  //data source
  di.registerLazySingleton<RemoteDataSourceFirebase>(
      () => RemoteDataSourceFirebase());

          ()=> RemoteDataSourceFirebase();
  di.registerLazySingleton<RemoteSideBarDataSource>(
          ()=> RemoteSideBarDataSource());

  di.registerLazySingleton<BaseLoginDataSource>(() => LoginDataSourceImpl());
  di.registerLazySingleton<BaseSeeAllDataSource>(() => SeeAllDataSourceImpl());


  //  repositories
  di.registerLazySingleton<UserRepository>(
          ()=> UserRepositoryImpl(di())
  );


  di.registerLazySingleton<BaseLoginRepository>(
        () => LoginRepositoryImpl(loginDataSource: di()),
  );
  di.registerLazySingleton<BaseSeeAllRepository>(
        () => SeeAllRepositoryImpl(seeAllDataSource: di()),
  );
  di.registerLazySingleton<SidebarRepo>(
        () => SidebarRepoImp(di()),
  );

  // Register Repository
  di.registerLazySingleton<FetchAndSaveFavMealsRepository>(
        () => MealRepositoryImpl(di<FirebaseFirestore>()),
  );

  // Register Use Case
  di.registerLazySingleton<FetchAndSaveFavMealsUseCase>(
        () => FetchAndSaveFavMealsUseCase(di<FetchAndSaveFavMealsRepository>()),
  );



  //  use cases
 // Register MealRepository
  di.registerLazySingleton<AddMealRepository>(() => AddMealRepositoryImpl(FirebaseFirestore.instance));

  // Register MealUseCase, which depends on MealRepository
  di.registerLazySingleton<MealUseCase>(() => MealUseCase(di<AddMealRepository>()));

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
  () => ProfileDataSourceImpl(FirebaseFirestore.instance, di<ChangePasswordUseCase>()),
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
  () => ProfileBloc(di<GetUserProfileUseCase>(), di<ChangePasswordUseCase>(),
   di<LogoutUseCase>(),
   ),
);
di.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase());


  //  blocs or cubits
  _setupForBlocs();
  di.registerLazySingleton<UserBloc>(() => UserBloc(di()));


  di.registerLazySingleton<LoginBloc>(
      () => (LoginBloc(di.get<BaseLoginRepository>())));
  // note :: here meal bloc of favourite screen
  di.registerFactory<FavMealBloc>(() => FavMealBloc(di<FetchAndSaveFavMealsUseCase>()));





  di.registerLazySingleton<SideBarBloc>(() =>
  (SideBarBloc(di())));


  //External Libraries like dio
  di.registerLazySingleton<FirebaseService>(() => FirebaseService());

  di.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

}

void _setupForBlocs() {
  di.registerLazySingleton<LayoutBloc>(() => LayoutBloc());
}




