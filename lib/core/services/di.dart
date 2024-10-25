import 'package:get_it/get_it.dart';
import 'package:meal_recommendations/features/auth/register/data/data_source/data_source.dart';
import 'package:meal_recommendations/features/auth/register/data/repo/repo.dart';
import 'package:meal_recommendations/features/auth/register/domain/base_repo/user_repo.dart';
import 'package:meal_recommendations/features/auth/register/domain/use_cases/sign_up.dart';
import 'package:meal_recommendations/features/auth/register/persentation/controller/sign_up_bloc.dart';

final GetIt di = GetIt.instance;

void setupServiceLocator() {
  di.registerLazySingleton<RemoteDataSourceFirebase>(
          ()=> RemoteDataSourceFirebase());

  //  repositories
  di.registerLazySingleton<UserRepository>(
          ()=> UserRepositoryImpl(di())
  );
  //  use cases
  di.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(di())
  );
  
  //  blocs or cubits
  di.registerLazySingleton<UserBloc>(
          ()=> UserBloc(di())
  );



  //External Libraries like dio



}