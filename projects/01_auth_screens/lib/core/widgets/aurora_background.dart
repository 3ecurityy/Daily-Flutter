import 'dart:math';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Soft colored blobs that slowly float behind the content.
class AuroraBackground extends StatefulWidget {
  const AuroraBackground({super.key, required this.child});

  final Widget child;

  @override
  State<AuroraBackground> createState() => _AuroraBackgroundState();
}

class _AuroraBackgroundState extends State<AuroraBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 14),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(child: ColoredBox(color: AppColors.background)),
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final t = _controller.value * 2 * pi;

              return Stack(
                children: [
                  _Blob(
                    color: AppColors.primary,
                    size: 420,
                    alignment: Alignment(-0.9 + 0.3 * sin(t), -0.8 + 0.2 * cos(t)),
                  ),
                  _Blob(
                    color: AppColors.secondary,
                    size: 320,
                    alignment: Alignment(1.0 + 0.2 * cos(t), -0.1 + 0.3 * sin(t)),
                  ),
                  _Blob(
                    color: AppColors.pink,
                    size: 360,
                    alignment: Alignment(-0.4 + 0.3 * cos(t), 1.0 + 0.15 * sin(t)),
                  ),
                ],
              );
            },
          ),
        ),
        widget.child,
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({
    required this.color,
    required this.size,
    required this.alignment,
  });

  final Color color;
  final double size;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: 0.45),
              color.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}
