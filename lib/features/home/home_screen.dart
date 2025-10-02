import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/theme/app_colors.dart';
import 'widgets/home_header.dart';
import 'widgets/stats_grid.dart';
import 'widgets/summary_list.dart';
import 'widgets/orders_chart_card.dart';

class HomeScreen extends StatelessWidget {
  final String userName;

  const HomeScreen({super.key, this.userName = 'Khaled'});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.white, // Background color of status bar
        statusBarIconBrightness:
            Brightness.dark, // For Android (light/dark icons)
        statusBarBrightness: Brightness.dark, // For iOS
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
        physics:  BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(name: userName, onAdd: () {}, onNotifications: () {}),
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: StatsGrid.sample(),
              ),
              SizedBox(height: 16.h),
              const SummaryList(),
              SizedBox(height: 16.h),
              const OrdersChartCard(),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
