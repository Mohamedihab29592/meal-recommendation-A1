import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/models/meal.dart';

class FirebaseService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<List<Meal>> fetchMeals() async {
    try {
      QuerySnapshot snapshot = await _fireStore.collection('meals').get();

      List<Meal> meals = snapshot.docs.map((doc) {
        return Meal.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return meals;
    } catch (e) {
      print('Failed to fetch meals: $e');
      return [];
    }
  }
}
