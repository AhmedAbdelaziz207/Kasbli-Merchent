import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasbli_merchant/core/theme/app_colors.dart';
import 'package:kasbli_merchant/core/utils/app_assets.dart';
import 'package:kasbli_merchant/core/utils/app_keys.dart';
import 'package:kasbli_merchant/core/widgets/app_bar_widget.dart';
import 'package:kasbli_merchant/core/widgets/custom_snackbar.dart';
import 'package:kasbli_merchant/core/widgets/phone_input_field.dart';
import 'package:kasbli_merchant/features/forgot_password/logic/forgot_password_cubit.dart';
import 'package:kasbli_merchant/features/forgot_password/logic/forgot_password_state.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/widgets/primary_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: AppKeys.forgotPassword.tr(),
        backButtonBackgroundColor: AppColors.white,
      ),
      body: BlocProvider(
        create: (_) => ForgotPasswordCubit(),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
                listener: (context, state) {
                  if (state is ForgotPasswordFailure) {
                    CustomSnackBar.show(
                      context,
                      message: state.message,
                      type: SnackBarType.error,
                    );
                  }
                  if (state is ForgotPasswordCodeSent) {
                    Navigator.pushNamed(
                      context,
                      AppRouter.otp,
                      arguments: {
                        'phoneNumber': state.phone,
                        'isForgotPassword': true,
                      },
                    );
                  }
                },
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.appLogo, width: 200, height: 200),
                      SizedBox(height: 21.h),
                      Text(
                        AppKeys.dontWorryReset.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      CustomIntlPhoneField(
                        label: AppKeys.phoneNumber.tr(),
                        controller: _phoneController,
                        onCountryChanged: (country) {
                         context.read<ForgotPasswordCubit>().countryCode = country.dialCode;
                         log("Country Code ${country.dialCode}");
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                        builder: (context, state) {
                          final loading = state is ForgotPasswordRequesting;
                          return PrimaryButton(
                            text: AppKeys.sendCode.tr(),
                            onPressed: () {
                             
                       log("Phone Number ${_phoneController.text}");
                                context
                                    .read<ForgotPasswordCubit>()
                                    .requestResetPassword(phone: _phoneController.text);
                              
                            },
                            width: 270.w,
                            isLoading: loading,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

