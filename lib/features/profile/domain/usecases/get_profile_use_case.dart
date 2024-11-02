import 'package:meal_recommendations/features/profile/domain/profile_repository.dart';

class GetUserProfileUseCase {
  final ProfileRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<Map<String, dynamic>> call(String uid) {
    return repository.getUserProfile(uid);
  }
}
