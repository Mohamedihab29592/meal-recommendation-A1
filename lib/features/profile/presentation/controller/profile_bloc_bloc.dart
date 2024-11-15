import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/features/profile/domain/usecases/change_password_use_case.dart';
import 'package:meal_recommendations/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_event.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_state.dart';
import 'package:meal_recommendations/core/firebase/firebase_error_handler.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  ProfileBloc(this.getUserProfileUseCase, this.changePasswordUseCase)
      : super(ProfileInitial()) {
 on<FetchUserProfile>((event, emit) async {
  emit(ProfileLoading());
  try {
    print("Fetching profile data for UID: ${event.uid}"); 
    final profileData = await getUserProfileUseCase(event.uid);
    print("Profile data retrieved: $profileData");
    emit(ProfileLoaded(profileData));
  } catch (error) {
    final firebaseError = FirebaseErrorHandler.handleError(error);
    emit(ProfileError(firebaseError.error));
  }
});

    on<ChangePassword>((event, emit) async {
      emit(ProfileLoading());
      try {
        await changePasswordUseCase(event.currentPassword, event.newPassword);
        emit(PasswordChangeSuccess("Password updated successfully"));
      } catch (error) {
        final firebaseError = FirebaseErrorHandler.handleError(error);
        emit(ProfileError(firebaseError.error));
      }
    });
  }
}
