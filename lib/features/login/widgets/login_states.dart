import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasbli_merchant/core/widgets/custom_snackbar.dart';
import 'package:kasbli_merchant/features/login/logic/login_cubit.dart';

import '../../../core/routing/app_router.dart';

class LoginStatesHandler extends StatelessWidget {
  const LoginStatesHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          CustomSnackBar.show(
            context,
            message: "Welcome Back ",
            type: SnackBarType.success,
          );
          Navigator.pushNamedAndRemoveUntil(context, AppRouter.landing, (route) => false);
        }

        if (state is LoginFailure) {
          CustomSnackBar.show(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
        }
      },
      child: SizedBox(),
    );
  }
}

