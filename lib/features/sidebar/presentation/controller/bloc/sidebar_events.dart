abstract class SideBarEvent {}
class LoadUserData extends SideBarEvent{
  final String path;
  final String name;
  LoadUserData(this.path,this.name);

}

class SelectMenuEvent extends SideBarEvent {
  final String selectedMenu;

  SelectMenuEvent(this.selectedMenu);
}





class SignOutEvent extends SideBarEvent {}
