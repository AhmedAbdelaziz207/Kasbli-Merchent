import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

class CustomBackButtonAppBarWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;
  final double? size;
  final double? iconSize;
  final Color? iconColor;
  final Color? backgroundColor;
  final bool? isCircle;
  const CustomBackButtonAppBarWidget({
    super.key,
    this.onPressed,
    this.icon,
    this.size,
    this.iconSize,
    this.iconColor,
    this.backgroundColor,
    this.isCircle,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () => Navigator.pop(context),
      icon: Container(
        width: size ?? 50.w,
        height: size ?? 50.h,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primaryLight,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon ?? Icons.arrow_back_ios_new_outlined,
          color: iconColor ?? AppColors.primaryColor,
          size: iconSize ?? 18.sp,
        ),
      ),
    );
  }
}
