import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';

class OtpTimerText extends StatefulWidget {
  const OtpTimerText({super.key});

  @override
  State<OtpTimerText> createState() => _OtpTimerTextState();
}

class _OtpTimerTextState extends State<OtpTimerText> {
  late Timer _timer;
  int _secondsRemaining = 300; // 5 minutes in seconds

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatTime(_secondsRemaining),
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        fontSize: 16.sp,
        color: AppColors.black,
      ),
    );
  }
}
