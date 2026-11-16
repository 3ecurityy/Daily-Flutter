import 'package:auth_screens/app.dart';
import 'package:auth_screens/features/auth/data/fake_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 1000));
    await tester.pumpWidget(AuthApp(repository: FakeAuthRepository(delay: Duration.zero)));
    await tester.pump(const Duration(seconds: 1));
  }

  testWidgets('shows validation errors on empty login', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Login').last);
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('switches to the sign up form', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Sign Up'));
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Create account'), findsWidgets);
    expect(find.text('Full name'), findsOneWidget);
  });

  testWidgets('demo account lands on the home page', (tester) async {
    await pumpApp(tester);

    await tester.enterText(find.byType(TextFormField).at(0), 'demo@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.tap(find.text('Login').last);
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Hi, Demo User 👋'), findsOneWidget);
  });
}
