
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meal_recommendations/features/sidebar/presentation/controller/bloc/sidebar_events.dart';
import 'package:meal_recommendations/features/sidebar/presentation/controller/bloc/sidebar_states.dart';

import '../../../domain/repo/sidebar_repo.dart';

class SideBarBloc extends Bloc<SideBarEvent,SideBarStates>{
  final SidebarRepo repository;
  var storage = const FlutterSecureStorage();
  String? image_path;
  String? name;


  SideBarBloc(this.repository) : super(SideBarIntitalState()) {
    on<SelectMenuEvent>((event, emit) {
      emit(MenuSelectedState(event.selectedMenu));
    });
    on<LoadUserData>((event,emit)async{
      emit(LoadUserDataState());
      var uid= await storage.read(key: "token");

     // Fetch data from repository
     await repository.getHeader(uid: uid!).then((value){
       image_path = value?.path??"";
       name = value?.name??"Ahmad";

     });

     // Emit new state with name and path from the repository
     emit(SuccessUserDataState());


    });
  }


}