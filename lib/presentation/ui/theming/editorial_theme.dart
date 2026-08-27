import 'package:flutter/material.dart';

abstract final class EditorialTheme {
  static const Color paper = Color(0xFFF1EDE2);
  static const Color paperMuted = Color(0xFFE8E1D2);
  static const Color ink = Color(0xFF191815);
  static const Color inkMuted = Color(0xFF5F5A50);
  static const Color night = Color(0xFF131311);
  static const Color nightPaper = Color(0xFF1B1A17);
  static const Color nightInk = Color(0xFFEDE7DA);
  static const Color nightMuted = Color(0xFFA9A294);
  static const Color accent = Color(0xFF5A173E);

  static ThemeData light() => _theme(
        brightness: Brightness.light,
        background: paper,
        surface: paperMuted,
        foreground: ink,
        muted: inkMuted,
      );

  static ThemeData dark() => _theme(
        brightness: Brightness.dark,
        background: night,
        surface: nightPaper,
        foreground: nightInk,
        muted: nightMuted,
      );

  static ThemeData _theme({
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color foreground,
    required Color muted,
  }) {
    final TextTheme base = ThemeData(brightness: brightness).textTheme;
    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accent,
        brightness: brightness,
        surface: surface,
      ),
      dividerColor: foreground.withValues(alpha: 0.35),
      textTheme: base.copyWith(
        displayLarge: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 68,
          height: 0.96,
          fontWeight: FontWeight.w700,
          letterSpacing: -2.2,
          color: foreground,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 44,
          height: 1,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.1,
          color: foreground,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 28,
          height: 1.1,
          fontWeight: FontWeight.w700,
          color: foreground,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 22,
          height: 1.15,
          fontWeight: FontWeight.w700,
          color: foreground,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 18,
          height: 1.55,
          color: foreground,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 15,
          height: 1.5,
          color: foreground,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Courier New',
          fontSize: 12,
          height: 1.2,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
          color: foreground,
        ),
        labelMedium: TextStyle(
          fontFamily: 'Courier New',
          fontSize: 11,
          height: 1.2,
          letterSpacing: 0.8,
          color: muted,
        ),
      ),
    );
  }
}
