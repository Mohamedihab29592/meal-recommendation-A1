import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/features/SeeAllScreen/domain/repositories/BaseSeeAllRepository.dart';
import 'package:meal_recommendations/features/SeeAllScreen/presentation/controller/State/SeeAll events.dart';
import 'package:meal_recommendations/features/SeeAllScreen/presentation/controller/State/SeeAll state.dart';

class SeeAllBloc extends Bloc<SeeAllEvent, SeeAllStates> {
BaseSeeAllRepository seeAllRepository;

  SeeAllBloc(this.seeAllRepository) : super(SeeAllInitialState()) {
    on<FetchTrendingRecipesEvent>((event, emit) async {
      emit(SeeAllLoadingState());
      try {
    var either=await seeAllRepository.FetchTrendingRecipes();

        await either.fold((l) {
          emit(SeeAllSErrorState(l.error));
        }, (response) async {
emit(SeeAllSuccessState(meals: response));
        });
      } catch (e) {
        emit(SeeAllSErrorState('An unexpected error occurred: ${e.toString()}'));
      }
    });

  }


}
