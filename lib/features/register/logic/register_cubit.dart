import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kasbli_merchant/core/di/di.dart';
import 'package:kasbli_merchant/core/network/api_error_model.dart';
import 'package:kasbli_merchant/core/network/api_service.dart';
import 'package:kasbli_merchant/core/services/notification_service.dart';
import 'package:kasbli_merchant/core/utils/app_keys.dart';
import 'package:kasbli_merchant/features/register/model/register_request.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterInitial());

  // Form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController secondPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  // Gender & Date of Birth
  String? _genderLabel; // localized label from UI
  DateTime? _dateOfBirth;
  String? _lat;
  String? _long;
  String countryCode = "20";
  String secondCountryCode = "20";
  // Dependencies
  final ApiService _apiService = getIt<ApiService>();

  // Public getters (if needed by UI)
  String? get genderLabel => _genderLabel;

  DateTime? get dateOfBirth => _dateOfBirth;

  set lat(String value) => _lat = value;

  set long(String value) => _long = value;

  void updateGender(String? value) {
    _genderLabel = value;
  }

  void updateDateOfBirth(DateTime? value) {
    _dateOfBirth = value;
  }

  // Validate form fields
  bool validateForm() {
    final form = formKey.currentState;
    if (form == null || !form.validate()) return false;

    // Additional validation for password match
    if (passwordController.text != confirmPasswordController.text) {
      emit(RegisterFailure('Passwords do not match'));
      return false;
    }

    return true;
  }

    
  // Called by UI after OTP verification to finish registration
  Future<void> registerWithOtpAndCreateAccount() async {
    if (!validateForm()) return;

    await _registerUser();
  }

  // Register user after OTP verification
  Future<void> _registerUser() async {
    try {
      emit(const RegisterLoading('Creating your account...'));

      final String normalizedGender = _normalizeGender(_genderLabel);
      final String dobString = _formatDateOfBirth(_dateOfBirth);

      final req = RegisterRequest(
        name: nameController.text.trim(),
        phone: "+" + countryCode + phoneController.text.trim(),
        secondPhone:
            secondPhoneController.text.trim().isEmpty
                ? null
                : "+" + secondCountryCode + secondPhoneController.text.trim(),
        gender: normalizedGender,
        dateOfBirth: dobString,
        storeName: storeNameController.text.trim(),
        password: passwordController.text.trim(),
        passwordConfirmation: confirmPasswordController.text.trim(),
        lat: _lat ?? "",
        long: _long ?? "",
        address: addressController.text.trim(),
        fcm:
            // await NotificationService().getFCMToken() ??
            "", // FCM token can be added later
      );

      final response = await _apiService.register(req.toJson());

      if (response.status == 201) {
        emit(const RegisterSuccess());
      } else {
        emit(RegisterFailure(response.msg));
      }
    } catch (e) {
      emit(RegisterFailure(ApiErrorModel.getErrorMessage(e)));
    }
  }

  String _normalizeGender(String? label) {
    if (label == null) return '';
    // Map localized labels to API expected values
    if (label == AppKeys.male.tr()) return 'male';
    if (label == AppKeys.female.tr()) return 'female';
    return label; // fallback to whatever is provided
  }

  String _formatDateOfBirth(DateTime? date) {
    if (date == null) return '';
    // Format as yyyy-MM-dd for API consistency
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    secondPhoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    storeNameController.dispose();
    addressController.dispose();
    formKey.currentState?.dispose();
  }
}
