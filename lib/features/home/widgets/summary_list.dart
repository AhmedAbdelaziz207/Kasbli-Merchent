import 'package:flutter/material.dart';
import 'package:kasbli_merchant/core/utils/app_assets.dart';
import 'summary_tile.dart';

class SummaryList extends StatelessWidget {
  const SummaryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: const Column(
        children: [
          SummaryTile(icon: AppAssets.ordersPrepared, title: 'Sales', amount: '\$ 25,091,000'),
          Divider(height: 0),
          SummaryTile(icon: AppAssets.ordersPrepared, title: 'Dues', amount: '\$ 25,091,000'),
          Divider(height: 0),
          SummaryTile(icon: AppAssets.ordersPrepared, title: 'Upcoming dues', amount: '\$ 25,091,000'),
          Divider(height: 0),
          SummaryTile(icon: AppAssets.ordersPrepared, title: 'Total dues', amount: '\$ 25,091,000'),
        ],
      ),
    );
  }
}
