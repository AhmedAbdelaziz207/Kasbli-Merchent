import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kasbli_merchant/core/routing/app_router.dart';
import 'package:kasbli_merchant/core/theme/app_colors.dart';
import 'package:kasbli_merchant/core/utils/app_keys.dart';
import 'package:kasbli_merchant/core/widgets/app_bar_widget.dart';
import 'package:kasbli_merchant/core/widgets/custom_snackbar.dart';
import 'package:kasbli_merchant/core/widgets/input_field.dart';
import 'package:kasbli_merchant/core/widgets/primary_button.dart';
import 'package:kasbli_merchant/features/forgot_password/logic/forgot_password_cubit.dart';
import 'package:kasbli_merchant/features/forgot_password/logic/forgot_password_state.dart';


class CreateNewPasswordScreen extends StatefulWidget {
  final String phoneNumber;
  
  const CreateNewPasswordScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _confirmPasswordController = TextEditingController();


  @override
  void initState() {
    super.initState();
    // Log the phone number for debugging
    log('CreateNewPasswordScreen - Phone number: ${widget.phoneNumber}');
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();

    return Scaffold(
      appBar: CustomAppBarWidget(
        title: AppKeys.createNewPasswordTitle.tr(),
        backgroundColor: AppColors.white,
        showBackButton: true,
        backButtonBackgroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (context, state) {
              if (state is ForgotPasswordFailure) {
                CustomSnackBar.show(
                  context,
                  message: state.message,
                  type: SnackBarType.error,
                );
              }
              if (state is ForgotPasswordSubmitted) {
                CustomSnackBar.show(
                  context,
                  message: AppKeys.success.tr(),
                  type: SnackBarType.success,
                );
                Navigator.pushNamedAndRemoveUntil(context, AppRouter.login, (route) => false);
              }
            },
            builder: (context, state) {
              final loading = state is ForgotPasswordSubmitting;
              return Form(
              key: _formKey,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30.h),
                  InputField(
                    label: AppKeys.createNewPassword.tr(),
                    controller: _passwordController,
                    isPassword: true,
                    validator: (v) {
                      if ((v ?? '').isEmpty) return AppKeys.confirmPasswordRequired.tr();
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  InputField(
                    label: AppKeys.confirmNewPassword.tr(),
                    controller:     _confirmPasswordController,
                    isPassword: true,
                    validator: (v) {
                      if ((v ?? '').isEmpty) return AppKeys.confirmPasswordRequired.tr();
                      if (v != _passwordController.text) return AppKeys.passwordsDoNotMatch.tr();
                      return null;
                    },
                  ),
                  SizedBox(height: 60.h),
                  PrimaryButton(
                    text: AppKeys.confirm.tr(),
                    isLoading: loading,
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                 
                        // Use the phone number passed from the previous screen
                        final phone = widget.phoneNumber;
                        cubit.submitNewPassword(
                          phone: phone,
                          password: _passwordController.text,
                          confirmPassword: _confirmPasswordController.text,
                        );
                      
                    },
                  ),
                ],
              ),
              );
            },
          ),
        ),
      ),
    );
  }
}
