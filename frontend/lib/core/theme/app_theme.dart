import 'package:flutter/material.dart';

class AppThemes {
  static const Color _primaryColor = Color(0xFF1976D2);
  static const Color _primaryDarkColor = Color(0xFF1565C0);
  static const Color _primaryLightColor = Color(0xFF42A5F5);

  static const Color _secondaryColor = Color(0xFF757575);
  static const Color _secondaryDarkColor = Color(0xFF424242);
  static const Color _secondaryLightColor = Color(0xFF9E9E9E);

  static const Color _backgroundColor = Color(0xFF121212);
  static const Color _surfaceColor = Color(0xFF1E1E1E);
  static const Color _errorColor = Color(0xFFCF6679);

  static Gradient get mainGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.grey.shade900,
      Colors.black,
      Colors.grey.shade800,
    ],
  );

  static Gradient get buttonGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      _primaryDarkColor,
      _primaryColor,
      _primaryLightColor,
    ],
  );

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      colorScheme: const ColorScheme.dark(
        primary: _primaryColor,
        primaryContainer: _primaryDarkColor,
        secondary: _secondaryColor,
        secondaryContainer: _secondaryDarkColor,
        background: _backgroundColor,
        surface: _surfaceColor,
        error: _errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: Colors.white,
        onSurface: Colors.white,
        onError: Colors.black,
      ),

      scaffoldBackgroundColor: _backgroundColor,

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _primaryLightColor,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.black.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.shade800.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: _primaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: _errorColor,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: _errorColor,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
        ),
        labelStyle: const TextStyle(
          color: Colors.white70,
        ),
        floatingLabelStyle: const TextStyle(
          color: _primaryLightColor,
        ),
        errorStyle: const TextStyle(
          color: _errorColor,
        ),
        prefixIconColor: Colors.grey.shade400,
        suffixIconColor: Colors.grey.shade400,
      ),

      // Карточки
      cardTheme: CardTheme(
        color: _surfaceColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.all(8),
      ),

      // Диалоги
      dialogTheme: DialogTheme(
        backgroundColor: _surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
      ),

      // SnackBar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: _surfaceColor,
        contentTextStyle: const TextStyle(color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Разделители
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade800,
        thickness: 1,
        space: 1,
      ),

      // Progress Indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: _primaryColor,
        circularTrackColor: Colors.white24,
      ),

      // Текст
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white70,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.white60,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Colors.white70,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: Colors.white60,
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        labelSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.white60,
        ),
      ),
    );
  }

  static BoxDecoration get glassMorphismDecoration => BoxDecoration(
    color: Colors.black.withOpacity(0.3),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(
      color: Colors.grey.shade800.withOpacity(0.5),
      width: 1.5,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.5),
        blurRadius: 25,
        spreadRadius: 3,
        offset: const Offset(0, 10),
      ),
      BoxShadow(
        color: Colors.grey.shade900.withOpacity(0.3),
        blurRadius: 10,
        spreadRadius: 1,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static BoxDecoration get inputShadowDecoration => BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.4),
        blurRadius: 15,
        offset: const Offset(0, 5),
      ),
    ],
  );

  static BoxDecoration get buttonShadowDecoration => BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: _primaryDarkColor.withOpacity(0.4),
        blurRadius: 15,
        spreadRadius: 2,
        offset: const Offset(0, 5),
      ),
    ],
  );
}