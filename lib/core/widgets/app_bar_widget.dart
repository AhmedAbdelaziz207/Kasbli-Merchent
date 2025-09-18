import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import 'custom_back_button_appbar_widget.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? titleStyle;
  final bool isCenterTitle;
  final double? elevation;
  final bool showBackButton;
  final Widget? leading;
  final VoidCallback? onBackPressed;
  final PreferredSizeWidget? bottom;
  final VoidCallback? backButtonPressed;
  final IconData? backButtonIcon;
  final double? backButtonSize;
  final double? backButtonIconSize;
  final Color? backButtonIconColor;
  final Color? backButtonBackgroundColor;
  final bool? backButtonIsCircle;
  final double? scrolledUnderElevation;
  final double? toolBarHeight;

  const CustomAppBarWidget({
    super.key,
    required this.title,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.titleStyle,
    this.isCenterTitle = false,
    this.showBackButton = true,
    this.leading,
    this.onBackPressed,
    this.bottom,
    this.backButtonPressed,
    this.backButtonIcon,
    this.backButtonSize,
    this.backButtonIconSize,
    this.backButtonIconColor,
    this.backButtonBackgroundColor,
    this.backButtonIsCircle,
    this.scrolledUnderElevation = 0,
    this.toolBarHeight,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: scrolledUnderElevation,
      toolbarHeight:  toolBarHeight,
      title: Text(
        title,
        style:
            titleStyle ??
            TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
      ),
      centerTitle: isCenterTitle,
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      foregroundColor: foregroundColor ?? Theme.of(context).primaryColor,
      elevation: elevation ?? 0,
      leading:
          showBackButton
              ? leading ??
                  CustomBackButtonAppBarWidget(
                    onPressed: backButtonPressed,
                    icon: backButtonIcon,
                    size: backButtonSize,
                    iconSize: backButtonIconSize,
                    iconColor: backButtonIconColor,
                    backgroundColor: backButtonBackgroundColor,
                    isCircle: backButtonIsCircle,
                  )
              : null,
      actions: actions,
      // bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    bottom != null
        ? kToolbarHeight + bottom!.preferredSize.height
        : kToolbarHeight,
  );
}

/// Empty app bar widget to avoid the default app bar just Space between the app bar and the body
class EmptyAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const EmptyAppBarWidget({super.key, this.height = 80.0});

  @override
  Widget build(BuildContext context) => SizedBox(height: height);

  @override
  Size get preferredSize => Size.fromHeight(height);
}
