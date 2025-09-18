import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/utils/app_keys.dart';
import 'package:kasbli_merchant/core/utils/validators.dart';
import 'package:kasbli_merchant/core/widgets/input_field.dart';
import 'package:kasbli_merchant/core/widgets/phone_input_field.dart';
import 'package:kasbli_merchant/core/widgets/primary_button.dart';
import 'package:kasbli_merchant/features/register/logic/register_cubit.dart';
import 'package:kasbli_merchant/features/register/widgets/date_selection_widget.dart';
import 'package:kasbli_merchant/features/register/widgets/gender_drop_down.dart';

class RegisterForm extends StatelessWidget {
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

  const RegisterForm({
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
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Name Field
            InputField(
              label: AppKeys.name.tr(),
              hint: AppKeys.fullName.tr(),
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppKeys.nameRequired.tr();
                }
                if (value.length < 2) {
                  return AppKeys.nameTooShort.tr();
                }
                return null;
              },
            ),
            // SizedBox(height: 16.h),
            
            // Phone Number Field
            CustomIntlPhoneField(
              label: AppKeys.phoneNumber.tr(),
              controller: phoneController,
              onCountryChanged: (c) {
                // Update primary phone country code in cubit
                context.read<RegisterCubit>().countryCode = c.dialCode;
              },
            ),
            SizedBox(height: 21.h),
            
            // Second Phone Number (Optional)
            CustomIntlPhoneField(
              label: "${AppKeys.secondPhoneNumber.tr()} (${AppKeys.optional.tr()})",
              controller: secondPhoneController,
              validator: (p0) {
                return null;
              },
              onCountryChanged: (c) {
                // Update secondary phone country code in cubit
                context.read<RegisterCubit>().secondCountryCode = c.dialCode;
              },
            ),
            SizedBox(height: 16.h),
            
            // Password Field
            InputField(
              label: AppKeys.password.tr(),
              hint: AppKeys.password.tr(),
              isPassword: true,
              controller: passwordController,
              validator: Validators.validatePassword,
            ),
            // SizedBox(height: 16.h),
            
            // Confirm Password Field
            InputField(
              label: AppKeys.confirmPassword.tr(),
              hint: AppKeys.confirmPassword.tr(),
              isPassword: true,
              controller: confirmPasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppKeys.confirmPasswordRequired.tr();
                }
                if (value != passwordController.text) {
                  return AppKeys.passwordsDoNotMatch.tr();
                }
                return null;
              },
            ),
            // SizedBox(height: 16.h),
            
            // Gender and Date of Birth Row
            Row(
              children: [
                Expanded(
                  child: GenderDropdownInput(
                    onChanged: onGenderChanged,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppKeys.genderRequired.tr();
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: DateOfBirthInput(
                    onDateSelected: onDateOfBirthChanged,
                    validator: (value) {
                      if (value == null) {
                        return AppKeys.dateOfBirthRequired.tr();
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16.h),
            
            // Store Name Field
            InputField(
              label: AppKeys.storeName.tr(),
              hint: AppKeys.storeName.tr(),
              controller: storeNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppKeys.storeNameRequired.tr();
                }
                return null;
              },
            ),
            SizedBox(height: 60.h),
            
            // Register Button
            PrimaryButton(
              text: AppKeys.signup.tr(),
              onPressed: onRegisterPressed,
              isLoading: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}

