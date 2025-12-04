import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color.fromARGB(255, 230, 162, 18);
  static const Color primaryVariant = Color.fromARGB(255, 247, 201, 149);
  static const Color secondary = Color.fromARGB(255, 0, 0, 0);
  static const Color secondaryVariant = Color(0xFFFFA000);
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF9A825);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);

  static final MaterialColor primarySwatch = _createMaterialColor(primary);

  static MaterialColor _createMaterialColor(Color color) {
    final strengths = <double>[.05];
    final swatch = <int, Color>{};
    final r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) strengths.add(0.1 * i);
    for (var strength in strengths) {
      final ds = 0.5 - strength;
      final newR = (r + ((ds < 0 ? r : (255 - r)) * ds)).round();
      final newG = (g + ((ds < 0 ? g : (255 - g)) * ds)).round();
      final newB = (b + ((ds < 0 ? b : (255 - b)) * ds)).round();
      swatch[(strength * 1000).round()] = Color.fromRGBO(newR, newG, newB, 1);
    }
    return MaterialColor(color.value, swatch);
  }
}

class AppTheme {
  AppTheme._();

  static final ThemeData light = ThemeData(
    primarySwatch: AppColors.primarySwatch,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: AppColors.primarySwatch).copyWith(
      secondary: AppColors.secondary,
      background: AppColors.background,
      surface: AppColors.surface,
      error: AppColors.error,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 1,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 247, 216, 150),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textPrimary),
      bodyMedium: TextStyle(color: AppColors.textSecondary),
    ),
  );
}