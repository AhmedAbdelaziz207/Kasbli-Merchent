import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/di/di.dart';
import 'package:kasbli_merchant/core/routing/app_router.dart';
import 'package:kasbli_merchant/core/theme/app_theme.dart';
import 'package:kasbli_merchant/features/cart/logic/cart_cubit.dart';
import 'package:kasbli_merchant/features/orders/logic/orders_cubit.dart';
import 'package:kasbli_merchant/features/forgot_password/logic/forgot_password_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<CartCubit>()),
            BlocProvider(create: (context) => OrdersCubit.create()),
            BlocProvider(create: (context) => ForgotPasswordCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            initialRoute: AppRouter.initial,
            theme: AppTheme.getTheme(Locale(context.locale.languageCode)),
            onGenerateRoute: AppRouter.onGenerateRoute,
          ),
        );
      },
    );
  }
}

