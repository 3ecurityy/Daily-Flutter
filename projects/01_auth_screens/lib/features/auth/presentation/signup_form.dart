import 'package:flutter/material.dart';

import '../../../core/utils/validators.dart';
import '../../../core/widgets/shake_widget.dart';
import '../data/auth_repository.dart';
import '../models/password_strength.dart';
import '../models/user.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/error_message.dart';
import 'widgets/gradient_button.dart';
import 'widgets/password_strength_bar.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    required this.repository,
    required this.onSuccess,
  });

  final AuthRepository repository;
  final ValueChanged<User> onSuccess;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _shakeKey = GlobalKey<ShakeWidgetState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  PasswordStrength _strength = PasswordStrength.empty;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  String? _validateConfirm(String? value) {
    if (value == null || value.isEmpty) return 'Please repeat your password';
    if (value != _passwordController.text) return 'Passwords don\'t match';
    return null;
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      _shakeKey.currentState?.shake();
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = await widget.repository.signUp(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      widget.onSuccess(user);
    } on AuthException catch (e) {
      if (!mounted) return;
      setState(() => _errorMessage = e.message);
      _shakeKey.currentState?.shake();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShakeWidget(
      key: _shakeKey,
      child: Form(
        key: _formKey,
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthTextField(
                controller: _nameController,
                hint: 'Full name',
                icon: Icons.person_outline_rounded,
                keyboardType: TextInputType.name,
                autofillHints: const [AutofillHints.name],
                validator: Validators.name,
              ),
              const SizedBox(height: 14),
              AuthTextField(
                controller: _emailController,
                hint: 'Email address',
                icon: Icons.alternate_email_rounded,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                validator: Validators.email,
              ),
              const SizedBox(height: 14),
              AuthTextField(
                controller: _passwordController,
                hint: 'Password',
                icon: Icons.lock_outline_rounded,
                isPassword: true,
                autofillHints: const [AutofillHints.newPassword],
                validator: Validators.password,
                onChanged: (value) {
                  setState(() => _strength = PasswordStrength.of(value));
                },
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                child: _strength == PasswordStrength.empty
                    ? const SizedBox(width: double.infinity)
                    : Padding(
                        padding: const EdgeInsets.only(top: 10, left: 4, right: 4),
                        child: PasswordStrengthBar(strength: _strength),
                      ),
              ),
              const SizedBox(height: 14),
              AuthTextField(
                controller: _confirmController,
                hint: 'Confirm password',
                icon: Icons.lock_reset_rounded,
                isPassword: true,
                textInputAction: TextInputAction.done,
                validator: _validateConfirm,
                onSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: 24),
              ErrorMessage(message: _errorMessage),
              GradientButton(
                label: 'Create account',
                isLoading: _isLoading,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
