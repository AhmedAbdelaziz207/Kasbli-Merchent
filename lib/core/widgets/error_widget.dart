import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

enum ErrorType { network, server, notFound, generic }

class AppErrorWidget extends StatelessWidget {
  final String? message;
  final ErrorType errorType;
  final VoidCallback? onRetry;
  final Widget? customAction;

  const AppErrorWidget({
    super.key,
    this.message,
    this.errorType = ErrorType.generic,
    this.onRetry,
    this.customAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAnimation(),
            SizedBox(height: 24.h),
            Text(
              _getErrorTitle(),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              message ?? _getDefaultMessage(),
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            if (onRetry != null)
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            if (customAction != null) ...[
              SizedBox(height: 16.h),
              customAction!,
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAnimation() {
    String animationUrl;

    switch (errorType) {
      case ErrorType.network:
        animationUrl =
            'https://assets2.lottiefiles.com/packages/lf20_kcsr6fcp.json';
        break;
      case ErrorType.server:
        animationUrl =
            'https://assets2.lottiefiles.com/packages/lf20_kcsr6fcp.json';
        break;
      case ErrorType.notFound:
        animationUrl =
            'https://assets2.lottiefiles.com/packages/lf20_khznilov.json';
        break;
      case ErrorType.generic:
      default:
        animationUrl =
            'https://assets2.lottiefiles.com/packages/lf20_qpwbiyxf.json';
        break;
    }

    return Lottie.network(
      animationUrl,
      width: 180.w,
      height: 180.h,
      repeat: true,
      frameRate: FrameRate(60),
    );
  }

  String _getErrorTitle() {
    switch (errorType) {
      case ErrorType.network:
        return 'Network Error';
      case ErrorType.server:
        return 'Server Error';
      case ErrorType.notFound:
        return 'Not Found';
      case ErrorType.generic:
      return 'Something Went Wrong';
    }
  }

  String _getDefaultMessage() {
    switch (errorType) {
      case ErrorType.network:
        return 'Please check your internet connection and try again.';
      case ErrorType.server:
        return 'Our servers are currently experiencing issues. Please try again later.';
      case ErrorType.notFound:
        return 'The requested resource could not be found.';
      case ErrorType.generic:
      return 'An unexpected error occurred. Please try again later.';
    }
  }
}
