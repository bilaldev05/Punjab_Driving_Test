import 'package:flutter/material.dart';

class AppTheme {
  /// 🌿 PREMIUM SOFT PALETTE (SAAS / APPLE STYLE)

  // Primary (soft indigo-blue, not harsh blue)
  static const Color primary = Color(0xFF6C8CFF);

  // Secondary accent (warm coral pastel)
  static const Color secondary = Color(0xFFFFB38A);

  // Background (soft warm gray, NOT pure white)
  static const Color background = Color(0xFFF6F7FB);

  // Surface (cards)
  static const Color surface = Color(0xFFFFFFFF);

  // Soft muted grey (inputs, borders)
  static const Color muted = Color(0xFFEAECEF);

  // Text primary (deep soft black)
  static const Color textPrimary = Color(0xFF1F2937);

  // Text secondary (muted)
  static const Color textSecondary = Color(0xFF6B7280);

  // Success / warning soft tones
  static const Color success = Color(0xFF34D399);
  static const Color warning = Color(0xFFFBBF24);
  static const Color error = Color(0xFFFB7185);

  /// 🧠 MAIN THEME
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: background,

    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: secondary,
      surface: surface,
      background: background,
      error: error,
    ),

    /// 📝 TEXT SYSTEM (VERY CLEAN + MODERN)
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: textPrimary,
        letterSpacing: -0.5,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 15,
        color: textPrimary,
        height: 1.4,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: textSecondary,
        height: 1.4,
      ),
    ),

    /// 🧱 APP BAR (CLEAN GLASS LOOK)
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: background,
      foregroundColor: textPrimary,
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),

    /// 🔘 BUTTONS (SOFT + PREMIUM)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
      ),
    ),

    /// 🪟 CARDS (VERY SOFT + FLOATING)
    cardTheme: const CardThemeData(
      color: surface,
      elevation: 0.5,
      shadowColor: Color(0x11000000),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
    ),

    /// 📦 INPUT FIELDS (MODERN SOFT INPUTS)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: muted,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
      hintStyle: const TextStyle(
        color: textSecondary,
        fontSize: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: primary,
          width: 1.2,
        ),
      ),
    ),

    /// 🧩 ICON STYLE (SOFT GREY SYSTEM)
    iconTheme: const IconThemeData(
      color: textSecondary,
      size: 22,
    ),

    /// 🔲 DIVIDER (VERY SUBTLE)
    dividerTheme: const DividerThemeData(
      color: Color(0xFFEDEFF3),
      thickness: 1,
    ),

    /// 💡 EXTRA POLISH (TOUCH FEEL)
    splashFactory: InkRipple.splashFactory,
  );
}