import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/theme/app_colors.dart';
import 'package:kasbli_merchant/core/utils/app_assets.dart';

class MsarLogoWidget extends StatelessWidget {
  const MsarLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        textDirection:
            Directionality.of(context) == TextDirection.rtl
                ? TextDirection.ltr
                : TextDirection.rtl,
        children: [
          Image.asset(AppAssets.msarLogo),
          const SizedBox(width: 2),
          Text(
            "Powered by ",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.greyLightHover,
              fontSize: 14.sp,

            ),
          ),
        ],
      ),
    );
  }
}

