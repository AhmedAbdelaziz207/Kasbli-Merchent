import 'package:flutter/material.dart';
import 'package:kasbli_merchant/core/utils/app_assets.dart';
import 'stat_card.dart';

class StatsGrid extends StatelessWidget {
  final List<_StatItem> items;

  const StatsGrid({super.key, required this.items});

  factory StatsGrid.sample() => StatsGrid(
        items: const [
          _StatItem('Orders Are Pending', '20', AppAssets.ordersPending),
          _StatItem('Total Orders', '150', AppAssets.totalOrders),
          _StatItem('Completed Orders', '30', AppAssets.ordersCompleted),
          _StatItem('Order Are Prepared', '70', AppAssets.ordersPrepared),
          _StatItem('Returned Orders', '25', AppAssets.ordersReturned),
          _StatItem('Canceled orders', '60', AppAssets.ordersCanceled),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return StatCard(
          title: item.title,
          value: item.value,
          trailingIcon: item.icon,
        );
      },
    );
  }
}

class _StatItem {
  final String title;
  final String value;
  final String icon;
  const _StatItem(this.title, this.value, this.icon);
}
