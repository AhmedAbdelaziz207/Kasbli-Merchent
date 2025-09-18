import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final Color? backgroundColor ;
  final Color? textColor;
  final double? height;
  final double? width;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Widget? leadingIcon;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.backgroundColor = AppColors.secondaryColor,
    this.textColor,
    this.height,
    this.width,
    this.borderRadius = 8.0,
    this.padding,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height ?? 54.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              backgroundColor ?? Theme.of(context).colorScheme.primary,
          padding: padding ?? EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          disabledBackgroundColor: Theme.of(
            context,
          ).colorScheme.primary.withValues(alpha: 0.5),
        ),
        child:
            isLoading
                ? SizedBox(
                  height: 24.h,
                  width: 24.h,
                  child: CircularProgressIndicator(
                    color: textColor ?? Colors.white,
                    strokeWidth: 2.0,
                  ),
                )
                : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (leadingIcon != null) ...[
                      leadingIcon!,
                      SizedBox(width: 8.w),
                    ],
                    Text(
                      text,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: textColor ?? Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}

