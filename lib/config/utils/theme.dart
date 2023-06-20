import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:y23/config/utils/colors.dart';

class AppTheme {
  static ThemeData darkModeTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,

      //* Color Scheme
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.green,
        onPrimary: Colors.black,
        secondary: AppColors.fifthlyColor,
        onSecondary: AppColors.thirdlyColor,
        error: AppColors.error,
        onError: AppColors.error,
        background: AppColors.primaryColor,
        onBackground: Colors.grey.shade600,
        surface: AppColors.primaryColor,
        onSurface: AppColors.fourthlyColor,
        outline: AppColors.fakeWhite,
        tertiary: Colors.grey.shade800,
      ),

      //* AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),

      //* Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor,
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
        headlineLarge: TextStyle(
          fontSize: 30.0,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontSize: 22.0,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          fontSize: 20.0,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          fontSize: 12.0,
          color: AppColors.fakeWhite,
        ),
      ),

      //* DatePicker
      datePickerTheme: const DatePickerThemeData(
        backgroundColor: AppColors.fakeWhite,
      ),

      //* TextField
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),

      //* ListTile
      listTileTheme: ListTileThemeData(
        iconColor: AppColors.fakeWhite.withOpacity(0.8),
        titleTextStyle: TextStyle(
          fontSize: 15,
          color: AppColors.fakeWhite.withOpacity(0.8),
        ),
      ),

      //* Card
      cardTheme: const CardTheme(
        elevation: 0,
        color: AppColors.sessionColorDarkTheme,
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
        color: AppColors.fakeWhite,
      ),

      //* BottomNavigationBar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(
          fontStyle: FontStyle.normal,
        ),
        unselectedLabelStyle: TextStyle(
          fontStyle: FontStyle.normal,
        ),
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
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  static ThemeData lightModeTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,

      //* Color Scheme
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.green,
        onPrimary: Colors.grey,
        secondary: AppColors.primaryColor.withOpacity(0.5),
        onSecondary: AppColors.secondlyColor,
        error: AppColors.error,
        onError: AppColors.error,
        background: AppColors.primaryColor,
        onBackground: AppColors.fakeWhite,
        surface: AppColors.primaryColor,
        onSurface: AppColors.secondlyColor,
        outline: Colors.black,
        tertiary: AppColors.fakeWhite.withAlpha(100),
      ),

      //* AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: AppColors.primaryColor,
        ),
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),

      //* Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor,
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
        headlineLarge: TextStyle(
          fontSize: 30.0,
          color: AppColors.thirdlyColor,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontSize: 22.0,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          fontSize: 20.0,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          fontSize: 12.0,
          color: AppColors.fakeWhite,
        ),
      ),

      //* DatePicker
      datePickerTheme: const DatePickerThemeData(
        backgroundColor: AppColors.fakeWhite,
      ),

      //* TextField
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),

      //* ListTile
      listTileTheme: ListTileThemeData(
        iconColor: AppColors.fakeWhite,
        titleTextStyle: TextStyle(
          fontSize: 15,
          color: AppColors.fakeWhite.withOpacity(0.8),
        ),
        subtitleTextStyle: const TextStyle(
          fontSize: 13,
          color: AppColors.primaryColor,
        ),
      ),

      //* Card
      cardTheme: const CardTheme(
        elevation: 0,
        color: AppColors.sessionColorLightTheme,
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
        color: AppColors.fakeWhite,
      ),

      //* BottomNavigationBar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.secondlyColor,
        selectedItemColor: AppColors.fakeWhite,
        unselectedItemColor: AppColors.grey,
        selectedLabelStyle: TextStyle(
          fontStyle: FontStyle.normal,
        ),
        unselectedLabelStyle: TextStyle(
          fontStyle: FontStyle.normal,
        ),
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
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
