import 'dart:developer';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/utils/app_keys.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_assets.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _currentIndex = 0;
  final NotchBottomBarController notchBottomBarController =
      NotchBottomBarController(index: 0);
  final screens = const [
    Center(child: Text('Home (coming soon)')),
    Center(child: Text('Favorites (coming soon)')),
    Center(child: Text('Orders (coming soon)')),
    Center(child: Text('Profile (coming soon)')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      extendBody: true,
      backgroundColor: AppColors.greyLight,
      bottomNavigationBar: AnimatedNotchBottomBar(
        elevation: 0,
        removeMargins: true,
        showLabel: true,
        notchColor: AppColors.primaryColor,
        circleMargin: 12,
        topMargin: 12,
        maxLine: 1,
        durationInMilliSeconds: 500,
        textAlign: TextAlign.center,
        textOverflow: TextOverflow.ellipsis,
        itemLabelStyle: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 8.sp,
          fontWeight: FontWeight.w500,
        ),
        shadowElevation: 10,
        notchBottomBarController: NotchBottomBarController(
          index: _currentIndex,
        ),
        bottomBarItems: [
          BottomBarItem(
            itemLabel: tr(AppKeys.homeNav),
            inActiveItem: Image.asset(AppAssets.homeInactive),
            activeItem: Image.asset(AppAssets.home),
          ),
          BottomBarItem(
            itemLabel: tr(AppKeys.favoritesNav),
            inActiveItem: Image.asset(AppAssets.fav),
            activeItem: Image.asset(AppAssets.fav, color: AppColors.white),
          ),
          BottomBarItem(
            itemLabel: tr(AppKeys.ordersNav),
            inActiveItem: Image.asset(AppAssets.orders, color: Colors.grey),
            activeItem: Image.asset(AppAssets.orders, color: AppColors.white),
          ),
          BottomBarItem(
            itemLabel: tr(AppKeys.profileNav),
            inActiveItem: Image.asset(AppAssets.profile),
            activeItem: Image.asset(AppAssets.profile, color: AppColors.white),
          ),
        ],
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
          log("$value");
        },
        kIconSize: 26,
        kBottomRadius: 12,
      ),
    );
  }
}

