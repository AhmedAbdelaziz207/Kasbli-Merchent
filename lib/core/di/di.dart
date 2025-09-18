import 'dart:developer';
import 'package:get_it/get_it.dart';
import 'package:kasbli_merchant/core/network/api_service.dart';
import 'package:kasbli_merchant/core/network/dio_factory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kasbli_merchant/core/network/api_endpoints.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  try {
    // Initialize SharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();
    
    // Register SharedPreferences
    getIt.registerSingleton<SharedPreferences>(sharedPreferences);
    
    // Initialize API service
    final apiService = ApiService(
      DioFactory.getDio(),
      baseUrl: ApiEndPoints.baseUrl,
    );

    // Register other services
    getIt.registerSingleton<ApiService>(apiService);
  } catch (e) {
    log("Service Locator Error: $e");
    rethrow;
  }
}

void disposeServiceLocator() => getIt.reset();
