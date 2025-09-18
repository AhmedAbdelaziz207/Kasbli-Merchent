part of 'otp_cubit.dart';

abstract class OtpState {
  const OtpState();
}

class OtpInitial extends OtpState {
  const OtpInitial();
}

class OtpSending extends OtpState {
  const OtpSending();
}

class OtpSent extends OtpState {
  const OtpSent();
}

class OtpVerifying extends OtpState {
  final String code;
  const OtpVerifying(this.code);
}

class OtpVerified extends OtpState {
  final String code;
  const OtpVerified(this.code);
}

class OtpFailure extends OtpState {
  final String message;
  const OtpFailure(this.message);
}
