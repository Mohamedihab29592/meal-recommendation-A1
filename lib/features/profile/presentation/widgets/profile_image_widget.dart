import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/core/utils/assets.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

class ProfileImageWidget extends StatefulWidget {
  final String uid;
  final String? initialImageUrl;
  final ValueChanged<String?> onImageUrlChanged;
  final VoidCallback onEditTapped;

  const ProfileImageWidget({
    super.key,
    required this.uid,
    this.initialImageUrl,
    required this.onImageUrlChanged,
    required this.onEditTapped,
  });

  @override
  ProfileImageWidgetState createState() => ProfileImageWidgetState();
}

class ProfileImageWidgetState extends State<ProfileImageWidget> {
  late String? _profileImageUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _profileImageUrl = widget.initialImageUrl;
  }

  ImageProvider _getProfileImage() {
    if (_isLoading) {
      return AssetImage('assets/images/loading_placeholder.png');
    } else if (_profileImageUrl != null && _profileImageUrl!.isNotEmpty) {
      return NetworkImage(_profileImageUrl!);
    } else {
      return const NetworkImage(
          "https://cdn-icons-png.flaticon.com/512/3177/3177440.png");
    }
  }

  Future<void> _uploadImageToFirebase(XFile imageFile) async {
    setState(() {
      _isLoading = true;
    });

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

      // Update the image URL in the widget
      setState(() {
        _profileImageUrl = downloadUrl;
        _isLoading = false;
      });
      widget.onImageUrlChanged(downloadUrl);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile image updated successfully.")),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to upload image: $e")),
      );
    }
  }

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
        const SnackBar(content: Text("Permission denied to access storage.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const double avatarSize = 122.0;
    const double iconButtonSize = 50.0;

    return Center(
      child: SizedBox(
        width: avatarSize,
        height: avatarSize,
        child: Stack(
          children: [
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                  ))
                : CircleAvatar(
                    backgroundColor: AppColors.scaffoldBackgroundLightColor,
                    radius: avatarSize / 2,
                    backgroundImage: _getProfileImage(),
                    onBackgroundImageError: (error, stackTrace) {
                      setState(() {
                        _profileImageUrl = null;
                      });
                    },
                  ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  widget.onEditTapped();
                  _pickImage();
                },
                child: Container(
                  width: iconButtonSize,
                  height: iconButtonSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      Assets.editProfile,
                      width: iconButtonSize,
                      height: iconButtonSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
