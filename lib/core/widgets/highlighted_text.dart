import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class HighlightedText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final bool highlightFirstLetter;

  const HighlightedText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.highlightFirstLetter = true,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle =
        Theme.of(context).textTheme.displayMedium ??
        TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold);
    final textStyle = style ?? defaultStyle;

    // Get the locale to determine if we're in Arabic mode
    final isArabic = context.locale.languageCode == 'ar';

    if (!highlightFirstLetter || text.isEmpty) {
      return Text(text, style: textStyle, textAlign: textAlign);
    }

    // In Arabic, handle RTL text differently
    if (isArabic) {
      // For Arabic, we need to find where the 'س' is (it might not be the first character
      // due to RTL formatting marks or other characters)
      final int firstLetterIndex = text.indexOf('س');
      if (firstLetterIndex == -1) {
        return Text(text, style: textStyle, textAlign: textAlign);
      }

      return RichText(
        textAlign: textAlign ?? TextAlign.start,
        text: TextSpan(
          children: [
            // Text before the 'س'
            if (firstLetterIndex > 0)
              TextSpan(
                text: text.substring(0, firstLetterIndex),
                style: textStyle,
              ),
            // The 'س' with the primary color
            TextSpan(
              text: 'س',
              style: textStyle.copyWith(color: AppColors.primaryColor),
            ),
            // Text after the 'س'
            if (firstLetterIndex < text.length - 1)
              TextSpan(
                text: text.substring(firstLetterIndex + 1),
                style: textStyle,
              ),
            TextSpan(text: ' ! ', style: textStyle),
          ],
        ),
      );
    } else {
      // For English, find and highlight 'S' (uppercase) or 's' (lowercase)
      final lowerText = text.toLowerCase();
      final int sIndex = lowerText.indexOf('s');

      if (sIndex == -1) {
        return Text(text, style: textStyle, textAlign: textAlign);
      }

      return RichText(
        textAlign: textAlign ?? TextAlign.start,
        text: TextSpan(
          children: [
            // Text before the 'S'
            if (sIndex > 0)
              TextSpan(text: text.substring(0, sIndex), style: textStyle),
            // The 'S' with the primary color
            TextSpan(
              text: text[sIndex],
              style: textStyle.copyWith(color: AppColors.primaryColor),
            ),
            // Text after the 'S'
            if (sIndex < text.length - 1)
              TextSpan(text: text.substring(sIndex + 1), style: textStyle),
           TextSpan(text: ' ! ', style: textStyle),],
        ),
      );
    }
  }
}
