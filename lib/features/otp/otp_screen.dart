import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/theme/app_colors.dart';
import 'package:kasbli_merchant/core/utils/app_assets.dart';
import 'package:kasbli_merchant/core/utils/app_keys.dart';
import 'package:kasbli_merchant/core/widgets/custom_snackbar.dart';
import 'package:kasbli_merchant/core/widgets/primary_button.dart';
import 'package:kasbli_merchant/features/otp/widgets/otp_counter.dart';
import 'package:kasbli_merchant/features/otp/logic/otp_cubit.dart';
import 'package:kasbli_merchant/features/register/logic/register_cubit.dart';
import 'package:kasbli_merchant/features/forgot_password/logic/forgot_password_cubit.dart';
import 'package:kasbli_merchant/features/forgot_password/logic/forgot_password_state.dart';
import 'package:kasbli_merchant/core/routing/app_router.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final bool isForgotPassword;
  const OtpScreen({
    super.key,
    this.phoneNumber = '',
    this.isForgotPassword = false,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (!widget.isForgotPassword) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final args =
            ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
        final phone =
            args != null && args['phoneNumber'] != null
                ? args['phoneNumber'] as String
                : widget.phoneNumber;
        // Trigger sending OTP when screen opens
        context.read<OtpCubit>().sendOtp(phone);
      });
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.read<RegisterCubit>();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
        {};
    final phoneNumber = args['phoneNumber'] ?? widget.phoneNumber;

    // Derive raw phone (without +country code) for forgot password APIs
    String rawForgotPhone() {
      if (!widget.isForgotPassword) return '';
      final forgotCubit = context.read<ForgotPasswordCubit>();
      final pn = (phoneNumber as String?) ?? '';
      if (pn.isEmpty) return '';
      // Remove leading '+'
      var v = pn.startsWith('+') ? pn.substring(1) : pn;
      // Strip leading country code if matches cubit's countryCode
      if (v.startsWith(forgotCubit.countryCode)) {
        v = v.substring(forgotCubit.countryCode.length);
      }
      return v;
    }


    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 60.h),
          child: Column(
            children: [
              Image.asset(AppAssets.appLogo, width: 80.w, height: 80.h),
              SizedBox(height: 8.h),
              Text(
                '${AppKeys.thisMessageSentOnWhatsapp.tr()}\n$phoneNumber',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(fontSize: 16.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                AppKeys.enterTheCode.tr(),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.primaryColor,
                ),
              ),

              SizedBox(height: 100.h),
              OtpTimerText(),
              SizedBox(height: 20.h),
              MultiBlocListener(
                listeners: [
                  if (!widget.isForgotPassword)
                    BlocListener<OtpCubit, OtpState>(
                      listener: (context, state) {
                        if (state is OtpFailure) {
                          CustomSnackBar.show(
                            context,
                            message: state.message,
                            type: SnackBarType.error,
                          );
                        }
                        if (state is OtpVerified) {
                          // Continue registration using verified code
                          registerCubit.registerWithOtpAndCreateAccount(
                            state.code,
                          );
                        }
                      },
                    ),
                  if (widget.isForgotPassword)
                    BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
                      listener: (context, state) {
                        if (state is ForgotPasswordFailure) {
                          CustomSnackBar.show(
                            context,
                            message: state.message,
                            type: SnackBarType.error,
                          );
                        }
                        if (state is ForgotPasswordVerified) {
                          final forgotCubit = context.read<ForgotPasswordCubit>();
                          Navigator.pushReplacementNamed(
                            context,
                            AppRouter.createNewPassword,
                            arguments: {
                              'forgotCubit': forgotCubit,
                              'phone': state.phone,
                            },
                          );
                        }
                      },
                    ),
                  BlocListener<RegisterCubit, RegisterState>(
                    listener: (context, state) {
                      if (state is RegisterFailure) {
                        CustomSnackBar.show(
                          context,
                          message: state.message,
                          type: SnackBarType.error,
                        );
                      }

                      if (state is RegisterSuccess) {
                        Navigator.pushReplacementNamed(context, AppRouter.done);
                      }
                    },
                  ),
                ],
                child: Pinput(
                  length: 6,
                  controller: _otpController,
                  showCursor: true,
                  textInputAction: TextInputAction.done,
                  onCompleted: (value) {
                    if (widget.isForgotPassword) {
                      context.read<ForgotPasswordCubit>().verifyResetPassword(
                        phone: rawForgotPhone(),
                        otp: value,
                      );
                    } else {
                      context.read<OtpCubit>().verifyOtp(value);
                    }
                  },
                  textCapitalization: TextCapitalization.sentences,
                  defaultPinTheme: PinTheme(
                    width: 56.w,
                    height: 56.h,
                    textStyle: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(fontSize: 16.sp),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(color: AppColors.blackLightActive),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 56.w,
                    height: 56.h,
                    textStyle: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(fontSize: 16.sp),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  submittedPinTheme: PinTheme(
                    width: 56.w,
                    height: 56.h,
                    textStyle: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(fontSize: 16.sp),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 120.h),
              if (!widget.isForgotPassword)
                BlocBuilder<OtpCubit, OtpState>(
                  builder: (context, state) {
                    final loading = state is OtpSending || state is OtpVerifying;
                    return PrimaryButton(
                      text: AppKeys.submit.tr(),
                      onPressed: () {
                        context.read<OtpCubit>().verifyOtp(_otpController.text);
                      },
                      width: 270.w,
                      isLoading: loading,
                    );
                  },
                )
              else
                PrimaryButton(
                  text: AppKeys.submit.tr(),
                  onPressed: () {
                    context.read<ForgotPasswordCubit>().verifyResetPassword(
                      phone: rawForgotPhone(),
                      otp: _otpController.text,
                    );
                  },
                  width: 270.w,
                  isLoading: false,
                ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${AppKeys.didntReceiveCode.tr()} ",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (widget.isForgotPassword) {
                        context
                            .read<ForgotPasswordCubit>()
                            .requestResetPassword(phone: rawForgotPhone());
                      } else {
                        context.read<OtpCubit>().sendOtp(phoneNumber);
                      }
                    },
                    child: Text(
                      AppKeys.resend.tr(),
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

