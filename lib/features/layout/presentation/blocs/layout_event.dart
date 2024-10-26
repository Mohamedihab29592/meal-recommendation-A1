abstract class LayoutEvent {}

final class ChangeBottomNavIndex extends LayoutEvent {
  final int index;

  ChangeBottomNavIndex(this.index);
}
