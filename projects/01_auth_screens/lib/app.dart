import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/auth/presentation/auth_page.dart';

class AuthApp extends StatelessWidget {
  const AuthApp({super.key, required this.repository});

  final AuthRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Screens',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: AuthPage(repository: repository),
    );
  }
}
