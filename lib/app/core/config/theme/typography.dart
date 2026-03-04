import 'package:flutter/material.dart'
    show FontStyle, FontWeight, TextLeadingDistribution, TextStyle;
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart' show AppColors;

base class Typography {
  final bool isDarkMode;
  Typography({required this.isDarkMode});

  static String? _fontFamily;
  static String get fontFamily =>
      _fontFamily ??= GoogleFonts.lexend().fontFamily!;

  TextStyle get displayLarge => TextStyle(
    fontFamily: fontFamily,
    color: isDarkMode ? AppColors.white : AppColors.slate900,
    fontWeight: FontWeight.w700,
    fontSize: 36,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
  );
  TextStyle get displayMedium => TextStyle(
    fontFamily: fontFamily,
    color: isDarkMode ? AppColors.white : AppColors.slate900,
    fontWeight: FontWeight.w400,
    fontSize: 32,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
  );
  TextStyle get displaySmall => TextStyle(
    fontFamily: fontFamily,
    color: isDarkMode ? AppColors.white : AppColors.slate900,
    fontWeight: FontWeight.normal,
    fontSize: 28,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
  );
  TextStyle get titleLarge => TextStyle(
    fontFamily: fontFamily,
    color: isDarkMode ? AppColors.white : AppColors.slate900,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
  );
  TextStyle get titleMedium => TextStyle(
    fontFamily: fontFamily,
    color: isDarkMode ? AppColors.white : AppColors.slate900,
    fontWeight: FontWeight.w400,
    fontSize: 22,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
  );
  TextStyle get titleSmall => TextStyle(
    fontFamily: fontFamily,
    color: isDarkMode ? AppColors.white : AppColors.slate900,
    fontWeight: FontWeight.normal,
    fontSize: 20,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
  );
  TextStyle get bodyLarge => TextStyle(
    fontFamily: fontFamily,
    color: isDarkMode ? AppColors.white : AppColors.slate900,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
  );
  TextStyle get bodyMedium => TextStyle(
    fontFamily: fontFamily,
    color: isDarkMode ? AppColors.white : AppColors.slate900,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
  );
  TextStyle get bodySmall => TextStyle(
    fontFamily: fontFamily,
    color: isDarkMode ? AppColors.white : AppColors.slate900,
    fontWeight: FontWeight.normal,
    fontSize: 14,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
  );
  TextStyle get labelLarge => TextStyle(
    fontFamily: fontFamily,
    color: isDarkMode ? AppColors.white : AppColors.slate900,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
  );
  TextStyle get labelMedium => TextStyle(
    fontFamily: fontFamily,
    color: isDarkMode ? AppColors.white : AppColors.slate900,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
  );
  TextStyle get labelSmall => TextStyle(
    fontFamily: fontFamily,
    color: isDarkMode ? AppColors.white : AppColors.slate900,
    fontWeight: FontWeight.normal,
    fontSize: 10,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
  );
}
