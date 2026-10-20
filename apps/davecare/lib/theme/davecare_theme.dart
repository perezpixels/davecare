import 'package:flutter/material.dart';

/// Tokens from Stitch `davidcare_patient_health/DESIGN.md` and HTML configs.
abstract final class DcColors {
  static const primary = Color(0xFF004236);
  static const primaryContainer = Color(0xFF0F5B4C);
  static const onPrimary = Color(0xFFFFFFFF);
  static const onPrimaryContainer = Color(0xFF8DD0BD);
  static const secondary = Color(0xFF046B58);
  static const secondaryContainer = Color(0xFF9FF3DB);
  static const onSecondaryContainer = Color(0xFF12715E);
  static const tertiary = Color(0xFF003D5F);
  static const tertiaryContainer = Color(0xFF005582);
  static const tertiaryFixed = Color(0xFFCCE5FF);
  static const surface = Color(0xFFFAF8FF);
  static const background = Color(0xFFFAF8FF);
  static const onSurface = Color(0xFF131B2E);
  static const onSurfaceVariant = Color(0xFF3F4945);
  static const outline = Color(0xFF6F7975);
  static const outlineVariant = Color(0xFFBFC9C4);
  static const error = Color(0xFFBA1A1A);
  static const errorContainer = Color(0xFFFFDAD6);
  static const surfaceLowest = Color(0xFFFFFFFF);
  static const surfaceLow = Color(0xFFF2F3FF);
  static const surfaceContainer = Color(0xFFEAEDFF);
  static const surfaceHigh = Color(0xFFE2E7FF);
  static const warningFg = Color(0xFFD97706);
  static const warningBg = Color(0xFFFEF3C7);
  static const successFg = Color(0xFF16A34A);
  static const successBg = Color(0xFFDCFCE7);
  static const infoFg = Color(0xFF0284C7);
  static const infoBg = Color(0xFFE0F2FE);
}

class DavecareTheme {
  static ThemeData light() {
    const text = TextTheme(
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, height: 40 / 32, letterSpacing: -0.64),
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, height: 32 / 24),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, height: 26 / 18),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16, height: 24 / 16),
      bodyMedium: TextStyle(fontSize: 14, height: 20 / 14),
      bodySmall: TextStyle(fontSize: 13, height: 18 / 13),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.24),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.33),
    );
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Segoe UI',
      colorScheme: const ColorScheme.light(
        primary: DcColors.primary,
        onPrimary: DcColors.onPrimary,
        primaryContainer: DcColors.primaryContainer,
        onPrimaryContainer: DcColors.onPrimaryContainer,
        secondary: DcColors.secondary,
        onSecondary: DcColors.onPrimary,
        secondaryContainer: DcColors.secondaryContainer,
        onSecondaryContainer: DcColors.onSecondaryContainer,
        tertiary: DcColors.tertiary,
        tertiaryContainer: DcColors.tertiaryContainer,
        error: DcColors.error,
        errorContainer: DcColors.errorContainer,
        surface: DcColors.surface,
        onSurface: DcColors.onSurface,
        onSurfaceVariant: DcColors.onSurfaceVariant,
        outline: DcColors.outline,
        outlineVariant: DcColors.outlineVariant,
      ),
      scaffoldBackgroundColor: DcColors.background,
      textTheme: text.apply(bodyColor: DcColors.onSurface, displayColor: DcColors.onSurface),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xEBFAF8FF),
        foregroundColor: DcColors.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: DcColors.onSurface),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: DcColors.primaryContainer,
          foregroundColor: DcColors.onPrimary,
          minimumSize: const Size.fromHeight(48),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: const StadiumBorder(),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DcColors.surfaceLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: DcColors.primaryContainer, width: 2),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: DcColors.surfaceLowest,
        indicatorColor: DcColors.secondaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final active = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 11,
            fontWeight: active ? FontWeight.w600 : FontWeight.w500,
            color: active ? DcColors.primary : DcColors.onSurfaceVariant,
          );
        }),
      ),
      cardTheme: CardThemeData(
        color: DcColors.surfaceLowest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
      ),
    );
  }
}
