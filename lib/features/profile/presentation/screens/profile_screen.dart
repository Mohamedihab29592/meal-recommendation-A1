import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meal_recommendations/core/helpers/cache_keys.dart';
import 'package:meal_recommendations/core/helpers/secure_storage_helper.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_bloc.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_event.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_state.dart';
import 'package:meal_recommendations/features/profile/presentation/widgets/change_password_widget.dart';
import 'package:meal_recommendations/features/profile/presentation/widgets/profile_image_widget.dart';
import 'package:meal_recommendations/features/profile/presentation/widgets/profile_text_fields_widget.dart';
import 'package:meal_recommendations/features/profile/presentation/widgets/save_button_widget.dart';
import 'package:meal_recommendations/core/services/di.dart' as di;

// ignore_for_file: use_build_context_synchronously, prefer_const_constructors
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(di.di(), di.di()),
      child: ProfileBody(),
    );
  }
}

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  bool _isEditing = false;
  String? _profileImageUrl;
  String? _uid;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _loadUid();
    });
  }

  Future<void> _loadUid() async {
    await SecureStorageHelper.getSecuredString(CacheKeys.cachedUserId)
        .then((value) {
      _loadProfileData(value);
    });
  }

  void _loadProfileData(String? uid) {
    if (uid != null && mounted) {
      _uid = uid;
      context.read<ProfileBloc>().add(FetchUserProfile(uid));
    }
  }

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

      context.read<ProfileBloc>().add(FetchUserProfile(uid));
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

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundLightColor,
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          // print(state);
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            final data = state.profileData;
            final nameController = TextEditingController(text: data['name']);
            final emailController = TextEditingController(text: data['email']);
            final phoneController = TextEditingController(text: data['phone']);

            _profileImageUrl = data['profileImage'];

            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: padding, vertical: padding),
                  child: Column(
                    children: [
                      ProfileImageWidget(
                        uid: _uid!,
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
                            _uid!,
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
              ),
            );
          } else if (state is ProfileError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
