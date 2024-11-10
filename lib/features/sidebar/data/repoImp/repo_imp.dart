import 'package:meal_recommendations/core/helpers/cache_keys.dart';
import 'package:meal_recommendations/features/sidebar/data/data_source/remote_data_source.dart';
import 'package:meal_recommendations/features/sidebar/data/models/header_model.dart';

import '../../domain/repo/sidebar_repo.dart';

class SidebarRepoImp  implements SidebarRepo {
  final RemoteSideBarDataSource remoteDataSource;
  SidebarRepoImp(this.remoteDataSource);
  @override
  Future<HeaderModel?> getHeader({required String uid}) async{
    final HeaderModel model = await remoteDataSource.getHeader(uid: uid);
    return HeaderModel(
       path:  model.path??"",
       name:  model.name,
      uid:  model.uid


    );
  }

  @override
  Future<void> signOut() async {
   await remoteDataSource.signOut();
   // CacheKeys.cachedUserId == null;

  }




}
