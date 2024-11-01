abstract class SideBarStates {}
class SideBarIntitalState extends SideBarStates{}
class LoadUserDataState extends SideBarStates{}
class SuccessUserDataState extends SideBarStates{

}


class MenuSelectedState extends SideBarStates {
  final String selectedMenu;

  MenuSelectedState(this.selectedMenu);
}
