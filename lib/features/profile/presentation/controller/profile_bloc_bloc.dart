import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_bloc_event.dart';
part 'profile_bloc_state.dart';

class ProfileBlocBloc extends Bloc<ProfileBlocEvent, ProfileBlocState> {
  ProfileBlocBloc() : super(ProfileBlocInitial()) {
    on<ProfileBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
