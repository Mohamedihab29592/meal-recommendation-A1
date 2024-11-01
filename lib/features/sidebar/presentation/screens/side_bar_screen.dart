import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/features/sidebar/presentation/controller/bloc/sidebar_states.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/themes/app_colors.dart';
import '../controller/bloc/side_bloc.dart';
import '../controller/bloc/sidebar_events.dart';
import '../widgets/nav_button.dart';

// Custom widget for navigation buttons




class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    double padding = screenWidth * 0.04; // 4% of screen width for padding
    double iconSize = screenHeight * 0.04; // 4% of screen height for icon size
    double avatarRadius = screenHeight * 0.06; // 6% of screen height for avatar radius
    double fontSize = screenHeight * 0.022; // 2.2% of screen height for font size

    return Drawer(
      child: SingleChildScrollView(
        child: BlocBuilder<SideBarBloc, SideBarStates>(
          builder: (context, state) {
            var bloc = context.read<SideBarBloc>();
            String selectedMenu = state is MenuSelectedState
                ? state.selectedMenu
                : 'Home';


            // Get name and path from the state if it’s an initial state
            return Column(
              children: [
                // Header
                ConditionalBuilder(
                  condition: state is! LoadUserDataState,
                  builder: (context) => Container(
                    height: screenHeight * 0.25, // 25% of screen height for header
                    color: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(
                      vertical: padding,
                      horizontal: padding,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: avatarRadius,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: bloc.image_path !=null
                              ? NetworkImage("${bloc.image_path}")
                              : null,
                          child: bloc.image_path == null
                              ? Icon(Icons.person, size: iconSize, color: Colors.white)
                              : null,
                        ),
                        SizedBox(width: padding),
                        Text(
                          '${bloc.name}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  fallback: (context) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: avatarRadius,
                        ),
                        SizedBox(width: padding,),
                        SizedBox(height: fontSize,),
                      ],
                    ),

                  ),

                ),

                // Navigation Buttons
                NavButton(
                  title: 'Home',
                  icon: Icons.home,
                  iconSize: iconSize,
                  fontSize: fontSize,
                  isSelected: selectedMenu == 'Home',
                  onTap: () {
                    bloc.add(SelectMenuEvent("Home"));
                  },
                ),
                NavButton(
                  title: 'Profile',
                  icon: Icons.person,
                  iconSize: iconSize,
                  fontSize: fontSize,
                  isSelected: selectedMenu == 'Profile',
                  onTap: () {
                    bloc.add(SelectMenuEvent('Profile'));
                  },
                ),
                NavButton(
                  title: 'Favorite',
                  icon: Icons.favorite_border,
                  iconSize: iconSize,
                  fontSize: fontSize,
                  isSelected: selectedMenu == 'Favorite',
                  onTap: () {
                    bloc.add(SelectMenuEvent("Favorite"));
                  },
                ),
                NavButton(
                  title: 'Setting',
                  icon: Icons.settings,
                  iconSize: iconSize,
                  fontSize: fontSize,
                  isSelected: selectedMenu == 'Setting',
                  onTap: () {
                    bloc.add(SelectMenuEvent("Setting"));
                  },
                ),
                SizedBox(height: padding * 2), // Spacer equivalent

                NavButton(
                  title: 'Logout',
                  icon: Icons.logout,
                  iconSize: iconSize,
                  fontSize: fontSize,
                  isSelected: selectedMenu == 'Logout',
                  onTap: () {
                    bloc.add(SelectMenuEvent('Logout'));
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}



