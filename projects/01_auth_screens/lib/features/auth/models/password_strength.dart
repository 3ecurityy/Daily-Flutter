enum PasswordStrength {
  empty(0, ''),
  weak(1, 'Weak'),
  medium(2, 'Medium'),
  strong(3, 'Strong');

  const PasswordStrength(this.level, this.label);

  final int level;
  final String label;

  static PasswordStrength of(String password) {
    if (password.isEmpty) return empty;

    var score = 0;
    if (password.length >= 8) score++;
    if (password.contains(RegExp(r'[a-z]')) && password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[^a-zA-Z0-9]'))) score++;

    if (score <= 1) return weak;
    if (score <= 3) return medium;
    return strong;
  }
}
