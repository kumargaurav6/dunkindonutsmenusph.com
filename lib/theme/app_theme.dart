import 'package:flutter/material.dart';

/// Brand palette for the Dunkin' PH Menu app.
class AppColors {
  static const Color pink = Color(0xFFE11384);
  static const Color pinkDark = Color(0xFFB80E68);
  static const Color orange = Color(0xFFFF6A00);
  static const Color orangeDark = Color(0xFFD45500);
  static const Color cream = Color(0xFFFFF8F0);
  static const Color dark = Color(0xFF3A2A1A);
  static const Color darkSoft = Color(0xFF6B5540);
  static const Color cardBorder = Color(0xFFF3E4D3);
}

class AppTheme {
  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.pink,
      primary: AppColors.pink,
      secondary: AppColors.orange,
      surface: AppColors.cream,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.cream,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.pink,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: 'Roboto',
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shadowColor: AppColors.pink.withValues(alpha: 0.12),
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.cardBorder, width: 1),
        ),
      ),
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          color: AppColors.dark,
          fontWeight: FontWeight.w800,
          fontFamily: 'Roboto',
        ),
        headlineSmall: TextStyle(
          color: AppColors.dark,
          fontWeight: FontWeight.w700,
          fontFamily: 'Roboto',
        ),
        titleLarge: TextStyle(
          color: AppColors.dark,
          fontWeight: FontWeight.w700,
          fontFamily: 'Roboto',
        ),
        titleMedium: TextStyle(
          color: AppColors.dark,
          fontWeight: FontWeight.w600,
          fontFamily: 'Roboto',
        ),
        bodyLarge: TextStyle(color: AppColors.dark, fontFamily: 'Roboto'),
        bodyMedium: TextStyle(color: AppColors.dark, fontFamily: 'Roboto'),
        bodySmall: TextStyle(color: AppColors.darkSoft, fontFamily: 'Roboto'),
        labelLarge: TextStyle(
            color: AppColors.dark,
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto'),
      ),
      tabBarTheme: const TabBarThemeData(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorColor: AppColors.orange,
        indicatorSize: TabBarIndicatorSize.tab,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.pink,
        unselectedItemColor: AppColors.darkSoft,
        selectedLabelStyle:
            TextStyle(fontWeight: FontWeight.w600, fontSize: 12, fontFamily: 'Roboto'),
        unselectedLabelStyle: TextStyle(fontSize: 12, fontFamily: 'Roboto'),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white,
        selectedColor: AppColors.pink,
        labelStyle:
            const TextStyle(color: AppColors.dark, fontFamily: 'Roboto'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.cardBorder),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(color: AppColors.darkSoft),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.cardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.pink, width: 1.6),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.pink,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: const TextStyle(
              fontWeight: FontWeight.w700, fontSize: 16, fontFamily: 'Roboto'),
        ),
      ),
    );
  }
}
