import 'package:flutter/material.dart';
import 'package:kasbli_merchant/core/theme/app_colors.dart';

class HomeHeader extends StatelessWidget {
  final String name;
  final VoidCallback? onAdd;
  final VoidCallback? onNotifications;

  const HomeHeader({
    super.key,
    required this.name,
    this.onAdd,
    this.onNotifications,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Welcome $name',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          _IconButton(
            icon: Icons.add_circle_outline,
            onTap: onAdd,
            color: AppColors.black,
          ),
          const SizedBox(width: 8),
          _IconButton(
            icon: Icons.notifications_none,
            onTap: onNotifications,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _IconButton({required this.icon, this.onTap, this.color = AppColors.black});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, color: color),
        ),
      ),
    );
  }
}
