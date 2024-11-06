import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:meal_recommendations/features/auth/Login_Screen/data/data_source/LoginDataSourceImpl.dart';
import 'package:meal_recommendations/features/layout/presentation/blocs/layout_bloc.dart';
import 'package:meal_recommendations/features/auth/register/data/data_source/data_source.dart';
import 'package:meal_recommendations/features/auth/register/domain/base_repo/user_repo.dart';
import 'package:meal_recommendations/features/auth/register/persentation/controller/sign_up_bloc.dart';
import 'package:meal_recommendations/features/auth/Login_Screen/presenation/controller/Login_bloc/bloc/Login%20BLoc.dart';
import 'package:meal_recommendations/features/profile/data/profile_repository_impl.dart';
import 'package:meal_recommendations/features/profile/data/remote/profile_data_source.dart';
import 'package:meal_recommendations/features/profile/data/remote/profile_data_source_impl.dart';
import 'package:meal_recommendations/features/profile/domain/profile_repository.dart';
import 'package:meal_recommendations/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_bloc.dart';
import 'package:meal_recommendations/features/sidebar/data/data_source/remote_data_source.dart';
import 'package:meal_recommendations/features/sidebar/data/repoImp/repo_imp.dart';
import 'package:meal_recommendations/features/sidebar/domain/repo/sidebar_repo.dart';
import 'package:meal_recommendations/features/sidebar/presentation/controller/bloc/side_bloc.dart';
import '../../features/auth/Login_Screen/data/repository/LoginRepositoryImpl.dart';
import '../../features/auth/Login_Screen/domain/repositories/BaseLoginDataSource.dart';
import '../../features/auth/Login_Screen/domain/repositories/BaseLoginRepository.dart';
import '../../features/auth/register/data/repo/repo.dart';
import '../../features/favourite/data/repository/local/meal_local_repository.dart';
import '../../features/favourite/data/repository/remote/meal_remote_repository.dart';
import '../../features/favourite/presentation/controller/fav_meal_bloc.dart';

final GetIt di = GetIt.instance;

void setupServiceLocator() {

  //data source
  di.registerLazySingleton<RemoteDataSourceFirebase>(
      () => RemoteDataSourceFirebase());
  di.registerLazySingleton<ProfileDataSource>(
      () => ProfileDataSourceImpl(di<FirebaseFirestore>()));
          ()=> RemoteDataSourceFirebase();
  di.registerLazySingleton<RemoteSideBarDataSource>(
          ()=> RemoteSideBarDataSource());

  di.registerLazySingleton<BaseLoginDataSource>(() => LoginDataSourceImpl());

  //  repositories
  di.registerLazySingleton<UserRepository>(
          ()=> UserRepositoryImpl(di())
  );


  di.registerLazySingleton<BaseLoginRepository>(
        () => LoginRepositoryImpl(loginDataSource: di()),
  );
  di.registerLazySingleton<SidebarRepo>(
        () => SidebarRepoImp(di()),
  );

  di.registerLazySingleton<MealLocalRepository>(
          ()=> MealLocalRepository()
  );

  di.registerLazySingleton<MealRemoteRepository>(
          ()=> MealRemoteRepository()
  );


  di.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(di<ProfileDataSource>()));
  //  use cases

  di.registerLazySingleton<GetUserProfileUseCase>(
      () => GetUserProfileUseCase(di<ProfileRepository>()));


  //  blocs or cubits
  _setupForBlocs();
  di.registerLazySingleton<UserBloc>(() => UserBloc(di()));

  di.registerLazySingleton<ProfileBloc>(
      () => ProfileBloc(di<GetUserProfileUseCase>()));
  di.registerLazySingleton<LoginBloc>(
      () => (LoginBloc(di.get<BaseLoginRepository>())));
  // note :: here meal bloc of favourite screen
  di.registerLazySingleton<MealBloc>(() => MealBloc(di<MealLocalRepository>(), di<MealRemoteRepository>()));



  di.registerLazySingleton<SideBarBloc>(() =>
  (SideBarBloc(di())));


  //External Libraries like dio

  di.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

}

void _setupForBlocs() {
  di.registerLazySingleton<LayoutBloc>(() => LayoutBloc());
}




