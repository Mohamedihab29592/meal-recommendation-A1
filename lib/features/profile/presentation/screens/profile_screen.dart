import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [Icon(Icons.menu), Icon(Icons.alarm)],
        ),
      ),
      backgroundColor: AppColors.scaffoldBackgroundLightColor,
body:Text('data'),
    );
  }
}
