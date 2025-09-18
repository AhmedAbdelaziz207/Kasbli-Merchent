import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

enum LoadingSize { small, medium, large }

class LoadingWidget extends StatelessWidget {
  final String? message;
  final LoadingSize size;
  final bool useCustomAnimation;

  const LoadingWidget({
    super.key,
    this.message,
    this.size = LoadingSize.medium,
    this.useCustomAnimation = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (useCustomAnimation)
            Lottie.asset(
              'assets/animation/loading.json',
              width: _getSize(),
              height: _getSize(),
              repeat: true,
              frameRate: FrameRate(60),
            )
          else
            SizedBox(
              width: _getSize() / 2,
              height: _getSize() / 2,
              child: CircularProgressIndicator(
                strokeWidth: _getStrokeWidth(),
                color: Theme.of(context).primaryColor,
              ),
            ),
          if (message != null) ...[
            SizedBox(height: 16.h),
            Text(
              message!,
              style: TextStyle(
                fontSize: _getTextSize(),
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  double _getSize() {
    switch (size) {
      case LoadingSize.small:
        return 60.w;
      case LoadingSize.medium:
        return 120.w;
      case LoadingSize.large:
        return 200.w;
    }
  }

  double _getStrokeWidth() {
    switch (size) {
      case LoadingSize.small:
        return 2.w;
      case LoadingSize.medium:
        return 3.w;
      case LoadingSize.large:
        return 4.w;
    }
  }

  double _getTextSize() {
    switch (size) {
      case LoadingSize.small:
        return 12.sp;
      case LoadingSize.medium:
        return 14.sp;
      case LoadingSize.large:
        return 16.sp;
    }
  }
}
