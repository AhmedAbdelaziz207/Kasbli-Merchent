import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppNameWidget extends StatelessWidget {
  const AppNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "K",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          TextSpan(
            text: "asbli",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
