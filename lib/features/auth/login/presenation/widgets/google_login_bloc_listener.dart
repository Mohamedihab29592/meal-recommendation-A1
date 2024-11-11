import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meal_recommendations/core/helpers/extensions.dart';
import 'package:meal_recommendations/core/utils/assets.dart';
import 'package:meal_recommendations/core/utils/functions/cache_user_and_his_id.dart';
import 'package:meal_recommendations/features/auth/login/presenation/bloc/login_bloc.dart';
import 'package:meal_recommendations/features/auth/login/presenation/bloc/login_event.dart';
import 'package:meal_recommendations/features/auth/login/presenation/bloc/login_state.dart';
import 'package:meal_recommendations/features/auth/login/presenation/widgets/SocalCard.dart';
import 'package:meal_recommendations/features/auth/register/data/models/user_model.dart';

class GoogleLoginBlocListener extends StatelessWidget {
  const GoogleLoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (_, current) => _listenWhen(current),
      listener: (context, state) async => await _listener(state, context),
      child: SocialCard(
        icon: SvgPicture.asset(Assets.svgsGoogleIcon),
        press: () => context.read<LoginBloc>().add(GoogleLogin()),
      ),
    );
  }

  Future<void> _listener(LoginState state, BuildContext context) async {
    switch (state.status) {
      case LoginStateStatus.googleLoginLoading:
        context.showLoadingDialog();
        break;

      case LoginStateStatus.googleLoginError:
        _popLoadingDialogAndShowSnackBar(context, state);
        break;

      case LoginStateStatus.googleLoginSuccess:
        await _popLoadingDialogAndCacheUId(context, state);
        break;

      default:
        break;
    }
  }

  Future<void> _popLoadingDialogAndCacheUId(
    BuildContext context,
    LoginState state,
  ) async {
    context.popTop();
    final user = UserModel(
      uId: state.credential!.user!.uid,
      email: state.credential!.user!.email,
      name: state.credential!.user!.displayName,
      image: state.credential!.user!.photoURL,
      phone: state.credential!.user!.phoneNumber,
    );
    await cacheUserAndHisId(user);
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
    return current.status == LoginStateStatus.googleLoginLoading ||
        current.status == LoginStateStatus.googleLoginSuccess ||
        current.status == LoginStateStatus.googleLoginError;
  }
}
