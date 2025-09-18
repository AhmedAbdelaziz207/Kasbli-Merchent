import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import '../utils/app_keys.dart';

class PriceSummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? labelColor;
  final Color? valueColor;

  const PriceSummaryRow({super.key, 
    required this.label,
    required this.value,
    this.labelColor,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              color: labelColor ?? AppColors.secondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: textTheme.bodyMedium?.copyWith(
              color: valueColor ?? AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Text(
              AppKeys.currencySymbol.tr(),
              style: textTheme.bodyMedium?.copyWith(
                color: valueColor ?? AppColors.secondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}