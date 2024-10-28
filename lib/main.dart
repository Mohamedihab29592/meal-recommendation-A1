import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_recommendations/core/routing/app_router.dart';
import 'package:meal_recommendations/core/routing/routes.dart';
import 'package:meal_recommendations/core/services/di.dart';
import 'package:meal_recommendations/core/themes/app_themes.dart';
import 'package:meal_recommendations/core/utils/strings.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            onGenerateRoute: AppRouter.onGenerateRoute,
            title: AppStrings.appTitle,
            debugShowCheckedModeBanner: false,
            theme: AppThemes.lightTheme,
            initialRoute: Routes.profile,
          );
        });
  }
}
