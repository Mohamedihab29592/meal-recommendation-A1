// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';
import 'package:meal_recommendations/core/utils/assets.dart';
import 'package:meal_recommendations/features/profile/data/profile_repository_impl.dart';
import 'package:meal_recommendations/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_bloc.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_event.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_state.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/remote/profile_data_source_impl.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  const ProfileScreen({super.key, required this.uid});

  @override
    ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  String? _profileImageUrl; 

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const double padding = 25.0;
    final double avatarSize = screenSize.width * 0.4;
    final double iconButtonSize = screenSize.width * 0.13;
    final double textFieldWidth = screenSize.width * 0.9;
    final double buttonWidth = screenSize.width * 0.9;

    return BlocProvider(
      create: (_) => ProfileBloc(GetUserProfileUseCase(ProfileRepositoryImpl(
          ProfileDataSourceImpl(FirebaseFirestore.instance))))
        ..add(FetchUserProfile(widget.uid)),
      child: Scaffold(
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
                  padding: const EdgeInsets.only(
                      left: padding, top: padding, right: padding),
                  child: Column(
                    children: [
                      Center(
                        child: SizedBox(
                          width: avatarSize,
                          height: avatarSize,
                          child: Stack(
                            children: [
                              SizedBox(
                                width: 122.0,
                                height: 122.0,
                                child: CircleAvatar(
                                  backgroundImage: _getProfileImage(),
                                  onBackgroundImageError: (error, stackTrace) {

                                    setState(() {
                                      _profileImageUrl = null;
                                      AssetImage(Assets
                                          .profileLogo); 
                                    });
                                  },
                                ),
                              ),
                              Positioned(
                                top: avatarSize * 0.6,
                                left: avatarSize * 0.7- (iconButtonSize / 2),
                                child: InkWell(
                                  onTap: () async {

                                    setState(() {
                                      _isEditing = !_isEditing;
                                    });


                                    if (_isEditing) {
                                      await _pickImage();
                                    }
                                  },
                                  child: Image.asset(
                                    Assets.editProfile,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: textFieldWidth,
                        child: TextFormField(
                          controller: nameController,
                          readOnly: !_isEditing,
                          decoration: InputDecoration(
                            labelText: 'Name',
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
                          controller: emailController,
                          readOnly: !_isEditing,
                          decoration: InputDecoration(
                            labelText: 'Email',
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
                          controller: phoneController,
                          readOnly: !_isEditing,
                          decoration: InputDecoration(
                            labelText: 'Phone',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: AppColors.textFormColor,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),  const SizedBox(height: 22),
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
                          onPressed: _isEditing
                              ? () async {
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
                                }
                              : null,
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

  ImageProvider _getProfileImage() {
    if (_profileImageUrl != null && _profileImageUrl!.isNotEmpty) {
      return NetworkImage(_profileImageUrl!);
    } else {
    
      return NetworkImage(
          "https://cdn-icons-png.flaticon.com/512/3177/3177440.png"); 
    }
  }

  Future<void> _uploadImageToFirebase(XFile imageFile) async {
    try {
      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profileImages/${widget.uid}/${imageFile.name}');
      await storageRef.putFile(File(imageFile.path));

      // Get the download URL
      String downloadUrl = await storageRef.getDownloadURL();

      // Save the image URL to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .update({'profileImage': downloadUrl});

      // Save the image URL in Hive
      var box = await Hive.openBox('profileBox');
      await box.put('profileImage', downloadUrl);

      setState(() {
        _profileImageUrl = downloadUrl; 
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile image updated successfully.")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to upload image: $e")),
      );
    }
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
    // Request permission
  Future<void> _pickImage() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        await _uploadImageToFirebase(pickedFile);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Permission denied to access storage.")),
      );
    }
  }
}
