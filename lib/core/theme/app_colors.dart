import 'package:flutter/material.dart';

/// Paleta base tomada del borrador de diseño de Stitch
/// (design/stitch/DESIGN.md) — "Trust & Efficiency": navy profundo para
/// estructura, azul de acción para interacciones, grises fríos para
/// separar capas de datos.
class AppColors {
  AppColors._();

  // Primary — Deep Navy: navegación, headers, marca.
  static const primary = Color(0xFF041627);
  static const onPrimary = Color(0xFFFFFFFF);
  static const primaryContainer = Color(0xFF1A2B3C);
  static const onPrimaryContainer = Color(0xFF8192A7);

  // Secondary — Slate Grey: sub-headers, iconografía, texto de apoyo.
  static const secondary = Color(0xFF545F72);
  static const onSecondary = Color(0xFFFFFFFF);
  static const secondaryContainer = Color(0xFFD5E0F7);
  static const onSecondaryContainer = Color(0xFF586377);

  // Tertiary / Action Blue — reservado para CTAs e interacción primaria.
  static const actionBlue = Color(0xFF3182CE);
  static const tertiary = Color(0xFF00162C);
  static const onTertiary = Color(0xFFFFFFFF);
  static const tertiaryContainer = Color(0xFF002B4E);
  static const onTertiaryContainer = Color(0xFF4894E2);

  // Semantic — estado de viajes, vencimientos, alertas financieras.
  static const success = Color(0xFF16A34A);
  static const successContainer = Color(0xFFDCFCE7);
  static const onSuccessContainer = Color(0xFF166534);
  static const warning = Color(0xFFDD6B20);
  static const warningContainer = Color(0xFFFFEDD5);
  static const onWarningContainer = Color(0xFF9A3412);
  static const error = Color(0xFFBA1A1A);
  static const onError = Color(0xFFFFFFFF);
  static const errorContainer = Color(0xFFFFDAD6);
  static const onErrorContainer = Color(0xFF93000A);

  // Surface — capas tonales en vez de sombras marcadas.
  static const background = Color(0xFFF7FAFC);
  static const onBackground = Color(0xFF181C1E);
  static const surface = Color(0xFFF7FAFC);
  static const surfaceContainerLowest = Color(0xFFFFFFFF);
  static const surfaceContainerLow = Color(0xFFF1F4F6);
  static const surfaceContainer = Color(0xFFEBEEF0);
  static const surfaceContainerHigh = Color(0xFFE5E9EB);
  static const surfaceContainerHighest = Color(0xFFE0E3E5);
  static const onSurface = Color(0xFF181C1E);
  static const onSurfaceVariant = Color(0xFF44474C);
  static const inverseSurface = Color(0xFF2D3133);
  static const inverseOnSurface = Color(0xFFEEF1F3);

  static const outline = Color(0xFF74777D);
  static const outlineVariant = Color(0xFFC4C6CD);

  static const colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: onPrimary,
    primaryContainer: primaryContainer,
    onPrimaryContainer: onPrimaryContainer,
    secondary: secondary,
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: onSecondaryContainer,
    tertiary: actionBlue,
    onTertiary: onTertiary,
    tertiaryContainer: tertiaryContainer,
    onTertiaryContainer: onTertiaryContainer,
    error: error,
    onError: onError,
    errorContainer: errorContainer,
    onErrorContainer: onErrorContainer,
    surface: surface,
    onSurface: onSurface,
    onSurfaceVariant: onSurfaceVariant,
    outline: outline,
    outlineVariant: outlineVariant,
    inverseSurface: inverseSurface,
    onInverseSurface: inverseOnSurface,
    inversePrimary: Color(0xFFB7C8DE),
    surfaceTint: Color(0xFF4F6073),
  );
}
