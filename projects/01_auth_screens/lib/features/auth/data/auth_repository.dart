import '../models/user.dart';

/// The UI only talks to this contract, so the real backend
/// (Firebase, REST API, ...) can be plugged in without touching any screen.
abstract interface class AuthRepository {
  Future<User> login({required String email, required String password});

  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<void> logout();
}

class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}
