import 'package:flutter/material.dart';

import '../../../core/utils/fade_route.dart';
import '../../../core/utils/snackbar.dart';
import '../../../core/widgets/aurora_background.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/glass_card.dart';
import '../../home/home_page.dart';
import '../data/auth_repository.dart';
import '../models/user.dart';
import 'login_form.dart';
import 'signup_form.dart';
import 'widgets/auth_header.dart';
import 'widgets/auth_mode_switch.dart';
import 'widgets/social_buttons.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, required this.repository});

  final AuthRepository repository;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthMode _mode = AuthMode.login;

  void _openHome(User user) {
    Navigator.of(context).pushReplacement(
      fadeRoute(HomePage(user: user, repository: widget.repository)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuroraBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  children: [
                    FadeSlideIn(child: AuthHeader(mode: _mode)),
                    const SizedBox(height: 32),
                    FadeSlideIn(
                      delay: const Duration(milliseconds: 150),
                      child: GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AuthModeSwitch(
                              mode: _mode,
                              onChanged: (mode) => setState(() => _mode = mode),
                            ),
                            const SizedBox(height: 24),
                            _buildForm(),
                            const SizedBox(height: 24),
                            SocialButtons(
                              onPressed: () => showMessage(context, 'Social login is coming soon'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    // AnimatedSize smooths the height change, AnimatedSwitcher cross-fades the forms.
    return AnimatedSize(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
      alignment: Alignment.topCenter,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        layoutBuilder: (current, previous) => Stack(
          alignment: Alignment.topCenter,
          children: [...previous, ?current],
        ),
        child: switch (_mode) {
          AuthMode.login => LoginForm(
            key: const ValueKey(AuthMode.login),
            repository: widget.repository,
            onSuccess: _openHome,
          ),
          AuthMode.signUp => SignUpForm(
            key: const ValueKey(AuthMode.signUp),
            repository: widget.repository,
            onSuccess: _openHome,
          ),
        },
      ),
    );
  }
}
