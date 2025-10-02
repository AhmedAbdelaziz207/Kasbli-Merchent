import 'package:flutter/material.dart';

class OrdersDonutChart extends StatelessWidget {
  final List<_Slice> slices;

  const OrdersDonutChart({super.key, required this.slices});

  factory OrdersDonutChart.sample() => OrdersDonutChart(
        slices: const [
          _Slice(color: Color(0xFF1FA392), value: 105, label: 'Completed Orders'),
          _Slice(color: Color(0xFFFF9E6E), value: 20, label: 'Orders Are Pending'),
          _Slice(color: Color(0xFFFFD9B3), value: 70, label: 'Order Are Prepared'),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: _DonutPainter(slices),
        child: Center(
          child: Container(
            width: 50,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final List<_Slice> slices;
  _DonutPainter(this.slices);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final thickness = size.shortestSide * 0.16;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.butt;

    final total = slices.fold<double>(0, (sum, s) => sum + s.value);
    double start = -90.0; // start at top

    for (final s in slices) {
      final sweep = (s.value / total) * 360.0;
      paint.color = s.color;
      canvas.drawArc(rect.deflate(thickness / 2), _deg2rad(start), _deg2rad(sweep), false, paint);
      start += sweep;
    }
  }

  double _deg2rad(double deg) => deg * 3.1415926535 / 180;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Slice {
  final Color color;
  final double value;
  final String label;
  const _Slice({required this.color, required this.value, required this.label});
}
