import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kasbli_merchant/core/network/api_error_model.dart';
import 'package:kasbli_merchant/core/network/api_service.dart';
import 'package:kasbli_merchant/core/di/di.dart';
import 'package:kasbli_merchant/core/network/dio_factory.dart';
import 'package:kasbli_merchant/core/utils/storage_service.dart';
import 'package:kasbli_merchant/features/login/model/login_response.dart';
import '../model/login_request.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial()) {
    // Set first time to false to skip onboarding even user not logged in
    storage.save(StorageService.keyFirstTime, false);
    log("first time ${storage.get(StorageService.keyFirstTime)}");
  }

  
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final storage = StorageService();

  final ApiService _apiService = getIt<ApiService>();

  String countryCode = "20";

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    emit(LoginLoading());

    try {
      /// Todo : Check country code With Backend
      final LoginResponse response = await _apiService.login(
        LoginRequest(
          phone: "+$countryCode${phoneController.text.trim()}",
          password: passwordController.text.trim(),
        ).toJson(),
      );

      final apiMessage = response.msg ?? 'Unexpected server response.';

      if (response.status == 200 && response.data != null) {
        saveUserData(response.data!);
        DioFactory.setTokenIntoHeaderAfterLogin(response.data!.token ?? '');
        // Update FCM token on backend after we have an auth token
        await _updateFcmTokenSafe();
        emit(LoginSuccess(response));
      } else {
        emit(LoginFailure(apiMessage));
      }
    } catch (e) {
      // For network, parsing, or other runtime errors
      emit(LoginFailure(ApiErrorModel.getErrorMessage(e)));
    }
  }

  Future<void> _updateFcmTokenSafe() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null && token.isNotEmpty) {
        await _apiService.updateFcm(FormData.fromMap({"fcm": token}));
      }
    } catch (e) {
      // Swallow errors; do not block login on FCM update
      log('Failed to update FCM token: ${ApiErrorModel.getErrorMessage(e)}');
    }
  }

  Future<void> saveUserData(LoginData data) async {
    await storage.save(StorageService.keyUserId, data.id.toString());
    await storage.save(StorageService.keyUserName, data.name ?? '');
    await storage.save(StorageService.keyUserPhone, data.phone ?? '');
    await storage.save(StorageService.secondPhone, data.secondPhone ?? '');
    await storage.save(StorageService.keyStoreName, data.storeName ?? '');
    await storage.save(StorageService.dateOfBirth, data.dateOfBirth ?? '');
    await storage.save(StorageService.keyUserGender, data.gender ?? '');
    await storage.save(StorageService.keyUserLoggedIn, true);
    await storage.saveSecure(StorageService.keyUserToken, data.token ?? '');

    log("name ${data.name}");
    log("phone ${data.phone}");
    log("secondPhone ${data.secondPhone}");
    log("token ${data.token}");
    log("storeName ${data.storeName}");
    log("gender ${data.gender}");
    log("id ${data.id}");
  }

  dispose() {
    phoneController.dispose();
    passwordController.dispose();
  
  }
}
