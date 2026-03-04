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
  LightTheme._():super(isDarkMode: false);

  static LightTheme get instance => LightTheme._();

  ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      primarySwatch: AppColors.primary,
      brightness: Brightness.light,
      cardColor: AppColors.white,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.white,
        onPrimary: AppColors.greyLighter,
        secondary: AppColors.greenAccent,
        onSecondary: AppColors.white,
        error: AppColors.redPure,
        onError: AppColors.redPure,
        surface: AppColors.white,

        onSurface: AppColors.greyLighter,
      ),
      scaffoldBackgroundColor: AppColors.primary.shade900,
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
        color: AppColors.white,
      ),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.white,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.only(top: 9, bottom: 9, right: 4),
        fillColor: AppColors.white,
        filled: true,
        isDense: true,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.greyLight, width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 1),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyLight, width: 1),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyLight, width: 1),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorBorder, width: 1),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorBorder, width: 1.5),
        ),
        labelStyle: bodySmall.copyWith(color: AppColors.greyLighter),
        errorStyle: labelMedium.copyWith(color: AppColors.errorBorder),
        hintStyle: bodySmall.copyWith(color: AppColors.greyLighter),
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
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
          ),
          textStyle: WidgetStatePropertyAll(titleSmall.copyWith(fontWeight: FontWeight.w500)),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          fixedSize: const WidgetStatePropertyAll(Size.fromHeight(56)),
          foregroundColor: WidgetStatePropertyAll(AppColors.primary),
          backgroundColor: WidgetStatePropertyAll(AppColors.primary.shade50),
          side: WidgetStatePropertyAll(BorderSide(color: AppColors.primary)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
          ),
          textStyle: WidgetStatePropertyAll(titleSmall.copyWith(fontWeight: FontWeight.w500)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(AppColors.primary),
          iconColor: WidgetStatePropertyAll(AppColors.primary),
        ),
      ),

      // dialog theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.white,
        shadowColor: AppColors.lightBlack,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        insetPadding: EdgeInsets.symmetric(horizontal: 0),
      ),

      //card theme
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: AppColors.primary.shade600),
          borderRadius: BorderRadius.circular(8),
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
          AppColors.primary.shade700,
        ),
        toggleButtonTextStyle: bodyLarge,
        todayForegroundColor: WidgetStatePropertyAll<Color>(Colors.white),
        dayShape: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: AppColors.primary.shade900, width: 1),
            );
          }
          return null;
        }),

        rangeSelectionBackgroundColor: AppColors.primary,
      ),

      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        side: BorderSide(color: AppColors.borderColor, width: 1),
        visualDensity: VisualDensity.compact,
        checkColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.white;
          }
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
          return AppColors.borderColor;
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
        color: AppColors.dividerColor50,
        thickness: 3,
      ),
    );
  }
}
