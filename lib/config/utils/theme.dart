import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getApplicationTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,

      //* AppBar
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),

      //* Button
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.blue,
        textTheme: ButtonTextTheme.primary,
      ),

      //* ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
      ),

      //* Text
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 72.0,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          fontSize: 36.0,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
        ),
      ),

      //* TextField
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),

      //* Card
      cardTheme: const CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),

      //* Divider
      dividerTheme: const DividerThemeData(
        thickness: 1,
      ),

      //* Icon
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),

      //* BottomNavigationBar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
      ),

      //* TabBar
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
      ),

      //* Scaffold
      scaffoldBackgroundColor: Colors.transparent,

      //* Dialog
      dialogTheme: const DialogTheme(
        backgroundColor: Colors.transparent,
      ),

      //* SnackBar
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.blue,
        contentTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),

      //* BottomSheet
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      ),

      //* Chip
      chipTheme: const ChipThemeData(
        backgroundColor: Colors.blue,
        labelStyle: TextStyle(
          color: Colors.white,
        ),
      ),

      //* Tooltip
      tooltipTheme: const TooltipThemeData(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        textStyle: TextStyle(
          color: Colors.white,
        ),
      ),

      //* ToggleButtons
      toggleButtonsTheme: const ToggleButtonsThemeData(
        color: Colors.white,
        selectedColor: Colors.white,
        fillColor: Colors.blue,
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),

      //* Cupertino
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: Colors.blue,
      ),

      //* PageTransition
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
