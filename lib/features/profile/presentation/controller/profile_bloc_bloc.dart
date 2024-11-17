// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/features/profile/domain/usecases/change_password_use_case.dart';
import 'package:meal_recommendations/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:meal_recommendations/features/profile/domain/usecases/logout_use_case.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_event.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_state.dart';
import 'package:meal_recommendations/core/firebase/firebase_error_handler.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
 final LogoutUseCase logoutUseCase;  
  ProfileBloc(
    this.getUserProfileUseCase,
    this.changePasswordUseCase,
    this.logoutUseCase, 
  
  ) : super(ProfileInitial()) {
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
 on<LogoutRequested>((event, emit) async {
  
      emit(LogoutLoading());
      try {
        await logoutUseCase.execute(); 
        emit(LogoutSuccess());
      } catch (error) {
        emit(LogoutError("Failed to logout: $error"));
      }
    });
  }
}