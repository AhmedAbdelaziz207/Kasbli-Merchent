import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasbli_merchant/features/otp/logic/otp_cubit.dart';
import 'package:kasbli_merchant/features/product/add_product_screen.dart';
import 'package:kasbli_merchant/features/product/logic/products_cubit.dart';

import '../../features/done/done_screen.dart';
import '../../features/forgot_password/ui/create_new_password_screen.dart';
import '../../features/forgot_password/ui/forgot_password_screen.dart';
import '../../features/landing/landing_screen.dart';
import '../../features/login/logic/login_cubit.dart';
import '../../features/login/login_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/otp/otp_screen.dart';
import '../../features/register/logic/register_cubit.dart';
import '../../features/register/register_screen.dart';
import '../../features/splash/splash_screen.dart';

class AppRouter {
  // Cannot be instantiated
  AppRouter._();

  // Routes names
  static const initial = '/';
  static const onboarding = '/onboarding';
  static const profileNav = "profile";
  static const payoutHistoryRoute = "/payoutHistory";
  static const statisticsRoute = "/statistics";
  static const updateApplicationRoute = "/updateApplication";
  static const staticPagesRoute = "/staticPages";
  static const privacyRoute = "/privacy";
  static const faqRoute = "/faq";
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const otp = '/otp';
  static const done = '/done';
  static const addProduct = '/addProduct';
  static const landing = '/landing';
  static const cart = '/cart';
  static const productDetails = '/productDetails';
  static const addCustomerInfo = "/addCustomerInfo";
  static const selectCustomerInfo = "/customerInfo";
  static const priceDetails = "/priceDetails";
  static const orderSummary = "/orderSummary";
  static const orderPlaced = "/orderPlaced";
  static const search = "/search";
  static const editAccount = "/editAccount";
  static const categoryProducts = "/categoryProducts";
  static const classifications = "/classifications";
  static const forgotPassword = "/forgotPassword";
  static const createNewPassword = "/createNewPassword";
  static const customerDetails = "/customerDetails";

  /// OnGenerateRoute => Navigation Handler
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case login:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: BlocProvider(
                  create: (context) => LoginCubit(),

                  child: LoginScreen(),
                ),
              ),
        );
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case otp:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final isForgotPassword = args['isForgotPassword'] ?? false;
        final passedRegisterCubit = args['registerCubit'] as RegisterCubit?;
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  if (passedRegisterCubit != null)
                    BlocProvider<RegisterCubit>.value(
                      value: passedRegisterCubit,
                    )
                  else
                    BlocProvider(create: (_) => RegisterCubit()),
                  BlocProvider(create: (_) => OtpCubit()),
                ],
                child: OtpScreen(
                  phoneNumber: args['phoneNumber'] ?? '',
                  isForgotPassword: isForgotPassword,
                ),
              ),
        );
      case createNewPassword:
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder:
              (_) =>
                  CreateNewPasswordScreen(phoneNumber: args['phone'] as String),
        );
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case done:
        return MaterialPageRoute(builder: (_) => DoneScreen());

      case landing:
        return MaterialPageRoute(builder: (_) => LandingScreen());
      case addProduct:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => ProductsCubit(),
                child: const AddProductScreen(),
              ),
        );

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
