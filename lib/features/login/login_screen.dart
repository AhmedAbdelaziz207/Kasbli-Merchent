import 'package:flutter/material.dart';
import 'package:kasbli_merchant/core/theme/app_colors.dart';
import 'package:kasbli_merchant/features/login/widgets/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: LoginBody(),
        ),
      ),
      // bottomSheet: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [MsarLogoWidget(), Row()],
      // ),
    );
  }
}

