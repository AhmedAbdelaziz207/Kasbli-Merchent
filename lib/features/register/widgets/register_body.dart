import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/utils/app_keys.dart';
import 'package:kasbli_merchant/features/register/widgets/register_form.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/app_name_widget.dart';

class RegisterBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController secondPhoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController storeNameController;
  final Function(String?) onGenderChanged;
  final Function(DateTime?) onDateOfBirthChanged;
  final VoidCallback onRegisterPressed;
  final bool isLoading;

  const RegisterBody({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.phoneController,
    required this.secondPhoneController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.storeNameController,
    required this.onGenderChanged,
    required this.onDateOfBirthChanged,
    required this.onRegisterPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              SizedBox(height: 30.h),
              Image.asset(AppAssets.appLogo, width: 80.w, height: 80.h),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppKeys.welcomeBack.tr(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  AppNameWidget(),
                ],
              ),
              SizedBox(height: 30.h),
              RegisterForm(
                formKey: formKey,
                nameController: nameController,
                phoneController: phoneController,
                secondPhoneController: secondPhoneController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
                storeNameController: storeNameController,
                onGenderChanged: onGenderChanged,
                onDateOfBirthChanged: onDateOfBirthChanged,
                onRegisterPressed: onRegisterPressed,
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

