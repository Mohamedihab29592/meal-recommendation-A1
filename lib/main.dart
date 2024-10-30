import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_recommendations/core/helpers/bloc_observer.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:meal_recommendations/core/routing/app_router.dart';
import 'package:meal_recommendations/core/routing/routes.dart';
import 'package:meal_recommendations/core/services/di.dart';
import 'package:meal_recommendations/core/themes/app_themes.dart';
import 'package:meal_recommendations/core/utils/strings.dart';
import 'package:meal_recommendations/features/auth/Login_Screen/presenation/controller/Login_bloc/bloc/Login%20BLoc.dart';
import 'package:meal_recommendations/features/auth/register/persentation/controller/sign_up_bloc.dart';
import 'package:meal_recommendations/features/auth/register/persentation/screens/register_screen.dart';
import 'package:meal_recommendations/features/sidebar/presentation/screens/side_bar_screen.dart';
import 'features/layout/presentation/blocs/layout_bloc.dart';
import 'features/layout/presentation/views/layout_view.dart';
import 'features/sidebar/presentation/controller/bloc/side_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  Bloc.observer = MyBlocObserver();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context)=> UserBloc(di())),
        BlocProvider(create: (context)=> LayoutBloc()),
        BlocProvider(create: (context)=> SideBarBloc(di())),

      ],
      child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
            // onGenerateRoute: AppRouter.onGenerateRoute,
              title: AppStrings.appTitle,
              debugShowCheckedModeBanner: false,
              theme: AppThemes.lightTheme,
              initialRoute: Routes.onBoarding,
              home: LayoutView(),
            );
          }),
    );
  }
}
