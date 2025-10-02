import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/widgets/custom_image_loader.dart';

class SummaryTile extends StatelessWidget {
  final String icon;
  final String title;
  final String amount;

  const SummaryTile({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      child: Row(
        children: [
          CustomImageLoader(
            imagePath: icon,
            width: 24.w,
            height: 24.h,
            isNetworkImage: false,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.black87),
            ),
          ),
          Text(
            amount,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
