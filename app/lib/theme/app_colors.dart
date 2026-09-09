import 'package:flutter/material.dart';

/// Valores semánticos del sistema de diseño para el tema activo
/// (ver docs/paletas-de-color.md). Uso:
///
/// ```dart
/// final colors = AppColors.of(context);
/// colors.accent, colors.surface2, …
/// ```
class AppColorsValues {
  const AppColorsValues._({
    required this.bg,
    required this.surface,
    required this.surface2,
    required this.ink,
    required this.muted,
    required this.line,
    required this.accent,
    required this.accentInk,
    required this.accentSoft,
    required this.ok,
    required this.okSoft,
    required this.star,
    required this.starSoft,
    required this.danger,
    required this.dangerSoft,
    required this.mapLand,
    required this.mapRoad,
    required this.mapPark,
    required this.mapWater,
  });

  // Fondos y superficies
  final Color bg, surface, surface2;

  // Texto
  final Color ink, muted, line;

  // Semánticos
  final Color accent, accentInk, accentSoft;
  final Color ok, okSoft;
  final Color star, starSoft;
  final Color danger, dangerSoft;

  // Mapa (tierra, calles, parque, agua — el río Biobío)
  final Color mapLand, mapRoad, mapPark, mapWater;
}

/// Fábrica de [AppColorsValues] según el brillo del tema.
///
/// La paleta Estándar es la base de la app; las temáticas
/// (atardecer/bosque/cítrica/tropical) se evalúan para versiones futuras.
abstract final class AppColors {
  static const _light = AppColorsValues._(
    bg: Color(0xFFEEF1F5),
    surface: Color(0xFFFFFFFF),
    surface2: Color(0xFFF4F6F9),
    ink: Color(0xFF1B2430),
    muted: Color(0xFF6B7684),
    line: Color(0xFFD8DEE6),
    accent: Color(0xFF2563EB),
    accentInk: Color(0xFFFFFFFF),
    accentSoft: Color(0xFFE4ECFB),
    ok: Color(0xFF15803D),
    okSoft: Color(0xFFDCFCE7),
    star: Color(0xFFD97706),
    starSoft: Color(0xFFFEF3C7),
    danger: Color(0xFFDC2626),
    dangerSoft: Color(0xFFFEE2E2),
    mapLand: Color(0xFFF1EFE9),
    mapRoad: Color(0xFFFFFFFF),
    mapPark: Color(0xFFCDE8C8),
    mapWater: Color(0xFFB7D6EE),
  );

  static const _dark = AppColorsValues._(
    bg: Color(0xFF151A21),
    surface: Color(0xFF1E242D),
    surface2: Color(0xFF262D37),
    ink: Color(0xFFEDF1F6),
    muted: Color(0xFF98A2B0),
    line: Color(0xFF37404C),
    accent: Color(0xFF5B8DEF),
    accentInk: Color(0xFF0B1220),
    accentSoft: Color(0xFF233555),
    ok: Color(0xFF4ADE80),
    okSoft: Color(0xFF173A26),
    star: Color(0xFFFBBF24),
    starSoft: Color(0xFF3F3313),
    danger: Color(0xFFF87171),
    dangerSoft: Color(0xFF4A1F1F),
    mapLand: Color(0xFF2A2F36),
    mapRoad: Color(0xFF3A414B),
    mapPark: Color(0xFF2E4A33),
    mapWater: Color(0xFF243A52),
  );

  static AppColorsValues of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? _dark : _light;
}
