import 'package:flutter/material.dart';

class AppTheme {
  static final Color primaryIndigo = Colors.indigo[400]!;
  static final Color darkGrey = Colors.grey[800]!;
  static final Color mediumGrey = Colors.grey[600]!;
  static final Color lightGrey = Colors.grey[300]!;
  static final Color extraLightGrey = Colors.grey[100]!;
  static final Color black = Colors.black87;

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: lightGrey,

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: AppTheme.darkGrey),
        titleTextStyle: TextStyle(
          color: AppTheme.primaryIndigo,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: AppTheme.darkGrey,
        suffixIconColor: AppTheme.darkGrey,
        fillColor: AppTheme.extraLightGrey,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
      ),

      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 2,
        color: AppTheme.extraLightGrey,
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: primaryIndigo,
          foregroundColor: AppTheme.extraLightGrey,
          elevation: 3,
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}
