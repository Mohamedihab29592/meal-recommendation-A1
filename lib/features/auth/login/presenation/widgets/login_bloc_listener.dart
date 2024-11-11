import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/core/helpers/extensions.dart';
import 'package:meal_recommendations/core/utils/functions/cache_user_and_his_id.dart';
import 'package:meal_recommendations/core/utils/strings.dart';
import 'package:meal_recommendations/core/widgets/primary_button.dart';
import 'package:meal_recommendations/features/auth/login/presenation/bloc/login_bloc.dart';
import 'package:meal_recommendations/features/auth/login/presenation/bloc/login_state.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (_, current) => _listenWhen(current),
      listener: (context, state) async => await _listener(state, context),
      child: PrimaryButton(
        onPressed: () => context.read<LoginBloc>().validateAndLogin(),
        text: AppStrings.login,
      ),
    );
  }

  Future<void> _listener(LoginState state, BuildContext context) async {
    switch (state.status) {
      case LoginStateStatus.loginLoading:
        context.showLoadingDialog();
        break;

      case LoginStateStatus.loginError:
        _popLoadingDialogAndShowSnackBar(context, state);
        break;

      case LoginStateStatus.loginSuccess:
        await _popLoadingDialogAndCacheUser(context, state);
        break;

      default:
        break;
    }
  }

  Future<void> _popLoadingDialogAndCacheUser(
    BuildContext context,
    LoginState state,
  ) async {
    context.popTop();
    await cacheUserAndHisId(state.user!);
  }

  void _popLoadingDialogAndShowSnackBar(
    BuildContext context,
    LoginState state,
  ) {
    context.popTop();
    context.showSnackBar(
      message: state.error!,
      type: SnackbarType.error,
    );
  }

  bool _listenWhen(LoginState current) {
    return current.status == LoginStateStatus.loginLoading ||
        current.status == LoginStateStatus.loginSuccess ||
        current.status == LoginStateStatus.loginError;
  }
}
