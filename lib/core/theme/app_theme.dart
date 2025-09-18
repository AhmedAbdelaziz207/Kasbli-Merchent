import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData getTheme(Locale locale) {
    final bool isArabic = locale.languageCode == 'ar';

    // Define text style generators based on locale
    TextStyle headingStyle(double fontSize, FontWeight fontWeight) {
      return isArabic
          ? GoogleFonts.notoSansArabic(
            fontSize: fontSize.sp,
            fontWeight: fontWeight,
            color: AppColors.textPrimary,
          )
          : GoogleFonts.inter(
            fontSize: fontSize.sp,
            fontWeight: fontWeight,
            color: AppColors.textPrimary,
          );
    }

    TextStyle bodyStyle(double fontSize, {Color? color}) {
      return isArabic
          ? GoogleFonts.notoSansArabic(
            fontSize: fontSize.sp,
            color: color ?? AppColors.textPrimary,
          )
          : GoogleFonts.inter(
            fontSize: fontSize.sp,
            color: color ?? AppColors.textPrimary,
          );
    }

    // Create a text theme based on the locale-specific styles
    final textTheme = TextTheme(
      displayLarge: headingStyle(32, FontWeight.bold,),
      displayMedium: headingStyle(28, FontWeight.bold),
      displaySmall: headingStyle(24, FontWeight.bold),
      headlineMedium: headingStyle(20, FontWeight.w600),
      titleLarge: headingStyle(18, FontWeight.w600),
      bodyLarge: bodyStyle(16),
      bodyMedium: bodyStyle(14),
      bodySmall: bodyStyle(12, color: AppColors.textSecondary),
    );

    // Define button text styles
    final buttonTextStyle =
        isArabic
            ? GoogleFonts.notoSansArabic(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            )
            : GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w600);

    final smallButtonTextStyle =
        isArabic
            ? GoogleFonts.notoSansArabic(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            )
            : GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w500);

    // Define hint and label styles
    final hintStyle =
        isArabic
            ? GoogleFonts.notoSansArabic(
              fontSize: 14.sp,
              color: AppColors.textHint,
            )
            : GoogleFonts.inter(fontSize: 14.sp, color: AppColors.textHint);

    final labelStyle =
        isArabic
            ? GoogleFonts.notoSansArabic(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            )
            : GoogleFonts.inter(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            );

    return ThemeData(
      useMaterial3: false,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        primary: AppColors.primaryColor,
        secondary: AppColors.secondary,
        error: AppColors.error,
        surface: AppColors.surface,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      textTheme: textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: buttonTextStyle,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          textStyle: smallButtonTextStyle,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          side: const BorderSide(color: AppColors.primaryColor),
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: buttonTextStyle,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        hintStyle: hintStyle,
        labelStyle: labelStyle,
      ),
      cardTheme: CardTheme(
        color: AppColors.cardBg,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // For backward compatibility and default theme
  static ThemeData get lightTheme => getTheme(const Locale('en'));
}
