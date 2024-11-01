import 'package:meal_recommendations/features/sidebar/data/models/header_model.dart';

abstract class SidebarRepo {
  Future<HeaderModel?> getHeader({required String uid});

  Future<void> signOut();
}