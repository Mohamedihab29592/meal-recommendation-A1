import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meal_recommendations/core/models/auth_action_params.dart';
import 'package:meal_recommendations/core/utils/functions/get_firebase_user_data.dart';
import 'package:meal_recommendations/features/auth/register/data/models/user_model.dart';

class LoginDataSource {
  final FirebaseAuth _firebaseAuth;

  LoginDataSource(this._firebaseAuth);

  Future<UserModel> login(AuthActionParams params) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );

    final firebaseUser = await getFirebaseUserData(credential.user!.uid);
    return UserModel.fromJson(firebaseUser.data()!);
  }

  Future googleLogin() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return;
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await _firebaseAuth.signInWithCredential(credential);
  }
}
