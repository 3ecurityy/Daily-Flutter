import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'auth_mode_switch.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.mode});

  final AuthMode mode;

  @override
  Widget build(BuildContext context) {
    final isLogin = mode == AuthMode.login;

    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.5),
                blurRadius: 32,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 36),
        ),
        const SizedBox(height: 28),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            isLogin ? 'Welcome back' : 'Create account',
            key: ValueKey(mode),
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
        ),
        const SizedBox(height: 8),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            isLogin ? 'Sign in to pick up where you left off' : 'It only takes a minute',
            key: ValueKey(mode),
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
