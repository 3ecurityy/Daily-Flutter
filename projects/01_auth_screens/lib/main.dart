import 'package:flutter/material.dart';

import 'app.dart';
import 'features/auth/data/fake_auth_repository.dart';

void main() {
  runApp(AuthApp(repository: FakeAuthRepository()));
}
