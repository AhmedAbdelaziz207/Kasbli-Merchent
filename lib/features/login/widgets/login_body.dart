import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/utils/app_assets.dart';
import 'package:kasbli_merchant/core/utils/app_keys.dart';
import '../../../core/widgets/app_name_widget.dart';
import 'login_form.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30.h),
          Image.asset(AppAssets.appLogo, width: 80.w, height: 80.h),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppKeys.welcomeBack.tr(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              AppNameWidget(),
            ],
          ),
          SizedBox(height: 30.h),
          LoginForm(),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }
}

