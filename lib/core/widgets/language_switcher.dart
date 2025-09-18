part of 'custom_language_appbar.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current locale
    final currentLocale = context.locale.languageCode;
    final isArabic = currentLocale == 'ar';

    return GestureDetector(
      onTap: () async {
        // Toggle between Arabic and English
        final Locale newLocale = isArabic ? const Locale('en') : const Locale('ar');
        await context.setLocale(newLocale);
        // Persist selected language
        await StorageService().save(StorageService.keyLanguage, newLocale.languageCode);
        // Immediately apply header for next requests, then refresh from storage
        DioFactory.setLanguageHeader(newLocale.languageCode);
        await DioFactory.refreshLanguageHeader();
      },
      child: Container(
        decoration: BoxDecoration( 
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(20.r),
        ),
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children:
              [
                Icon(Icons.language, color: AppColors.primaryColor, size: 20.r),
                SizedBox(width: 4.w),
                Text(
                  isArabic ? AppKeys.english.tr() : AppKeys.arabic.tr(),
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ].reversed.toList(),
        ),
      ),
    );
  }
}
