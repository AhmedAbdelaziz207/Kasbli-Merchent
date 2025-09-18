import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/theme/app_colors.dart';
import 'package:kasbli_merchant/core/utils/app_keys.dart';
import 'package:kasbli_merchant/core/utils/validators.dart';
import 'package:kasbli_merchant/core/widgets/primary_button.dart';
import 'package:kasbli_merchant/features/login/logic/login_cubit.dart';
import 'package:kasbli_merchant/features/login/widgets/login_states.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/widgets/input_field.dart';
import '../../../core/widgets/phone_input_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: context.read<LoginCubit>().formKey,
        child: Column(
          
          children: [
            CustomIntlPhoneField(
              label: AppKeys.phoneNumber.tr(),
              controller: context.read<LoginCubit>().phoneController,
              onCountryChanged: (country) {
              log("Country Code: ${country.dialCode}");
                context.read<LoginCubit>().countryCode = country.code ;
              },
            ),
            SizedBox(height: 12.h),
            InputField(
              label: AppKeys.password.tr(),
              hint: AppKeys.password.tr(),
              isPassword: true,
              height: 71,
              validator: (value) {
                // Use the existing password validator
                final passwordError = Validators.validatePassword(value);
                if (passwordError != null) {
                  return passwordError;
                }
              
                return null;
              },
              controller: context.read<LoginCubit>().passwordController,
            ),
            // SizedBox(height: 12.h),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.forgotPassword);
                },
                child: Text(
                  AppKeys.forgetPassword.tr(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),

            SizedBox(height: 50.h),
            BlocBuilder<LoginCubit, LoginState>(
              buildWhen:
                  (previous, current) =>
                      current is LoginLoading ||
                      current is LoginFailure ||
                      current is LoginSuccess,
              builder: (context, state) {
                return PrimaryButton(
                  text: AppKeys.login.tr(),
                  width: 270.w,
                  isLoading: state is LoginLoading ? true : false,
                  onPressed: context.read<LoginCubit>().login,
                );
              },
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppKeys.dontHaveAccount.tr(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.black,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(width: 4.w),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, AppRouter.register),
                  child: Text(
                    AppKeys.signup.tr(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
            LoginStatesHandler(),
          ],
        ),
      ),
    );
  }
}

