import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasbli_merchant/core/di/di.dart';
import 'package:kasbli_merchant/core/network/api_error_model.dart';
import 'package:kasbli_merchant/core/network/api_service.dart';
import 'package:kasbli_merchant/features/forgot_password/logic/forgot_password_state.dart';


class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());
  final ApiService apiService  = getIt<ApiService>();  
  // Controllers managed by cubit
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
      String countryCode = "20";

  // 1) Request reset password code using phone
  Future<void> requestResetPassword({required String phone}) async {
    if (phone.trim().isEmpty) {
      emit(const ForgotPasswordFailure('Phone is required'));
      return;
    }
    try {
      emit(ForgotPasswordRequesting());
      await apiService.requestPassword({"phone":"+" + countryCode + phone});
      emit(ForgotPasswordCodeSent("+" + countryCode + phone));
    } catch (e) {
      emit(ForgotPasswordFailure(ApiErrorModel.getErrorMessage(e)));
    }
  }

  // 2) Verify reset password with phone and otp
  Future<void> verifyResetPassword({
    required String phone,
    required String otp,
  }) async {
    if (phone.trim().isEmpty || otp.trim().isEmpty) {
      emit(const ForgotPasswordFailure('Phone and OTP are required'));
      return;
    }
    try {
      emit(ForgotPasswordVerifying());
      // Ensure phone is formatted with +<countryCode><number>
      final formattedPhone = phone.startsWith('+')
          ? phone
          : "+" + countryCode + phone;
      await apiService.verifyResetPassword({
        "phone": formattedPhone,
        "otp": otp,
      });
      emit(ForgotPasswordVerified(formattedPhone));
    } catch (e) {
      emit(ForgotPasswordFailure(ApiErrorModel.getErrorMessage(e)));
    }
  }

  // 3) Submit new password
  Future<void> submitNewPassword({
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
log("phone: $phone, password: $password, confirmPassword: $confirmPassword");

    if (phone.trim().isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      emit(const ForgotPasswordFailure('All fields are required'));
      return;
    }
    if (password != confirmPassword) {
      emit(const ForgotPasswordFailure('Passwords do not match'));
      return;
    }
log("phone: $phone, password: $password, confirmPassword: $confirmPassword");

    try {
      emit(ForgotPasswordSubmitting());
      // Ensure phone is formatted with +<countryCode><number>
      final formattedPhone = phone.startsWith('+')
          ? phone
          : "+" + countryCode + phone;
      await apiService.submitResetPassword({
        "phone": formattedPhone,
        "password": password,
        "confirm_password": confirmPassword,
      });
      emit(ForgotPasswordSubmitted());
    } catch (e) {
      emit(ForgotPasswordFailure(ApiErrorModel.getErrorMessage(e)));
    }
  }

  @override
  Future<void> close() {    
    phoneController.dispose();
    otpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
