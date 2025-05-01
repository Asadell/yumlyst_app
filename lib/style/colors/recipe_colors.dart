import 'package:flutter/material.dart';

enum RecipeColors {
  // Primary colors
  primary50("Primary 50", Color(0xFFFCDAB0)),
  primary300("Primary 300", Color(0xFFFAC27F)),
  primary500("Primary 500", Color(0xFFF9AB4E)),
  primary700("Primary 700", Color(0xFFF7941E)),
  primary900("Primary 900", Color(0xFFD97908)),

  // Secondary colors
  secondary50("Secondary 50", Color(0xFFB0D7FC)),
  secondary300("Secondary 300", Color(0xFF7FBDFA)),
  secondary500("Secondary 500", Color(0xFF4EA4F9)),
  secondary700("Secondary 700", Color(0xFF1E8BF7)),
  secondary900("Secondary 900", Color(0xFF0871D9)),

  // Neutral colors
  neutral50("Neutral 50", Color(0xFFF8FAFC)),
  neutral100("Neutral 100", Color(0xFFF1F5F9)),
  neutral200("Neutral 200", Color(0xFFE2E8F0)),
  neutral300("Neutral 300", Color(0xFFCBD5E1)),
  neutral400("Neutral 400", Color(0xFF94A3B8)),
  neutral500("Neutral 500", Color(0xFF64748B)),
  neutral600("Neutral 600", Color(0xFF475569)),
  neutral700("Neutral 700", Color(0xFF334155)),
  neutral800("Neutral 800", Color(0xFF1E293B)),
  neutral900("Neutral 900", Color(0xFF0F172A)),

  // Success colors
  success50("Success 50", Color(0xFF95FDB9)),
  success300("Success 300", Color(0xFF63FD97)),
  success500("Success 500", Color(0xFF31FC76)),
  success700("Success 700", Color(0xFF04F756)),
  success900("Success 900", Color(0xFF03C444)),

  // Error colors
  error50("Error 50", Color(0xFFFF8A8A)),
  error300("Error 300", Color(0xFFFF5757)),
  error500("Error 500", Color(0xFFFF2424)),
  error700("Error 700", Color(0xFFEE0000)),
  error900("Error 900", Color(0xFFBD0000)),

  // Gold colors
  gold50("Gold 50", Color(0xFFFFF8E5)),
  gold300("Gold 300", Color(0xFFFFE6B2)),
  gold500("Gold 500", Color(0xFFFFD47F)),
  gold700("Gold 700", Color(0xFFFFC24C)),
  gold900("Gold 900", Color(0xFFFFA219)),

  // Other common colors
  white("White", Color(0xFFFFFFFF)),
  black("Black", Color(0xFF000000));

  const RecipeColors(this.label, this.color);

  final String label;
  final Color color;
}
