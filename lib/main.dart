import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meal_recommendations/core/helpers/bloc_observer.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:meal_recommendations/core/routing/app_router.dart';
import 'package:meal_recommendations/core/routing/routes.dart';
import 'package:meal_recommendations/core/services/di.dart';
import 'package:meal_recommendations/core/themes/app_themes.dart';
import 'package:meal_recommendations/core/utils/strings.dart';
import 'package:path_provider/path_provider.dart';
import 'firebase_options.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  Bloc.observer = MyBlocObserver();
  
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  // Optional: Register your adapters if you are using custom objects
  // Hive.registerAdapter(YourAdapter());
  runApp(const MyApp());
  
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      ScreenUtilInit(
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
        },
     
    );
  }
}
