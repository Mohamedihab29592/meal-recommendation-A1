import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/features/favourite/data/repository/local/meal_local_repository.dart';
import 'package:meal_recommendations/features/favourite/data/repository/remote/meal_remote_repository.dart';
import 'package:meal_recommendations/features/favourite/presentation/controller/fav_meal_event.dart';
import 'package:meal_recommendations/features/favourite/presentation/controller/fav_meal_state.dart';


class MealBloc extends Bloc<MealEvent, MealState> {
  final MealLocalRepository localRepository;
  final MealRemoteRepository remoteRepository;

  MealBloc(this.localRepository, this.remoteRepository) : super(MealInitial()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<AddFavoriteEvent>(_onAddFavorite);
    on<RemoveFavoriteEvent>(_onRemoveFavorite);
  }

  Future<void> _onLoadFavorites(LoadFavoritesEvent event, Emitter<MealState> emit) async {
    emit(MealLoading());
    final localFavorites = localRepository.getFavorites();
    emit(MealLoaded(favorites: localFavorites));
  }

  Future<void> _onAddFavorite(AddFavoriteEvent event, Emitter<MealState> emit) async {
    await localRepository.saveFavorite(event.meal);
    await remoteRepository.saveFavoriteToFirebase(event.meal, event.userId);
    add(LoadFavoritesEvent());
  }

  Future<void> _onRemoveFavorite(RemoveFavoriteEvent event, Emitter<MealState> emit) async {
    await localRepository.removeFavorite(event.id);
    await remoteRepository.removeFavoriteFromFirebase(event.id, event.userId);
    add(LoadFavoritesEvent());
  }
}
