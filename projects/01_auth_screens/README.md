# 01 · Auth Screens

Modern login & sign up screens built with Flutter: glassmorphism, an animated aurora background and smooth micro-interactions.
**Zero packages.** Only Flutter and clean, readable code.

<!-- Replace with your own recording -->
<p align="center">
  <img src="screenshots/preview.gif" width="300" alt="Auth screens preview" />
</p>

## Features

- Animated aurora background and a frosted glass card
- Sliding Login / Sign Up toggle with a smooth cross-fade between forms
- Live password strength meter
- Show / hide password, autofill hints and keyboard actions
- Inline validation that clears itself as you type
- Shake animation and an error banner when something goes wrong
- Loading state inside the button
- Offline fake backend, so you can swap in Firebase or a REST API without touching the UI

## Try it

```bash
flutter pub get
flutter run
```

Demo account: `demo@example.com` / `password123`. You can also just sign up, since new accounts live in memory.

## Structure

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── theme/          # colors & ThemeData
│   ├── utils/          # validators, route, snackbar
│   └── widgets/        # aurora background, glass card, animations
└── features/
    ├── auth/
    │   ├── data/           # AuthRepository (contract) + FakeAuthRepository
    │   ├── models/         # User, PasswordStrength
    │   └── presentation/   # AuthPage, forms, and their widgets
    └── home/
```

**Why this way?**

- **Feature-first:** everything about auth lives in one folder.
- **Screens depend on `AuthRepository`, not on an implementation.** To use a real backend, write a class that implements it and pass it in `main.dart`.
- **Plain `setState`:** a form's state belongs to the form. No state management package is needed for this.

## Tests

```bash
flutter test
```

---

Part of [Flutter UI Lab](../../README.md): a new Flutter UI project every week.
