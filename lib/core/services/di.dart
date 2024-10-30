import 'package:get_it/get_it.dart';
import 'package:meal_recommendations/features/layout/presentation/blocs/layout_bloc.dart';
import 'package:meal_recommendations/features/auth/register/data/data_source/data_source.dart';
import 'package:meal_recommendations/features/auth/register/data/repo/repo.dart';
import 'package:meal_recommendations/features/auth/register/domain/base_repo/user_repo.dart';
import 'package:meal_recommendations/features/auth/register/persentation/controller/sign_up_bloc.dart';
import 'package:meal_recommendations/features/auth/Login_Screen/presenation/controller/Login_bloc/bloc/Login%20BLoc.dart';
import 'package:meal_recommendations/features/sidebar/data/data_source/remote_data_source.dart';
import 'package:meal_recommendations/features/sidebar/data/repoImp/repo_imp.dart';
import 'package:meal_recommendations/features/sidebar/domain/repo/sidebar_repo.dart';
import 'package:meal_recommendations/features/sidebar/presentation/controller/bloc/side_bloc.dart';

import '../../features/auth/Login_Screen/data/data_source/LoginDataSourceImpl.dart';
import '../../features/auth/Login_Screen/data/repository/LoginRepositoryImpl.dart';
import '../../features/auth/Login_Screen/domain/repositories/BaseLoginDataSource.dart';
import '../../features/auth/Login_Screen/domain/repositories/BaseLoginRepository.dart';

final GetIt di = GetIt.instance;

void setupServiceLocator() {

  //data source
  di.registerLazySingleton<RemoteDataSourceFirebase>(
          ()=> RemoteDataSourceFirebase());
  di.registerLazySingleton<RemoteSideBarDataSource>(
          ()=> RemoteSideBarDataSource());

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



  //  use cases





  //  blocs or cubits
  _setupForBlocs();
  di.registerLazySingleton<UserBloc>(
          ()=> UserBloc(di())
  );


  di.registerLazySingleton<LoginBloc>(() =>
  (LoginBloc()));
  di.registerLazySingleton<SideBarBloc>(() =>
  (SideBarBloc(di())));

  //External Libraries like dio
}

void _setupForBlocs() {
  di.registerLazySingleton<LayoutBloc>(() => LayoutBloc());
}




