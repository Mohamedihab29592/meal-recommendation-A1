import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/core/utils/assets.dart';
import 'package:meal_recommendations/features/layout/presentation/blocs/layout_bloc.dart';
import 'package:meal_recommendations/features/layout/presentation/blocs/layout_event.dart';
import 'package:meal_recommendations/features/layout/presentation/blocs/layout_state.dart';
import 'package:meal_recommendations/features/layout/presentation/widgets/custom_navigation_destination.dart';
import 'package:meal_recommendations/features/layout/presentation/widgets/favorites_tab_body.dart';
import 'package:meal_recommendations/features/layout/presentation/widgets/home_tab_body.dart';
import 'package:meal_recommendations/features/layout/presentation/widgets/profile_tab_body.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutBloc, LayoutState>(
      buildWhen: (previous, current) =>
          previous.bottomNavIndex != current.bottomNavIndex,
      builder: (context, state) => Scaffold(
        body: [
          // (Don't use scaffold again in the following widgets)
          const HomeTabBody(),
          const FavoritesTabBody(),
          const ProfileTabBody(),
        ][state.bottomNavIndex],
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          indicatorColor: Colors.transparent,
          animationDuration: const Duration(milliseconds: 500),
          destinations: const [
            CustomNavigationDestination(
              icon: Assets.iconsHomeIcon,
              selectedIcon: Assets.iconsWhiteHomeIcon,
            ),
            CustomNavigationDestination(
              icon: Assets.iconsHeartIcon,
              selectedIcon: Assets.iconsWhiteHeartIcon,
            ),
            CustomNavigationDestination(
              icon: Assets.iconsProfileIcon,
              selectedIcon: Assets.iconsWhiteProfileIcon,
            ),
          ],
          selectedIndex: state.bottomNavIndex,
          onDestinationSelected: (index) =>
              context.read<LayoutBloc>().add(ChangeBottomNavIndex(index)),
        ),
      ),
    );
  }
}