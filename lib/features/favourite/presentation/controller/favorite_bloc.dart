import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/features/favourite/data/repository/favourite_repository.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository favoriteRepository;

  FavoriteBloc(this.favoriteRepository) : super(FavoriteInitial()) {
    on<FetchFavorites>(_onFetchFavorites);
    on<RemoveFavorite>(_onRemoveFavorite);

    add(FetchFavorites());
  }

  void _onFetchFavorites(FetchFavorites event, Emitter<FavoriteState> emit) async {
    try {
      emit(FavoriteLoading());
      final favoriteMeals = await favoriteRepository.fetchFavorites();
      emit(FavoriteLoaded(favoriteMeals));
    } catch (e) {
      emit(const FavoriteError('Failed to fetch favorites'));
    }
  }

  void _onRemoveFavorite(RemoveFavorite event, Emitter<FavoriteState> emit) async {
    try {
      await favoriteRepository.removeFavorite(event.meal);
      add(FetchFavorites()); // Refresh the favorite list after removal
    } catch (e) {
      emit(const FavoriteError('Failed to remove favorite'));
    }
  }
}
