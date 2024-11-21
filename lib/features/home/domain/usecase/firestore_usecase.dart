import '../repo/meal_repo.dart';

class UpdateIsFavInFirestore {
  final MealRepository repository;

  UpdateIsFavInFirestore(this.repository);

  Future<void> call(String dishName, bool isFav) async {
    repository.updateIsFavInFireStore(dishName, isFav);
  }
}
