import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/utils/app_assets.dart';
import 'package:kasbli_merchant/core/widgets/primary_button.dart';

import '../theme/app_colors.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({super.key, this.message, this.onRetry});

  final String? message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.sorry,
            height: 180.h,
            width: 120.w,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 4),
          Text(
            message ?? 'Something went wrong !',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 20.h),
          if (onRetry != null)
            PrimaryButton(text: "Retry".tr(), onPressed: onRetry, width: 120.w),
        ],
      ),
    );
  }
}

