import 'package:equatable/equatable.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
  @override
  List<Object?> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordRequesting extends ForgotPasswordState {}

class ForgotPasswordCodeSent extends ForgotPasswordState {
  final String phone;
  const ForgotPasswordCodeSent(this.phone);
  @override
  List<Object?> get props => [phone];
}

class ForgotPasswordVerifying extends ForgotPasswordState {}

class ForgotPasswordVerified extends ForgotPasswordState {
  final String phone;
  const ForgotPasswordVerified(this.phone);
  @override
  List<Object?> get props => [phone];
}

class ForgotPasswordSubmitting extends ForgotPasswordState {}

class ForgotPasswordSubmitted extends ForgotPasswordState {}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String message;
  const ForgotPasswordFailure(this.message);
  @override
  List<Object?> get props => [message];
}
