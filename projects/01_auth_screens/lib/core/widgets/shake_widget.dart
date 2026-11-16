import 'dart:math';

import 'package:flutter/material.dart';

/// Shakes its child horizontally, like a "no" gesture.
/// Give it a `GlobalKey<ShakeWidgetState>` and call `shake()` on it.
class ShakeWidget extends StatefulWidget {
  const ShakeWidget({super.key, required this.child});

  final Widget child;

  @override
  State<ShakeWidget> createState() => ShakeWidgetState();
}

class ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  void shake() => _controller.forward(from: 0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final progress = _controller.value;
        final dx = sin(progress * pi * 4) * 10 * (1 - progress);

        return Transform.translate(offset: Offset(dx, 0), child: child);
      },
    );
  }
}
