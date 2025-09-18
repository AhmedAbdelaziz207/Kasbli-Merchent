part of 'register_cubit.dart';

@immutable
sealed class RegisterState {
  const RegisterState();
}

final class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

final class RegisterLoading extends RegisterState {
  final String? message;
  
  const RegisterLoading([this.message]);
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is RegisterLoading &&
        other.message == message;
  }
  
  @override
  int get hashCode => message.hashCode;
}

final class RegisterOTPSent extends RegisterState {
  const RegisterOTPSent();
}

final class RegisterOTPVerified extends RegisterState {
  const RegisterOTPVerified();
}

final class RegisterSuccess extends RegisterState {
  const RegisterSuccess();
}

final class RegisterFailure extends RegisterState {
  final String message;
  
  const RegisterFailure(this.message);
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is RegisterFailure &&
        other.message == message;
  }
  
  @override
  int get hashCode => message.hashCode;
}
