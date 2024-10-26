import 'package:get_it/get_it.dart';
import 'package:meal_recommendations/features/layout/presentation/blocs/layout_bloc.dart';

final GetIt di = GetIt.instance;

void setupServiceLocator() {
  //  repositories

  //  use cases

  //  blocs or cubits
  _setupForBlocs();

  //External Libraries like dio
}

void _setupForBlocs() {
  di.registerLazySingleton<LayoutBloc>(() => LayoutBloc());
}
