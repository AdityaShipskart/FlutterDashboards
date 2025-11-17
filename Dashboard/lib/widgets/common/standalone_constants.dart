/// Standalone constants for widgets - inline version of constant.dart
/// This allows widgets to be self-contained without external dependencies
library;

import 'package:flutter/material.dart';

/// Reusable constants mixin for standalone widgets
mixin StandaloneConstants {
  // Spacing
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;

  // Border Radius
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double radiusXLarge = 16.0;

  // Icon Sizes
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;

  // Colors - Light Mode
  static const Color primaryLight = Color(0xFF1379F0);
  static const Color grey25Light = Color(0xFFFCFCFD);
  static const Color grey100Light = Color(0xFFF4F4F4);
  static const Color grey200Light = Color(0xFFEEEEEE);
  static const Color grey300Light = Color(0xFFDCDDDE);
  static const Color grey600Light = Color(0xFF8E9198);
  static const Color grey700Light = Color(0xFF676A72);
  static const Color grey900Light = Color(0xFF2C2D30);
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color lightBorder = Color(0xFFE0E0E0);
  static const Color lightDivider = Color(0xFFE0E0E0);
  static const Color lightSurface = Color(0xFFFAFAFA);
  static const Color cardLight = Color(0xFFFFFFFF);

  // Colors - Dark Mode
  static const Color primaryDark = Color(0xFF1379F0);
  static const Color grey100Dark = Color(0xFF141419);
  static const Color grey200Dark = Color(0xFF26272F);
  static const Color grey300Dark = Color(0xFF363843);
  static const Color grey600Dark = Color(0xFF808290);
  static const Color grey800Dark = Color(0xFFB5B7C8);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB5B7C8);
  static const Color darkBorder = Color(0xFF363843);
  static const Color darkDivider = Color(0xFF363843);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color cardDark = Color(0xFF1A1A1A);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color successDark = Color(0xFF34D399);
  static const Color successSoft = Color(0xFFD1FAE5);
  static const Color successSoftDark = Color(0xFF064E3B);
  static const Color error = Color(0xFFEF4444);
  static const Color errorDark = Color(0xFFF87171);
  static const Color errorSoft = Color(0xFFFEE2E2);
  static const Color errorSoftDark = Color(0xFF7F1D1D);
  static const Color shadowLight = Color(0x0F000000);

  // Helper Methods
  static Color getCard(bool isDark) => isDark ? cardDark : cardLight;
  static Color getBorder(bool isDark) => isDark ? darkBorder : lightBorder;
  static Color getPrimary(bool isDark) => isDark ? primaryDark : primaryLight;
  static Color getTextPrimary(bool isDark) =>
      isDark ? textPrimaryDark : textPrimaryLight;
  static Color getTextSecondary(bool isDark) =>
      isDark ? textSecondaryDark : textSecondaryLight;

  // Responsive Breakpoints
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 850;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  // Card Decoration
  static BoxDecoration cardDecoration(bool isDark) {
    return BoxDecoration(
      color: getCard(isDark),
      borderRadius: BorderRadius.circular(radiusLarge),
      boxShadow: [
        BoxShadow(
          color: shadowLight,
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  // Text Styles
  static TextStyle cardTitleStyle(bool isDark) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: getTextPrimary(isDark),
      letterSpacing: 0.5,
    );
  }

  static TextStyle cardSubtitleStyle(bool isDark) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: getTextSecondary(isDark),
    );
  }

  // Common Widgets
  static Widget cardMenuIcon(bool isDark) {
    return Icon(
      Icons.more_horiz,
      color: getTextSecondary(isDark),
      size: iconSizeMedium,
    );
  }

  static EdgeInsets chartPadding() => const EdgeInsets.all(spacingLg);
  static SizedBox smallVerticalSpacing() => const SizedBox(height: spacingXs);
  static SizedBox cardHeaderSpacing() => const SizedBox(height: spacingLg);
  static SizedBox legendChartSpacing() => const SizedBox(height: spacingMd);
  static SizedBox legendItemSpacing() => const SizedBox(width: spacingLg);
}
