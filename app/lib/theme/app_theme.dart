import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Temas claro y oscuro construidos sobre los tokens del mockup.
///
/// Tipografía: Plus Jakarta Sans (interfaz) e IBM Plex Mono (datos/códigos),
/// cargadas con google_fonts en tiempo de ejecución.
class AppTheme {
  AppTheme._();

  static ThemeData light() => _base(Brightness.light);
  static ThemeData dark() => _base(Brightness.dark);

  static ThemeData _base(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    final scheme = ColorScheme(
      brightness: brightness,
      primary: dark ? const Color(0xFF5B8DEF) : const Color(0xFF2563EB),
      onPrimary: dark ? const Color(0xFF0B1220) : Colors.white,
      secondary: dark ? const Color(0xFFFBBF24) : const Color(0xFFD97706),
      onSecondary: Colors.white,
      error: dark ? const Color(0xFFF87171) : const Color(0xFFDC2626),
      onError: Colors.white,
      surface: dark ? const Color(0xFF1E242D) : Colors.white,
      onSurface: dark ? const Color(0xFFEDF1F6) : const Color(0xFF1B2430),
      surfaceContainerHighest:
          dark ? const Color(0xFF262D37) : const Color(0xFFF4F6F9),
    );

    final textTheme = GoogleFonts.plusJakartaSansTextTheme(
      dark ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor:
          dark ? const Color(0xFF151A21) : const Color(0xFFEEF1F5),
      textTheme: textTheme,
      dividerColor: dark ? const Color(0xFF37404C) : const Color(0xFFD8DEE6),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor:
            dark ? const Color(0xFFEDF1F6) : const Color(0xFF1B2430),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800,
        ),
      ),
      cardTheme: CardThemeData(
        color: dark ? const Color(0xFF1E242D) : Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: dark ? const Color(0xFF37404C) : const Color(0xFFD8DEE6),
          ),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: dark ? const Color(0xFF262D37) : const Color(0xFFF4F6F9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(44),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: dark ? const Color(0xFF1E242D) : Colors.white,
        selectedColor: dark ? const Color(0xFF233555) : const Color(0xFFE4ECFB),
        side: WidgetStateBorderSide.resolveWith(
          (states) => BorderSide(
            color: states.contains(WidgetState.selected)
                ? (dark ? const Color(0xFF5B8DEF) : const Color(0xFF2563EB))
                : (dark ? const Color(0xFF37404C) : const Color(0xFFD8DEE6)),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }

  /// IBM Plex Mono para códigos, distancias y metadatos.
  static TextStyle mono(BuildContext context, {double size = 12}) =>
      GoogleFonts.ibmPlexMono(fontSize: size);
}
