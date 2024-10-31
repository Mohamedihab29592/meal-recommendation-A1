import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';

// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

class ChangePasswordWidget extends StatelessWidget {
  const ChangePasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showChangePasswordDialog(context),
      child: SizedBox(
        child: Row(
          children: [
            Text(
              'Change Password',
              style: AppTextStyles.font16Bold,
            ),
            const Spacer(),
            const Icon(Icons.edit_square),
          ],
        ),
      ),
    );
  }

  Future<void> _showChangePasswordDialog(BuildContext context) async {
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final TextEditingController currentPasswordController =
        TextEditingController();

    Future<bool> validateCurrentPassword(String currentPassword) async {
      final user = FirebaseAuth.instance.currentUser;
      return (user?.email == currentPassword);
    }

    Future<void> updatePassword(String newPassword) async {
      try {
        final user = FirebaseAuth.instance.currentUser;
        await user!.updatePassword(newPassword);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password updated successfully")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update password: $e")),
        );
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                decoration:
                    const InputDecoration(labelText: 'Current Password'),
                obscureText: true,
              ),
              TextField(
                controller: newPasswordController,
                decoration: const InputDecoration(labelText: 'New Password'),
                obscureText: true,
              ),
              TextField(
                controller: confirmPasswordController,
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (await validateCurrentPassword(
                    currentPasswordController.text)) {
                  if (newPasswordController.text ==
                      confirmPasswordController.text) {
                    await updatePassword(newPasswordController.text);
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Passwords do not match')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Current password is incorrect')),
                  );
                }
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
