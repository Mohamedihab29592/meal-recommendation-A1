import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meal_recommendations/features/layout/presentation/blocs/layout_event.dart';
import 'package:meal_recommendations/features/layout/presentation/blocs/layout_state.dart';

class LayoutBloc extends Bloc<LayoutEvent, LayoutState> {
  LayoutBloc() : super(LayoutState.initial()) {
    on<ChangeBottomNavIndex>(_changeBottomNavIndex);
  }

  void _changeBottomNavIndex(
    ChangeBottomNavIndex event,
    Emitter<LayoutState> emit,
  ) {
    if (state.bottomNavIndex != event.index) {
      emit(
        state.copyWith(
          status: LayoutStateStatus.changeBottomNavIndex,
          bottomNavIndex: event.index,
        ),
      );
    }
  }
}
