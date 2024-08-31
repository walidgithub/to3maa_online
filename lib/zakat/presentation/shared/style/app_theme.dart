import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_constants.dart';
import 'package:To3maa/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/app_typography.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.cPrimary),
      primarySwatch: Colors.teal,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.cBackGround,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: AppColors.cBlack,
        ),
        backgroundColor: AppColors.cBackGround,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10.h,
          vertical: 5.h,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.cBorder),
          borderRadius: BorderRadius.circular(AppConstants.radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.cBorder),
          borderRadius: BorderRadius.circular(AppConstants.radius),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.cBorder),
          borderRadius: BorderRadius.circular(AppConstants.radius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.cBorder),
          borderRadius: BorderRadius.circular(AppConstants.radius),
        ),
        hintStyle: AppTypography.kLight14,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10.h,
          vertical: 5.h,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.cBorder),
          borderRadius: BorderRadius.circular(AppConstants.radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.cBorder),
          borderRadius: BorderRadius.circular(AppConstants.radius),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.cBorder),
          borderRadius: BorderRadius.circular(AppConstants.radius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.cBorder),
          borderRadius: BorderRadius.circular(AppConstants.radius),
        ),
        hintStyle: AppTypography.kLight14,
      )),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.cBackGround,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ));
}

// Default Overlay.
SystemUiOverlayStyle defaultOverlay = const SystemUiOverlayStyle(
  statusBarColor: AppColors.cTransparent,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarColor: AppColors.cBlack,
  systemNavigationBarDividerColor: AppColors.cTransparent,
  systemNavigationBarIconBrightness: Brightness.light,
);
