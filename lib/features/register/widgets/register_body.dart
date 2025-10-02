import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/utils/app_keys.dart';
import 'package:kasbli_merchant/features/register/widgets/register_form.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/app_name_widget.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              SizedBox(height: 30.h),
              Image.asset(AppAssets.appLogo, width: 80.w, height: 80.h),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppKeys.welcomeTo.tr(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  AppNameWidget(),
                ],
              ),
              SizedBox(height: 30.h),
              RegisterForm(),
            ],
          ),
        ),
      ),
    );
  }
}
