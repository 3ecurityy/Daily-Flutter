import 'package:auth_screens/core/utils/validators.dart';
import 'package:auth_screens/features/auth/data/auth_repository.dart';
import 'package:auth_screens/features/auth/data/fake_auth_repository.dart';
import 'package:auth_screens/features/auth/models/password_strength.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators', () {
    test('email', () {
      expect(Validators.email(''), isNotNull);
      expect(Validators.email('not-an-email'), isNotNull);
      expect(Validators.email('hello@example.com'), isNull);
    });

    test('password needs at least 8 characters', () {
      expect(Validators.password('1234567'), isNotNull);
      expect(Validators.password('12345678'), isNull);
    });
  });

  test('password strength', () {
    expect(PasswordStrength.of(''), PasswordStrength.empty);
    expect(PasswordStrength.of('abc'), PasswordStrength.weak);
    expect(PasswordStrength.of('password123'), PasswordStrength.medium);
    expect(PasswordStrength.of('Pa\$\$word123'), PasswordStrength.strong);
  });

  group('FakeAuthRepository', () {
    late FakeAuthRepository repository;

    setUp(() => repository = FakeAuthRepository(delay: Duration.zero));

    test('logs in with the demo account', () async {
      final user = await repository.login(
        email: 'demo@example.com',
        password: 'password123',
      );
      expect(user.name, 'Demo User');
    });

    test('rejects a wrong password', () {
      expect(
        repository.login(email: 'demo@example.com', password: 'wrong-pass'),
        throwsA(isA<AuthException>()),
      );
    });

    test('a new account can log in right after signing up', () async {
      await repository.signUp(name: 'Sara', email: 'Sara@Mail.com', password: 'secret123');
      final user = await repository.login(email: 'sara@mail.com', password: 'secret123');
      expect(user.name, 'Sara');
    });

    test('does not allow the same email twice', () {
      expect(
        repository.signUp(name: 'Someone', email: 'demo@example.com', password: '12345678'),
        throwsA(isA<AuthException>()),
      );
    });
  });
}
