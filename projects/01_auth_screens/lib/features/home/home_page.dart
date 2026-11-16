import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/fade_route.dart';
import '../../core/widgets/aurora_background.dart';
import '../../core/widgets/fade_slide_in.dart';
import '../../core/widgets/glass_card.dart';
import '../auth/data/auth_repository.dart';
import '../auth/models/user.dart';
import '../auth/presentation/auth_page.dart';
import '../auth/presentation/widgets/gradient_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.user, required this.repository});

  final User user;
  final AuthRepository repository;

  Future<void> _logout(BuildContext context) async {
    await repository.logout();
    if (!context.mounted) return;

    Navigator.of(context).pushReplacement(
      fadeRoute(AuthPage(repository: repository)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuroraBackground(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: FadeSlideIn(
                  child: GlassCard(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _Avatar(name: user.name),
                        const SizedBox(height: 20),
                        Text(
                          'Hi, ${user.name} 👋',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          user.email,
                          style: const TextStyle(color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 32),
                        GradientButton(
                          label: 'Logout',
                          onPressed: () => _logout(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      height: 84,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Text(
        name.characters.first.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 34,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
