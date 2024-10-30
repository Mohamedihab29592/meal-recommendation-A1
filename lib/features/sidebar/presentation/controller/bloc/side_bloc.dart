
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meal_recommendations/features/sidebar/presentation/controller/bloc/sidebar_events.dart';
import 'package:meal_recommendations/features/sidebar/presentation/controller/bloc/sidebar_states.dart';

import '../../../domain/repo/sidebar_repo.dart';

class SideBarBloc extends Bloc<SideBarEvent,SideBarStates>{
  final SidebarRepo repository;
  var storage = FlutterSecureStorage();

  SideBarBloc(this.repository) : super(SideBarIntitalState("https://image.freepik.com/"
      "free-photo/horizontal-shot-smiling-curly-haired-woman-indicates"
      "-free-space-demonstrates-place-your-advertisement-attracts-attention"
      "-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg"
      ,"Ahmad Muslim")) {
    on<SelectMenuEvent>((event, emit) {
      emit(MenuSelectedState(event.selectedMenu));
    });
    on<LoadUserData>((event,emit)async{
     var uid= await storage.read(key: "token");

     // Fetch data from repository
     final userData = await repository.getHeader(uid: uid!);

     // Emit new state with name and path from the repository
     emit(SideBarIntitalState(userData?.path??"", userData?.name??"Ahmad Muslim"));


    });
  }


}