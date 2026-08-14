import 'package:flutter/material.dart';

/// Escala tipográfica del borrador de Stitch (design/stitch/DESIGN.md),
/// toda en Inter. `dataMono` no tiene un slot nativo en [TextTheme]: se
/// usa para cifras en tablas (montos, IDs) donde importa la alineación.
class AppTextTheme {
  AppTextTheme._();

  static const _fontFamily = 'Inter';

  static const dataMono = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    letterSpacing: -0.14,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static TextTheme build(Color onSurface, Color onSurfaceVariant) {
    final base = TextTheme(
      displayLarge: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 48,
        height: 56 / 48,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.96,
        color: onSurface,
      ),
      headlineLarge: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 32,
        height: 40 / 32,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.32,
        color: onSurface,
      ),
      headlineMedium: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 24,
        height: 32 / 24,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
      headlineSmall: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 20,
        height: 28 / 20,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
      titleMedium: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
      bodyLarge: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 18,
        height: 28 / 18,
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      bodyMedium: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      bodySmall: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w400,
        color: onSurfaceVariant,
      ),
      labelLarge: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
      labelMedium: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.6,
        color: onSurfaceVariant,
      ),
    );
    return base;
  }
}
