import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kasbli_merchant/core/di/di.dart';
import 'package:kasbli_merchant/core/network/dio_factory.dart';
import 'app/my_app.dart';
import 'core/utils/storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await StorageService.initialize();
  await setupServiceLocator();
  // Initialize notification service
//   await NotificationService().initialize();
  // Determine saved locale (default to 'en')
  final savedLang = StorageService().getString(
    StorageService.keyLanguage,
    defaultValue: 'en',
  );

  DioFactory.addDioHeaders(language: savedLang);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: Locale(savedLang),
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}
