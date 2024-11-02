import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/features/profile/data/profile_repository_impl.dart';
import 'package:meal_recommendations/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_bloc.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_event.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_state.dart';
import 'package:meal_recommendations/features/profile/presentation/widgets/change_password_widget.dart';
import 'package:meal_recommendations/features/profile/presentation/widgets/profile_image_widget.dart';
import 'package:meal_recommendations/features/profile/presentation/widgets/profile_text_fields_widget.dart';
import 'package:meal_recommendations/features/profile/presentation/widgets/save_button_widget.dart';
import '../../data/remote/profile_data_source_impl.dart';

// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.uid});

  final String uid;

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  String? _profileImageUrl;

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _saveProfileData(BuildContext context, String uid, String name,
      String email, String phone) async {
    var box = await Hive.openBox('profileBox');
    await box.put('name', name);
    await box.put('email', email);
    await box.put('phone', phone);
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'name': name,
        'email': email,
        'phone': phone,
      });

      BlocProvider.of<ProfileBloc>(context).add(FetchUserProfile(uid));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update profile: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double padding = screenSize.width * 0.06;

    return BlocProvider(
      create: (_) => ProfileBloc(GetUserProfileUseCase(ProfileRepositoryImpl(
          ProfileDataSourceImpl(FirebaseFirestore.instance))))
        ..add(FetchUserProfile(widget.uid)),
      child: Scaffold(

        backgroundColor: AppColors.scaffoldBackgroundLightColor,
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              final data = state.profileData;
              final nameController = TextEditingController(text: data['name']);
              final emailController =
                  TextEditingController(text: data['email']);
              final phoneController =
                  TextEditingController(text: data['phone']);

              _profileImageUrl = data['profileImage'];

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: padding, vertical: padding),
                  child: Column(
                    children: [
                      ProfileImageWidget(
                        uid: widget.uid,
                        initialImageUrl: _profileImageUrl,
                        onImageUrlChanged: (url) {
                          setState(() {
                            _profileImageUrl = url;
                          });
                        },
                        onEditTapped: _toggleEditing,
                      ),
                      ProfileTextFields(
                        nameController: nameController,
                        emailController: emailController,
                        phoneController: phoneController,
                        isEditing: _isEditing,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(22.0),
                        child: ChangePasswordWidget(),
                      ),
                      const SizedBox(height: 68),
                      SaveButtonWidget(
                        isEditing: _isEditing,
                        onSavePressed: () async {
                          await _saveProfileData(
                            context,
                            widget.uid,
                            nameController.text,
                            emailController.text,
                            phoneController.text,
                          );
                          setState(() {
                            _isEditing = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
