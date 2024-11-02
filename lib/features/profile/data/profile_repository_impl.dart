import 'package:meal_recommendations/features/profile/data/remote/profile_data_source.dart';
import 'package:meal_recommendations/features/profile/domain/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource dataSource;

  ProfileRepositoryImpl(this.dataSource);

  @override
  Future<Map<String, dynamic>> getUserProfile(String uid) {
    return dataSource.getUserProfile(uid);
  }
}


