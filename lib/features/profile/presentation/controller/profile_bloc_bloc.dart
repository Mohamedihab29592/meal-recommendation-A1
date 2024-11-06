import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/features/profile/domain/usecases/change_password_use_case.dart';
import 'package:meal_recommendations/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_event.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_state.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  ProfileBloc(this.getUserProfileUseCase, this.changePasswordUseCase)
      : super(ProfileInitial()) {
    on<FetchUserProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profileData = await getUserProfileUseCase(event.uid);
        emit(ProfileLoaded(profileData));
      } catch (e) {
        emit(ProfileError("Failed to load profile"));
      }
    });

    on<ChangePassword>((event, emit) async {
      emit(ProfileLoading());
      try {
        await changePasswordUseCase(event.currentPassword, event.newPassword);
        emit(PasswordChangeSuccess("Password updated successfully"));
      } catch (e) {
        emit(ProfileError(e.toString())); 
      }
    });
  }
}
