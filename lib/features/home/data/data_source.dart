import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/models/meal.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class FirebaseService {
  Future<List<Meal>> fetchMeals() async {
    try {
      QuerySnapshot snapshot = await _fireStore.collection('meals').get();

      List<Meal> meals = snapshot.docs.map((doc) {
        return Meal.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return meals;
    } catch (e) {
      debugPrint('Failed to fetch meals: $e');
      return [];
    }
  }
}
