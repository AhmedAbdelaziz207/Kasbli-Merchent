
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/routing/app_router.dart';
import 'package:kasbli_merchant/core/theme/app_colors.dart';
import 'package:kasbli_merchant/core/utils/app_assets.dart';
import 'package:kasbli_merchant/features/onboarding/widgets/progress_button.dart';

import '../../core/utils/app_keys.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int pageNo = 0;

  final onboardingsData = [
    {
      "image": AppAssets.onboarding_1,
      "title": AppKeys.onboardingTitle1.tr(),
      "description": AppKeys.onboardingDesc1.tr(),
    },
    {
      "image": AppAssets.onboarding_2,
      "title": AppKeys.onboardingTitle2.tr(),
      "description": AppKeys.onboardingDesc2.tr(),
    },
    {
      "image": AppAssets.onboarding_3,
      "title": AppKeys.onboardingTitle3.tr(),
      "description": AppKeys.onboardingDesc3.tr(),
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              if (pageNo != onboardingsData.length - 1)
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, AppRouter.login),
                  child: Text(
                    "skip".tr(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50.h,),
              Expanded(child: Image.asset(onboardingsData[pageNo]["image"]!)),
              SizedBox(height: 80.h),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        onboardingsData[pageNo]["title"]!,
                        key: ValueKey(onboardingsData[pageNo]["title"]),
                        style: Theme.of(context).textTheme.headlineMedium!
                            .copyWith(color: AppColors.primaryColor),
                      ),

                      SizedBox(height: 20.h),

                      Text(
                        onboardingsData[pageNo]["description"]!,
                        key: ValueKey(onboardingsData[pageNo]["description"]),
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              ProgressButton(
                onPress: (step) {
                  setState(() {
                    pageNo = step - 1;
                  });
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}

