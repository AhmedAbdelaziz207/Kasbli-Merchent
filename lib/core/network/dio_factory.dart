import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kasbli_merchant/core/utils/storage_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();


  static Dio? dio;
  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      // Set immediate base headers (language) synchronously
      final initialLang = StorageService()
          .getString(StorageService.keyLanguage, defaultValue: 'en');
      dio!.options.headers = {
        'Accept': 'application/json',
        'local': initialLang,
        'Accept-Language': initialLang,
      };
      // Initialize headers once
      addDioHeaders();
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  // Set or refresh headers from persisted storage (language, token)
  static Future<void> addDioHeaders({String language = 'en'}) async {
    final String? token = await StorageService()
        .getSecure(StorageService.keyUserToken);

log("Add dio headers $language");

    // Preserve existing headers and update values
    final Map<String, dynamic> headers = {
      ...?dio?.options.headers,
      'Accept': 'application/json',
      'local':  language,
      'Accept-Language': language,
    };
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    dio?.options.headers = headers;
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    final Map<String, dynamic> headers = {
      ...?dio?.options.headers,
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'local': StorageService().getString(StorageService.keyLanguage, defaultValue: 'en'),
      'Accept-Language': StorageService().getString(StorageService.keyLanguage, defaultValue: 'en'),
    };
    dio?.options.headers = headers;
  }

  // Call this after changing the app language to apply the new code to all next requests
  static Future<void> refreshLanguageHeader() async {
    await addDioHeaders(language: "ar");
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }

  // Immediate language header override (does not read storage)
  static void setLanguageHeader(String languageCode) {
    final headers = {
      ...?dio?.options.headers,
      'local': languageCode,
      'Accept-Language': languageCode,
    };
    dio?.options.headers = headers;
  }
}

