import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasbli_merchant/core/di/di.dart';
import 'package:kasbli_merchant/core/network/api_error_model.dart';
import 'package:kasbli_merchant/core/network/api_service.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(const OtpInitial());

  final ApiService _apiService = getIt<ApiService>();

  Future<void> sendOtp(String phone) async {
    if (phone.isEmpty) {
      emit(const OtpFailure('Phone number is empty'));
      return;
    }
    emit(const OtpSending());
    try {
      await _apiService.sendOTPCode({'phone': phone});
      emit(const OtpSent());
    } catch (e) {
      emit(OtpFailure(ApiErrorModel.getErrorMessage(e)));
    }
  }

  Future<void> verifyOtp(String code) async {
    if (code.isEmpty) {
      emit(const OtpFailure('Please enter a valid OTP'));
      return;
    }
    // If there's a verify API, call it here. For now, we just emit verified.
    emit(OtpVerifying(code));
    try {
      // await _apiService.verifyOtp({'otp': code});
      emit(OtpVerified(code));
    } catch (e) {
      emit(OtpFailure(ApiErrorModel.getErrorMessage(e)));
    }
  }
}

