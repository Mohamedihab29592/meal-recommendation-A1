import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/core/helpers/text_form_validator.dart';
import 'package:meal_recommendations/core/utils/strings.dart';
import 'package:meal_recommendations/core/widgets/custom_text_form_field.dart';
import 'package:meal_recommendations/core/widgets/my_sized_box.dart';
import 'package:meal_recommendations/core/widgets/pass_text_form_field.dart';
import 'package:meal_recommendations/features/auth/login/presenation/bloc/login_bloc.dart';
import 'package:meal_recommendations/features/auth/login/presenation/bloc/login_event.dart';
import 'package:meal_recommendations/features/auth/login/presenation/bloc/login_state.dart';

class LoginFormBlocSelector extends StatelessWidget {
  const LoginFormBlocSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginState, AutovalidateMode>(
      selector: (state) => state.autovalidateMode,
      builder: (context, autovalidateMode) {
        final loginBloc = context.read<LoginBloc>();
        return Form(
          key: loginBloc.formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              CustomTextFormField(
                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                hintText: AppStrings.username,
                controller: loginBloc.emailController,
                validate: (text) => TextFormValidator.validateEmailField(text),
              ),
              MySizedBox.height22,
              BlocSelector<LoginBloc, LoginState, bool>(
                selector: (state) => state.isPassObscured,
                builder: (context, isPassObscured) => PassTextFormField(
                  controller: loginBloc.passwordController,
                  obscureText: isPassObscured,
                  passVisibilityOnTap: () =>
                      loginBloc.add(TogglePasswordVisibility()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
