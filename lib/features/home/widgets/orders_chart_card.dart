import 'package:flutter/material.dart';
import 'orders_donut_chart.dart';

class OrdersChartCard extends StatelessWidget {
  const OrdersChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Orders Chart',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          OrdersDonutChart.sample(),
          const SizedBox(height: 12),
          const _Legend(),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend();

  static const _items = [
    _LegendItem('Orders Are Pending', Color(0xFFFF9E6E), '20'),
    _LegendItem('Completed Orders', Color(0xFF1FA392), '105'),
    _LegendItem('Total Orders', Colors.black54, '150'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _items
          .map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Container(width: 10, height: 10, decoration: BoxDecoration(color: e.color, shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Expanded(child: Text(e.label, style: Theme.of(context).textTheme.bodySmall)),
                    Text(e.value, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

class _LegendItem {
  final String label;
  final Color color;
  final String value;
  const _LegendItem(this.label, this.color, this.value);
}
