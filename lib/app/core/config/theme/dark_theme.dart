import 'dart:ui' show Color;

import 'package:flutter/material.dart'
    show AppBarTheme, BorderRadius, BorderSide, Brightness, ButtonStyle, CardThemeData, CheckboxThemeData, ColorScheme, Colors, DialogThemeData, DividerThemeData, ElevatedButtonThemeData, ExpansionTileThemeData, FontWeight, IconThemeData, InputDecorationTheme, NavigationBarThemeData, OutlineInputBorder, OutlinedButtonThemeData, ProgressIndicatorThemeData, RadioThemeData, RoundedRectangleBorder, Size, TextButtonThemeData, TextStyle, TextTheme, ThemeData, WidgetState, WidgetStateProperty, WidgetStatePropertyAll, EdgeInsets, Border;
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'typography.dart';

base class DarkTheme extends Typography {
  DarkTheme._() : super(isDarkMode: true);
  static DarkTheme get instance => DarkTheme._();

  ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: Typography.fontFamily,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        secondary: AppColors.greenAccent,
        onSecondary: AppColors.white,
        error: AppColors.error,
        onError: AppColors.white,
        surface: AppColors.slate900,
        onSurface: AppColors.slate100,
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      cardColor: AppColors.slate800,
      textTheme: TextTheme(
        displayLarge: super.displayLarge,
        displayMedium: super.displayMedium,
        displaySmall: super.displaySmall,
        bodyLarge: super.bodyLarge,
        bodyMedium: super.bodyMedium,
        bodySmall: super.bodySmall,
        labelLarge: super.labelLarge,
        labelMedium: super.labelMedium,
        labelSmall: super.labelSmall,
        titleLarge: super.titleLarge,
        titleMedium: super.titleMedium,
        titleSmall: super.titleSmall,
      ),

      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((state) {
          if (state.contains(WidgetState.selected)) {
            return super.labelSmall.copyWith(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            );
          }
          return super.labelSmall.copyWith(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.slate400,
          );
        }),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.backgroundDark,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        iconTheme: IconThemeData(color: AppColors.slate100),
        backgroundColor: AppColors.backgroundDark,
        titleTextStyle: TextStyle(
          fontFamily: Typography.fontFamily,
          color: AppColors.slate100,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
             EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        fillColor: AppColors.slate900,
        filled: true,
        isDense: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.slate800, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.slate800, width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.slate800, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.errorBorder, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              const BorderSide(color: AppColors.errorBorder, width: 1.5),
        ),
        labelStyle: bodySmall.copyWith(color: AppColors.slate400),
        errorStyle: labelMedium.copyWith(color: AppColors.errorBorder),
        hintStyle: bodyMedium.copyWith(color: AppColors.slate400),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          fixedSize: const WidgetStatePropertyAll(Size.fromHeight(56)),
          foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.white.withValues(alpha: .6);
            }
            return Colors.white;
          }),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.primary.withValues(alpha: .4);
            }
            return AppColors.primary;
          }),
          elevation: WidgetStatePropertyAll(4),
          shadowColor: WidgetStatePropertyAll(
            AppColors.primary.withValues(alpha: 0.3),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          textStyle: WidgetStatePropertyAll(
            titleSmall.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          fixedSize: const WidgetStatePropertyAll(Size.fromHeight(56)),
          foregroundColor: WidgetStatePropertyAll(AppColors.slate100),
          backgroundColor: WidgetStatePropertyAll(AppColors.slate900),
          side: WidgetStatePropertyAll(
            BorderSide(color: AppColors.slate800),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          textStyle: WidgetStatePropertyAll(
            titleSmall.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(AppColors.primary),
          iconColor: WidgetStatePropertyAll(AppColors.primary),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.slate800,
        shadowColor: AppColors.lightBlack,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: EdgeInsets.symmetric(horizontal: 0),
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.slate800,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: AppColors.slate700),
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: BorderSide(color: AppColors.slate600, width: 1),
        checkColor: WidgetStatePropertyAll(AppColors.white),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.slate800;
        }),
      ),

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.slate600;
        }),
        overlayColor: WidgetStateProperty.all(AppColors.primary),
        splashRadius: 18,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        tilePadding: EdgeInsets.zero,
        shape: Border(),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.slate800,
        thickness: 1,
      ),
    );
  }
}
