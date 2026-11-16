import '../models/user.dart';
import 'auth_repository.dart';

/// Keeps accounts in memory so the app runs without any backend.
class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({this.delay = const Duration(milliseconds: 1200)});

  final Duration delay;

  final _accounts = <String, ({String name, String password})>{
    'demo@example.com': (name: 'Demo User', password: 'password123'),
  };

  @override
  Future<User> login({required String email, required String password}) async {
    await Future<void>.delayed(delay);

    final key = email.toLowerCase();
    final account = _accounts[key];
    if (account == null || account.password != password) {
      throw const AuthException('Email or password is incorrect');
    }

    return User(name: account.name, email: key);
  }

  @override
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(delay);

    final key = email.toLowerCase();
    if (_accounts.containsKey(key)) {
      throw const AuthException('An account with this email already exists');
    }

    _accounts[key] = (name: name, password: password);
    return User(name: name, email: key);
  }

  @override
  Future<void> logout() => Future<void>.delayed(const Duration(milliseconds: 300));
}
