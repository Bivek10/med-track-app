import 'package:flutter/material.dart';

class AppColors {
  // ──────────────────────────────────────────────
  // Primary brand color (#13A4EC)
  // ──────────────────────────────────────────────
  static const MaterialColor primary = MaterialColor(0xFF13A4EC, <int, Color>{
    50: Color(0xFFE8F5FD),
    100: Color(0xFFC5E6FA),
    200: Color(0xFF9ED5F6),
    300: Color(0xFF77C4F2),
    400: Color(0xFF59B7EF),
    500: Color(0xFF13A4EC),
    600: Color(0xFF1193D4),
    700: Color(0xFF0E7FBA),
    800: Color(0xFF0B6CA0),
    900: Color(0xFF074D74),
  });

  // ──────────────────────────────────────────────
  // Backgrounds
  // ──────────────────────────────────────────────
  static const Color backgroundLight = Color(0xFFF6F7F8);
  static const Color backgroundDark = Color(0xFF101C22);

  // ──────────────────────────────────────────────
  // Slate palette (Tailwind-inspired)
  // ──────────────────────────────────────────────
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);

  // ──────────────────────────────────────────────
  // Neutrals
  // ──────────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // ──────────────────────────────────────────────
  // Semantic
  // ──────────────────────────────────────────────
  static const Color error = Color(0xFFDA2626);
  static const Color errorBorder = Color(0xFFEB3939);
  static const Color success = Color(0xFF00BF8C);
  static const Color warning = Color(0xFFFBBC05);

  // ──────────────────────────────────────────────
  // Legacy colours (kept for backward-compat)
  // ──────────────────────────────────────────────
  static const Color greyLightDark = Color(0xFF8E8E8E);
  static const Color greyDark = Color(0xFF525252);
  static const Color greyMedium = Color(0xFF727272);
  static const Color greyLight = Color(0xFFD3D3D3);
  static const Color greyLighter = Color(0xFFADADAD);
  static const Color greyBrown = Color(0xFF605555);

  static const Color whiteSoft = Color(0xFFF4F9FF);

  static const Color greenPrimary = Color(0xFF00BF8C);
  static const Color greenAccent = Color(0xFF76C60F);
  static const Color greenLightBackground = Color(0xFFD7F4E3);

  static const Color redBright = Color(0xFFFF000A);
  static const Color redPure = Color(0xFFFF0000);
  static const Color redDark = Color(0xFFF03837);

  static const Color lightBlack = Color(0x80000000);
  static const Color shadowColor = Color(0x29001D2F);
  static const Color breadcrumbColor = Color(0xFFBDE3FA);

  static const Color borderColor = Color(0xFFD2D1D1);
  static const Color textBlack = Color(0xFF222222);
  static const lightSkyBlue = Color(0xFFC7ECFD);
  static const eerieBlack = Color(0xFF171616);
  static const Color ghostWhite = Color(0xFFF5F6FA);
  static const Color lightGrey = Color(0xFFB5B5B5);

  static const Color dividerColor50 = Color(0xFF66CCF8);
  static const Color brightBlue = Color(0xFF15B8FF);
  static const Color darkBlue = Color(0xFF388EF0);
  static const Color blue = Color(0xFF28429D);

  static const Color lightCoral = Color(0xFFE86262);
  static const Color darkGray = Color(0xFF3E3E3E);

  static const Color lightGrey400 = Color(0xFF8E8E8E);
  static const Color lightGrey100 = Color(0xFFF5F6FA);
  static const Color lightGrey150 = Color(0xFFEFF2F3);
  static const Color softGrey = Color(0xFFF1FAFE);

  static const Color brightGreen = Color(0xFF76C60F);
  static const Color lightGreen = Color(0xFF00C60A);
  static const Color softGreen = Color(0xFFDCFFF0);
  static const Color paleGreen = Color(0xFFF2FFE2);

  static const Color skyBlueLight = Color(0xFFA5E4FF);
  static const Color mistBlue = Color(0xFFF4F9FF);
  static const Color lightMint = Color(0xFFEAFFF9);

  static const Color cotColor = Color(0xFF7E84A3);
  static const Color softBlue = Color(0xFFE6EFFF);
  static const Color mintGreen = Color(0xFFD7F4E3);
  static const Color softYellow = Color(0xFFFFF0C9);

  static const Color pinkLight = Color(0xFFEA648C);
  static const Color timerBG = Color(0xFFDBE8F7);
  static const Color border = Color(0xFFD9D9D9);
  static const Color dimWhite = Color(0xFFFAFAFA);

  static const Color customColor = Color(0x1A00BF8C);
  static const Color customDimColor = Color(0xFFDFE5EF);
  static const Color customGreenColor = Color(0xFF00BF8C);
  static const Color customQRbg = Color(0xFF9E9E9E);

  static const Color pink = Color(0xFFEA648C);
  static const Color softPink = Color(0xFFFFF3F6);
  static const Color red = Color(0xFFD84242);

  static const Color aTagColor = Color(0xFF2563eb);
  static const Color preColor = Color(0xFF0f172a);
  static const Color quoteBorderColor = Color(0xFFCCCCCC);

  static const List<Color> notificationColor = [
    Color(0xFFD5FFF4),
    Color(0xFFFFE7EE),
    Color(0xFFFFE9F8),
    Color(0xFFDDFFE7),
    Color(0xFFF6FFD5),
    Color(0xFFD2F1FF),
  ];
  static const Color lightSuccessGreen = Color(0xFFE6F5EB);

  static const Color pdfAttachmentBgColor = Color(0xFFF0F1F3);
  static const Color dividerColor2 = Color(0xFFA3D5EC);
  static const Color lightRed = Color(0xFFFFDFE7);
  static const Color redBalloonColor = Color(0xFFF56276);
  static const Color greenBalloonColor = Color(0xFF07C384);
  static const Color navItemBgColor = Color(0xFFf2f9fe);
  static const Color notificationBadgeColor = Color(0xFFEA648C);
  static const Color notificationDividerColor = Color(0xFFD7E3E8);
}
