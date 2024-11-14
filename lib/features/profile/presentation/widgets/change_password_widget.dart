import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/core/services/di.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_bloc.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_event.dart';
import 'package:meal_recommendations/features/profile/presentation/controller/profile_bloc_state.dart';
// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

class ChangePasswordWidget extends StatelessWidget {
  const ChangePasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<ProfileBloc>(),
      child: Builder(
        builder: (context) {
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
        },
      ),
    );
  }

  Future<void> _showChangePasswordDialog(BuildContext context) async {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
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
              onPressed: () {
                if (newPasswordController.text ==
                    confirmPasswordController.text) {
                  profileBloc.add(ChangePassword(
                    currentPasswordController.text,
                    newPasswordController.text,
                  ));
                  Navigator.of(dialogContext).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Passwords do not match')),
                  );
                }
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
    profileBloc.stream.listen((state) {
      if (state is ProfileError) {
        String errorMessage = state.message.contains('password')
            ? 'Invalid password. Please check your current password.'
            : state.message;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } else if (state is PasswordChangeSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }
    });
  }
}
