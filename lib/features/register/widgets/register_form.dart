import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/theme/app_colors.dart';
import 'package:kasbli_merchant/core/utils/app_keys.dart';
import 'package:kasbli_merchant/core/utils/validators.dart';
import 'package:kasbli_merchant/core/widgets/input_field.dart';
import 'package:kasbli_merchant/core/widgets/phone_input_field.dart';
import 'package:kasbli_merchant/core/widgets/primary_button.dart';
import 'package:kasbli_merchant/features/register/logic/register_cubit.dart';
import 'package:kasbli_merchant/features/register/widgets/date_selection_widget.dart';
import 'package:kasbli_merchant/features/register/widgets/gender_drop_down.dart';
import 'package:kasbli_merchant/features/register/widgets/locations_selector.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.read<RegisterCubit>();
    final isLoading = context.watch<RegisterCubit>().state is RegisterLoading;

    return Form(
      key: registerCubit.formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Name Field
            InputField(
              label: AppKeys.name.tr(),
              hint: AppKeys.fullName.tr(),
              controller: registerCubit.nameController,
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
              controller: registerCubit.phoneController,
              onCountryChanged: (c) {
                // Update primary phone country code in cubit
                registerCubit.countryCode = c.dialCode;
              },
            ),
            SizedBox(height: 21.h),

            // Second Phone Number (Optional)
            CustomIntlPhoneField(
              label:
                  "${AppKeys.secondPhoneNumber.tr()} (${AppKeys.optional.tr()})",
              controller: registerCubit.secondPhoneController,
              validator: (p0) {
                return null;
              },
              onCountryChanged: (c) {
                // Update secondary phone country code in cubit
                registerCubit.secondCountryCode = c.dialCode;
              },
            ),
            SizedBox(height: 16.h),

            // Password Field
            InputField(
              label: AppKeys.password.tr(),
              hint: AppKeys.password.tr(),
              isPassword: true,
              controller: registerCubit.passwordController,
              validator: Validators.validatePassword,
            ),
            // SizedBox(height: 16.h),

            // Confirm Password Field
            InputField(
              label: AppKeys.confirmPassword.tr(),
              hint: AppKeys.confirmPassword.tr(),
              isPassword: true,
              controller: registerCubit.confirmPasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppKeys.confirmPasswordRequired.tr();
                }
                if (value != registerCubit.passwordController.text) {
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
                    onChanged: registerCubit.updateGender,
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
                    onDateSelected: registerCubit.updateDateOfBirth,
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

            SizedBox(height: 16.h),
            // Store Name Field
            InputField(
              label: AppKeys.storeName.tr(),
              hint: AppKeys.storeName.tr(),
              controller: registerCubit.storeNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppKeys.storeNameRequired.tr();
                }
                return null;
              },
            ),
            SizedBox(height: 12.h),
            // Register Button
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                AppKeys.locationInfo.tr(),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: AppColors.textLightGrey,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 120.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: LocationsSelector(registerCubit: registerCubit),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  InputField(
                    label: AppKeys.address.tr(),
                    controller: registerCubit.addressController,
                    hint: AppKeys.typeYourAddress.tr(),
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppKeys.addressRequired.tr();
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 60.h),
            PrimaryButton(
              text: AppKeys.signup.tr(),
              onPressed: registerCubit.registerWithOtpAndCreateAccount,
              isLoading: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
