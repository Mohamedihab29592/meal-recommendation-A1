
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meal_recommendations/features/sidebar/presentation/controller/bloc/sidebar_events.dart';
import 'package:meal_recommendations/features/sidebar/presentation/controller/bloc/sidebar_states.dart';

import '../../../../../core/helpers/cache_keys.dart';
import '../../../../../core/helpers/secure_storage_helper.dart';
import '../../../domain/repo/sidebar_repo.dart';

class SideBarBloc extends Bloc<SideBarEvent, SideBarStates> {
  final SidebarRepo repository;
  String? imagePath;
  String? name;

  SideBarBloc(this.repository) : super(SideBarIntitalState()) {
    // Automatically load user data

    on<SelectMenuEvent>((event, emit) {
      emit(MenuSelectedState(event.selectedMenu));
    });

    on<LoadUserData>((event, emit) async {
      await _fetchUserData(emit);
    });

    on<SignOutEvent>((event, emit) async {
      emit(SignOutInProgress());
      try {
        await repository.signOut(); // assuming `signOut` is defined in your `repository`
        emit(SignOutSuccess());
      } catch (e) {
        emit(SignOutFailure(e.toString()));
      }
    });
    _loadUserData();
  }

  // Method to load user data immediately upon bloc creation
  void _loadUserData() {
    add(LoadUserData(imagePath??"",name??"Ahmad"));
  }

  // Fetches user data and handles the states
  Future<void> _fetchUserData(Emitter<SideBarStates> emit) async {
    emit(LoadUserDataState());

    try {
      var uid = await SecureStorageHelper.getSecuredString( CacheKeys.cachedUserId,);
      if (uid == null) {
        print("User token not found. Please log in again.");
        return;
      }

      final userData = await repository.getHeader(uid: uid);
      imagePath = userData?.path ?? "";
      name = userData?.name ?? "Ahmad";

      emit(SuccessUserDataState( name??"Ahmad",  imagePath??""));
    } catch (error) {
      print(error.toString());
    }
  }
}
