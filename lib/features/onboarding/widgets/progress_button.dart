import 'package:flutter/material.dart';
import 'package:kasbli_merchant/core/routing/app_router.dart';
import '../../../core/theme/app_colors.dart';

class ProgressButton extends StatefulWidget {
  const ProgressButton({super.key, this.onPress});

  final Function(int step)? onPress;

  @override
  State<ProgressButton> createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _animation;

  double _progress = .33;
  int _tapCount = 1;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isAnimating = false;

        // Final step: progress full, no reset
        if (_tapCount == 3) {
          setState(() {
            _progress = 1.0;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    if (_isAnimating || _tapCount >= 3) {
      Navigator.pushNamed(context, AppRouter.login);
      return;
    }

    setState(() {
      _isAnimating = true;
      _tapCount++;
    });

    final double start = _progress;
    final double end = (_tapCount / 3).clamp(0.0, 1.0);

    _animation = Tween<double>(begin: start, end: end).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addListener(() {
      setState(() {
        _progress = _animation.value;
      });
    });

    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    const double size = 75;
    const double stroke = 5;

    return GestureDetector(
      onTap: () {
        _onTap();
        widget.onPress?.call(_tapCount);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: _progress,
              strokeWidth: stroke,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primaryColor,
              ),
              backgroundColor: AppColors.blackLight,
            ),
          ),
          AnimatedScale(
            scale: _isAnimating ? 0.9 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.blackLight,
              ),
              child: Center(
                child: _tapCount == 3
                    ? const Text(
                  "GO",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
                    : const Icon(
                  Icons.arrow_forward,
                  color: AppColors.primaryColor,
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

