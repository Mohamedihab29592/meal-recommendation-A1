import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';
import 'package:meal_recommendations/core/utils/assets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;
    const double padding = 25.0;
    final double avatarSize = screenSize.width * 0.35; 
    final double iconButtonSize = screenSize.width * 0.13; 
    final double textFieldWidth = screenSize.width * 0.9; 
    final double buttonWidth = screenSize.width * 0.9; 

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              color: AppColors.primaryColor,
              iconSize: 30,
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
            const Icon(
              Icons.notifications,
              color: AppColors.primaryColor,
              size: 30,
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.scaffoldBackgroundLightColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: padding, top: padding, right: padding),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: avatarSize,
                  height: avatarSize,
                  child: Stack(
                    children: [
                      const SizedBox(
                        width: 122.0,
                        height: 122.0,
                        child: CircleAvatar(
                          backgroundColor: Colors.black38,
                        ),
                      ),
                      Positioned(
                        top: avatarSize * 0.5, 
                        left: avatarSize * 0.7 - (iconButtonSize / 2),
                        child: InkWell( onTap: (){},
                          child: Image.asset(Assets.editProfile,width: 50,height: 50,))
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: textFieldWidth,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: AppColors.textFormColor,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: textFieldWidth,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: AppColors.textFormColor,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: textFieldWidth,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: AppColors.textFormColor,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: textFieldWidth,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: AppColors.textFormColor,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 68),
              Container(
                width: buttonWidth,
                height: 68,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: AppColors.primaryColor,
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                  ),
                  child: Text(
                    'Save',
                    style: AppTextStyles.textElevatedButton,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
