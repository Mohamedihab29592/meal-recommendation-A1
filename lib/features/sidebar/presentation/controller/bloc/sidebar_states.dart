abstract class SideBarStates {}
class SideBarIntitalState extends SideBarStates{
  final String path;
  final String name;
  SideBarIntitalState(this.path,this.name);
}

class MenuSelectedState extends SideBarStates {
  final String selectedMenu;

  MenuSelectedState(this.selectedMenu);
}
