
import '../../domain/base_repo/user_repo.dart';
import '../data_source/data_source.dart';
import '../models/user_model.dart';



class UserRepositoryImpl implements UserRepository {
  final RemoteDataSourceFirebase remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserModel?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    // Fetching data from the remote data source as a UserModel
    final UserModel? userModel = await remoteDataSource.signUpWithEmailAndPassword(
      email: email,
      password: password,
      fullName: fullName,
    );

    // Mapping UserModel to the User entity
    return UserModel(
      name: userModel?.name ?? '',
      email: userModel?.email ?? '',
      uId: userModel?.uId ?? '',
      phone: userModel?.phone ?? '',
      image: userModel?.image ?? '',
    );
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }
}



