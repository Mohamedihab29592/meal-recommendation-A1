import 'package:freezed_annotation/freezed_annotation.dart';

part 'layout_state.freezed.dart';

enum LayoutStateStatus {
  initial,
  changeBottomNavIndex,
}

@freezed
class LayoutState with _$LayoutState {
  const factory LayoutState({
    required LayoutStateStatus status,
    @Default(0) int bottomNavIndex,
  }) = _LayoutState;

  factory LayoutState.initial() =>
      const LayoutState(status: LayoutStateStatus.initial);
}
