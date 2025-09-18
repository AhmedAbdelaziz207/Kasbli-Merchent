import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasbli_merchant/core/routing/app_router.dart';
import 'package:kasbli_merchant/features/register/logic/register_cubit.dart';
import 'package:kasbli_merchant/features/register/widgets/register_body.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerCubit = RegisterCubit();

  @override
  void dispose() {
    _registerCubit.dispose();
    super.dispose();
  }

  void _navigateToOtpScreen() {
    Navigator.pushNamed(
      context,
      AppRouter.otp,
      arguments: {
        'phoneNumber': '+${_registerCubit.countryCode}${_registerCubit.phoneController.text.trim()}',
        'registerCubit': _registerCubit,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      bloc: _registerCubit,
      listener: (context, state) {
        if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is RegisterOTPSent) {
          // Navigate to OTP screen when OTP is sent
          _navigateToOtpScreen();
        } else if (state is RegisterSuccess) {
          // Handle successful registration
          Navigator.pushReplacementNamed(context, AppRouter.home);
        }
      },
      builder: (context, state) {
        return BlocProvider<RegisterCubit>.value(
          value: _registerCubit,
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RegisterBody(
                    formKey: _registerCubit.formKey,
                    nameController: _registerCubit.nameController,
                    phoneController: _registerCubit.phoneController,
                    secondPhoneController: _registerCubit.secondPhoneController,
                    passwordController: _registerCubit.passwordController,
                    confirmPasswordController: _registerCubit.confirmPasswordController,
                    storeNameController: _registerCubit.storeNameController,
                    onGenderChanged: _registerCubit.updateGender,
                    onDateOfBirthChanged: _registerCubit.updateDateOfBirth,
                    onRegisterPressed: _registerCubit.checkUniquePhones,
                    isLoading: state is RegisterLoading,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

