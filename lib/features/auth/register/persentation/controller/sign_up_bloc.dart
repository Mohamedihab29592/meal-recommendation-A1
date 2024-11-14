import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/features/auth/register/persentation/controller/user_events.dart';
import 'package:meal_recommendations/features/auth/register/persentation/controller/user_states.dart';

import '../../data/models/user_model.dart';
import '../../domain/base_repo/user_repo.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc(this.repository) : super(UserInitialState(isPassword: false)) {
    on<SignUpEvent>((event, emit) async {
      emit(UserLoadingState());

      try {
        final UserModel? userModel =
            await repository.signUpWithEmailAndPassword(
          email: event.email,
          password: event.password,
          fullName: event.fullName, phone: event.phone,
        );
        await repository.userCreate(name: event.fullName, email: event.email, uid: userModel?.uId??"", phone: event.phone);

        emit(UserSuccessState(userModel??UserModel()));

      } catch (error) {
        emit(UserErrorState(error.toString()));
      }
    });

    on<SignOutEvent>((event, emit) async {
      await repository.signOut();
      emit(UserInitialState(isPassword: false));
    });

    on<ToggleTermsEvent>((event, emit) {
      // Emit the new state with updated termsAccepted value
      emit(UserInitialState(
        termsAccepted: event.isAccepted,
      ));
    });
    on<TogglePasswordEvent>((event, emit) {
      // Emit the new state with updated termsAccepted value
      emit(UserInitialState(isPassword: event.isPassword));
    });
  }
}
