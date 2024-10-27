import 'package:get_it/get_it.dart';
import 'package:meal_recommendations/features/auth/Login_Screen/presenation/controller/Login_bloc/bloc/Login%20BLoc.dart';

import '../../features/auth/Login_Screen/data/data_source/LoginDataSourceImpl.dart';
import '../../features/auth/Login_Screen/data/repository/LoginRepositoryImpl.dart';
import '../../features/auth/Login_Screen/domain/repositories/BaseLoginDataSource.dart';
import '../../features/auth/Login_Screen/domain/repositories/BaseLoginRepository.dart';

final GetIt di = GetIt.instance;

void setupServiceLocator() {
  //data source
  di.registerLazySingleton<BaseLoginDataSource>(() => LoginDataSourceImpl());

  //  repositories


  di.registerLazySingleton<BaseLoginRepository>(
        () => LoginRepositoryImpl(loginDataSource: di<BaseLoginDataSource>()),
  );



  //  use cases





  //  blocs or cubits


  di.registerLazySingleton<LoginBloc>(() =>
  (LoginBloc()));

  //External Libraries like dio





}