import 'package:flutter/material.dart'
    show
        AppBarTheme,
        BorderRadius,
        BorderSide,
        Brightness,
        ButtonStyle,
        CardThemeData,
        CheckboxThemeData,
        ColorScheme,
        Colors,
        DatePickerThemeData,
        DialogThemeData,
        DividerThemeData,
        ElevatedButtonThemeData,
        ExpansionTileThemeData,
        FontWeight,
        IconThemeData,
        InputDecorationTheme,
        MaterialTapTargetSize,
        NavigationBarThemeData,
        OutlineInputBorder,
        OutlinedButtonThemeData,
        ProgressIndicatorThemeData,
        RadioThemeData,
        RoundedRectangleBorder,
        Size,
        TextButtonThemeData,
        TextStyle,
        TextTheme,
        ThemeData,
        VisualDensity,
        WidgetState,
        WidgetStateProperty,
        WidgetStatePropertyAll;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'typography.dart';

base class LightTheme extends Typography {
  LightTheme._() : super(isDarkMode: false);

  static LightTheme get instance => LightTheme._();

  ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      primarySwatch: AppColors.primary,
      brightness: Brightness.light,
      cardColor: AppColors.white,
      fontFamily: Typography.fontFamily,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        secondary: AppColors.greenAccent,
        onSecondary: AppColors.white,
        error: AppColors.error,
        onError: AppColors.white,
        surface: AppColors.white,
        onSurface: AppColors.slate900,
      ),
      scaffoldBackgroundColor: AppColors.backgroundLight,
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
            color: Colors.black54,
          );
        }),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.backgroundLight,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        iconTheme: IconThemeData(color: AppColors.slate900),
        backgroundColor: AppColors.backgroundLight,
        titleTextStyle: TextStyle(
          fontFamily: Typography.fontFamily,
          color: AppColors.slate900,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        fillColor: AppColors.white,
        filled: true,
        isDense: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.slate200, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.slate200, width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.slate200, width: 1),
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
          foregroundColor: WidgetStatePropertyAll(AppColors.slate900),
          backgroundColor: WidgetStatePropertyAll(AppColors.white),
          side: WidgetStatePropertyAll(
            BorderSide(color: AppColors.slate200),
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
        backgroundColor: AppColors.white,
        shadowColor: AppColors.lightBlack,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: EdgeInsets.symmetric(horizontal: 0),
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: AppColors.slate200),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: AppColors.white,
        headerBackgroundColor: AppColors.primary,
        headerForegroundColor: Colors.white,
        yearStyle: labelLarge.copyWith(color: AppColors.textBlack),
        weekdayStyle: labelLarge.copyWith(color: AppColors.textBlack),
        dividerColor: Colors.transparent,
        dayStyle: labelMedium,
        subHeaderForegroundColor: AppColors.textBlack,
        yearForegroundColor: WidgetStatePropertyAll(AppColors.textBlack),
        dayForegroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.textBlack.withValues(alpha: 0.3);
          }
          return AppColors.textBlack;
        }),
        todayBackgroundColor: WidgetStatePropertyAll<Color>(
          AppColors.primary,
        ),
        toggleButtonTextStyle: bodyLarge,
        todayForegroundColor: WidgetStatePropertyAll<Color>(Colors.white),
        dayShape: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: AppColors.primary, width: 1),
            );
          }
          return null;
        }),
        rangeSelectionBackgroundColor: AppColors.primary,
      ),

      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: BorderSide(color: AppColors.slate300, width: 1),
        visualDensity: VisualDensity.compact,
        checkColor: WidgetStateProperty.resolveWith((states) {
          return AppColors.white;
        }),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.white;
        }),
      ),

      radioTheme: RadioThemeData(
        visualDensity: VisualDensity.compact,
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.slate300;
        }),
        overlayColor: WidgetStateProperty.all(AppColors.primary),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashRadius: 18,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        tilePadding: EdgeInsets.zero,
        shape: Border(),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.slate200,
        thickness: 1,
      ),
    );
  }
}
