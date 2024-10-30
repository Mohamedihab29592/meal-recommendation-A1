import 'package:bloc/bloc.dart';
import 'package:meal_recommendations/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_event.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_state.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;

  ProfileBloc(this.getUserProfileUseCase) : super(ProfileInitial()) {
    on<FetchUserProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profileData = await getUserProfileUseCase(event.uid);
        emit(ProfileLoaded(profileData));
      } catch (e) {
        emit(ProfileError("Failed to load profile"));
      }
    });
  }
}
