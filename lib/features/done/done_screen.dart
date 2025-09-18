import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/routing/app_router.dart';
import 'package:kasbli_merchant/core/utils/app_assets.dart';
import 'package:kasbli_merchant/core/widgets/primary_button.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Image.asset(AppAssets.done),
                ),
                SizedBox(height: 60.h),
                PrimaryButton(
                  text: "Done",
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRouter.login);
                  },
                  width: 270.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

