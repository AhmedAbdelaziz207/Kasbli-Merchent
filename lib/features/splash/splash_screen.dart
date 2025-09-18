import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/network/dio_factory.dart';
import 'package:kasbli_merchant/core/routing/app_router.dart';
import 'package:kasbli_merchant/core/utils/app_assets.dart';
import 'package:kasbli_merchant/core/utils/storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800), // control speed here
    );

    _animation = Tween<Offset>(
      begin: const Offset(1.5, 0), // Start from center
      end: Offset.zero, // Move to right
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final storage = StorageService();
    final isLoggedIn = storage.getBool(StorageService.keyUserLoggedIn);

    if (!mounted) return;

    Future.delayed(const Duration(seconds: 2), () {
      DioFactory.addDioHeaders();
      if (isLoggedIn) {
        if (mounted) Navigator.pushReplacementNamed(context, AppRouter.landing);
      } else {
        if (mounted) {
          Navigator.pushReplacementNamed(context, AppRouter.onboarding);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Or AppColors.white
      body: Center(
        child: SlideTransition(
          position: _animation,
          child: Image.asset(AppAssets.appLogo, width: 200.w, height: 200.h),
        ),
      ),
    );
  }
}

