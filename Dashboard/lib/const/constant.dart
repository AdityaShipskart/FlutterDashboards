import 'package:flutter/material.dart';

/// Animation Durations, Border Radius, Elevation, Icon Sizes, Button Sizes
class AppConstants {
  // Prevent instantiation
  AppConstants._();

  /// App Information
  static const String appName = 'Your App Name';
  static const String appVersion = '1.0.0';

  /// Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);

  /// Border Radius
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double radiusXLarge = 16.0;
  static const double radiusXXLarge = 24.0;
  static const double radiusCircular = 50.0;

  /// Elevation
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  static const double elevationVeryHigh = 16.0;

  /// Icon Sizes
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeXLarge = 48.0;

  /// Button Sizes
  static const double buttonHeightSmall = 32.0;
  static const double buttonHeightMedium = 48.0;
  static const double buttonHeightLarge = 56.0;
  static const double buttonMinWidth = 64.0;
}

/// Spacing and Padding Constants
class AppSpacing {
  AppSpacing._();

  /// Spacing Values
  static const double xxxs = 0.6;
  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double sd = 6.0;
  static const double sm = 8.0;
  static const double ml = 12.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  /// Common EdgeInsets
  static const EdgeInsets paddingXS = EdgeInsets.all(xs);
  static const EdgeInsets paddingSM = EdgeInsets.all(sm);
  static const EdgeInsets paddingMD = EdgeInsets.all(md);
  static const EdgeInsets paddingLG = EdgeInsets.all(lg);
  static const EdgeInsets paddingXL = EdgeInsets.all(xl);

  /// Horizontal Padding
  static const EdgeInsets paddingHorizontalXS = EdgeInsets.symmetric(
    horizontal: xs,
  );
  static const EdgeInsets paddingHorizontalSM = EdgeInsets.symmetric(
    horizontal: sm,
  );
  static const EdgeInsets paddingHorizontalMD = EdgeInsets.symmetric(
    horizontal: md,
  );
  static const EdgeInsets paddingHorizontalLG = EdgeInsets.symmetric(
    horizontal: lg,
  );
  static const EdgeInsets paddingHorizontalXL = EdgeInsets.symmetric(
    horizontal: xl,
  );

  /// Vertical Padding
  static const EdgeInsets paddingVerticalXS = EdgeInsets.symmetric(
    vertical: xs,
  );
  static const EdgeInsets paddingVerticalSM = EdgeInsets.symmetric(
    vertical: sm,
  );
  static const EdgeInsets paddingVerticalMD = EdgeInsets.symmetric(
    vertical: md,
  );
  static const EdgeInsets paddingVerticalLG = EdgeInsets.symmetric(
    vertical: lg,
  );
  static const EdgeInsets paddingVerticalXL = EdgeInsets.symmetric(
    vertical: xl,
  );

  /// Page Padding
  static const EdgeInsets pagePadding = EdgeInsets.all(md);
  static const EdgeInsets pagePaddingHorizontal = EdgeInsets.symmetric(
    horizontal: md,
  );
  static const EdgeInsets pagePaddingVertical = EdgeInsets.symmetric(
    vertical: md,
  );
}

/// Main Color Palette
class AppColors {
  AppColors._();

  /// Primary Colors - Light Theme
  static const Color primaryLight = Color(0xFF1379F0);
  static const Color primaryActiveLight = Color(0xFF086DE3);
  static const Color primaryAccentLight = Color(0xFF0D4B94);
  static const Color primarySoftLight = Color(0xFFE7F2FF);

  /// Primary Colors - Dark Theme
  static const Color primaryDark = Color(0xFF1379F0);
  static const Color primaryActiveDark = Color(0xFF2D8EFF);
  static const Color primaryAccentDark = Color(0xFF81A3CB);
  static const Color primarySoftDark = Color(0xFF0A1726);

  /// Primary Color (Default - can be used for both themes)
  static const Color primary = Color(0xFF1379F0);

  /// Secondary Color (Default - teal color for accent)
  static const Color secondary = Color(0xFF03DAC6);

  /// Secondary Colors - Gradient/Clarity
  static const Color secondaryClarityLight = Color(
    0x33F9F9F9,
  ); // F9F9F9 at 20% opacity
  static const Color secondaryClarityDark = Color(0x33363843);

  /// Grey Scale - Light Theme
  static const Color grey25Light = Color(
    0xFFF7FAFC,
  ); // Very light blue-grey for table headers
  static const Color grey50Light = Color(0xFFF9F9F9);
  static const Color grey100Light = Color(0xFFF4F4F4);
  static const Color grey200Light = Color(0xFFEEEEEE);
  static const Color grey300Light = Color(0xFFDCDDDE);
  static const Color grey400Light = Color(0xFFCBCED3);
  static const Color grey500Light = Color(0xFFBCBFC5);
  static const Color grey600Light = Color(0xFF8E9198);
  static const Color grey700Light = Color(0xFF676A72);
  static const Color grey800Light = Color(0xFF393B40);
  static const Color grey900Light = Color(0xFF2C2D30);
  static const Color grey950Light = Color(0xFF151516);

  /// Grey Scale - Dark Theme
  static const Color grey50Dark = Color(0xFF141419);
  static const Color grey100Dark = Color(0xFF141419);
  static const Color grey200Dark = Color(0xFF26272F);
  static const Color grey300Dark = Color(0xFF363843);
  static const Color grey400Dark = Color(0xFF464852);
  static const Color grey500Dark = Color(0xFF636674);
  static const Color grey600Dark = Color(0xFF808290);
  static const Color grey700Dark = Color(0xFF808290);
  static const Color grey800Dark = Color(0xFFB5B7C8);
  static const Color grey900Dark = Color(0xFFDBDCE4);
  static const Color grey950Dark = Color(0xFFF5F5F5);

  /// Light Theme Colors
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFFAFAFA);
  static const Color lightSurfaceVariant = Color(0xFFF5F5F5);
  static const Color lightBorder = Color(0xFFE0E0E0);
  static const Color lightDivider = Color(0xFFE0E0E0);

  /// Dark Theme Colors
  static const Color darkBackground = Color(0xFF000000);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color darkSurfaceVariant = Color(0xFF2C2D30);
  static const Color darkBorder = Color(0xFF363843);
  static const Color darkDivider = Color(0xFF363843);

  /// Text Colors - Light Theme
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textHintLight = Color(0xFFBDBDBD);
  static const Color textDisabledLight = Color(0xFF9E9E9E);

  /// Text Colors - Dark Theme
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB5B7C8);
  static const Color textHintDark = Color(0xFF808290);
  static const Color textDisabledDark = Color(0xFF636674);

  /// Status Colors - Success
  static const Color success = Color(
    0xFF10B981,
  ); // Green-500 - Same for both modes
  static const Color successActive = Color(0xFF059669); // Green-600 Light mode
  static const Color successActiveDark = Color(
    0xFF34D399,
  ); // Green-400 Dark mode
  static const Color successAccent = Color(0xFF047857); // Green-700 Light mode
  static const Color successAccentDark = Color(
    0xFF6EE7B7,
  ); // Green-300 Dark mode
  static const Color successTransparent = Color(
    0x3310B981,
  ); // 20% opacity, same for both
  static const Color successSoft = Color(
    0xFFD1FAE5,
  ); // Green-100 Light mode - Light green background
  static const Color successSoftDark = Color(0xFF064E3B); // Green-900 Dark mode

  /// Status Colors - Warning
  static const Color warning = Color(0xFFFEC524); // Same for both modes
  static const Color warningActive = Color(0xFFF3B70F); // Light mode
  static const Color warningActiveDark = Color(0xFFFFD96C); // Dark mode
  static const Color warningAccent = Color(0xFFB88800); // Light mode
  static const Color warningAccentDark = Color(0xFFAF9F70); // Dark mode
  static const Color warningTransparent = Color(
    0x33FEC524,
  ); // 20% opacity, same for both
  static const Color warningSoft = Color(0xFFFFFAE9); // Light mode
  static const Color warningSoftDark = Color(0xFF282004); // Dark mode

  /// Status Colors - Info
  static const Color info = Color(0xFF4921EA); // Light mode
  static const Color infoDark = Color(0xFF521AF2); // Dark mode
  static const Color infoActive = Color(0xFF3D17D4); // Light mode
  static const Color infoActiveDark = Color(0xFF6129FF); // Dark mode
  static const Color infoAccent = Color(0xFF271086); // Light mode
  static const Color infoAccentDark = Color(0xFF8A7ACC); // Dark mode
  static const Color infoTransparent = Color(0x334921EA); // Light - 20% opacity
  static const Color infoTransparentDark = Color(
    0x330724FF,
  ); // Dark - 20% opacity
  static const Color infoSoft = Color(0xFFF0ECFF); // Light mode
  static const Color infoSoftDark = Color(0xFF1A0E3D); // Dark mode

  /// Status Colors - Error/Danger
  static const Color error = Color(0xFFEF4444); // Red-500 - Same for both modes
  static const Color errorActive = Color(0xFFDC2626); // Red-600 Light mode
  static const Color errorActiveDark = Color(0xFFF87171); // Red-400 Dark mode
  static const Color errorAccent = Color(0xFFB91C1C); // Red-700 Light mode
  static const Color errorAccentDark = Color(0xFFFCA5A5); // Red-300 Dark mode
  static const Color errorTransparent = Color(
    0x33EF4444,
  ); // 20% opacity, same for both
  static const Color errorSoft = Color(
    0xFFFEE2E2,
  ); // Red-100 Light mode - Light red/pink background
  static const Color errorSoftDark = Color(0xFF7F1D1D); // Red-900 Dark mode

  /// Brand Colors - Orange
  static const Color orange = Color(0xFFFF6F1E); // Light mode
  static const Color orangeDark = Color(0xFFD74E00); // Dark mode
  static const Color orangeClarity20 = Color(0x33FF6F1E); // Light - 20% opacity
  static const Color orangeClarity20Dark = Color(
    0x33D74E00,
  ); // Dark - 20% opacity
  static const Color orangeLight = Color(0xFFFFF5EF); // Light mode
  static const Color orangeLightDark = Color(0xFF272320); // Dark mode

  /// Utility Colors
  static const Color secondaryClarity20 = Color(
    0x33F9F9F9,
  ); // Light - 20% opacity
  static const Color secondaryClarity20Dark = Color(
    0x33363843,
  ); // Dark - 20% opacity
  static const Color lightClarity0 = Color(
    0x00FFFFFF,
  ); // Light - 0% opacity (transparent)
  static const Color lightClarity0Dark = Color(
    0x001F212A,
  ); // Dark - 0% opacity (transparent)

  /// Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);

  /// Basic Colors (for backward compatibility - default to light theme)
  static const Color background = lightBackground;
  static const Color surface = lightSurface;
  static const Color surfaceVariant = lightSurfaceVariant;
  static const Color card = cardLight;
  static const Color border = lightBorder;
  static const Color divider = lightDivider;
  static const Color scaffoldBackground = lightSurface;

  /// Text Colors (default to light theme)
  static const Color textPrimary = textPrimaryLight;
  static const Color textSecondary = textSecondaryLight;
  static const Color textHint = textHintLight;
  static const Color textDisabled = textDisabledLight;
  static const Color textOnPrimary = white;
  static const Color textOnSecondary = black;

  /// App Bar (default to light theme)
  static const Color appBarBackground = appBarBackgroundLight;
  static const Color appBarForeground = appBarForegroundLight;

  /// Bottom Navigation (default to light theme)
  static const Color bottomNavBackground = bottomNavBackgroundLight;
  static const Color bottomNavSelected = bottomNavSelectedLight;
  static const Color bottomNavUnselected = bottomNavUnselectedLight;

  /// Input Field (default to light theme)
  static const Color inputFill = inputFillLight;
  static const Color inputBorder = inputBorderLight;
  static const Color inputFocusedBorder = inputFocusedBorderLight;
  static const Color inputErrorBorder = inputErrorBorderLight;

  /// Shadow Colors
  static const Color shadowLight = Color(0x0F000000);
  static const Color shadow = Color(0x1F000000);
  static const Color shadowDark = Color(0x3F000000);

  /// Overlay Colors
  static const Color overlayLight = Color(0x40000000);
  static const Color overlay = Color(0x80000000);
  static const Color overlayDark = Color(0xA0000000);

  /// App Bar - Light Theme
  static const Color appBarBackgroundLight = primary;
  static const Color appBarForegroundLight = white;

  /// App Bar - Dark Theme
  static const Color appBarBackgroundDark = Color(0xFF1A1A1A);
  static const Color appBarForegroundDark = white;

  /// Bottom Navigation - Light Theme
  static const Color bottomNavBackgroundLight = white;
  static const Color bottomNavSelectedLight = primary;
  static const Color bottomNavUnselectedLight = grey600Light;

  /// Bottom Navigation - Dark Theme
  static const Color bottomNavBackgroundDark = Color(0xFF1A1A1A);
  static const Color bottomNavSelectedDark = primary;
  static const Color bottomNavUnselectedDark = grey600Dark;

  /// Input Field - Light Theme
  static const Color inputFillLight = Color(0xFFF5F5F5);
  static const Color inputBorderLight = Color(0xFFE0E0E0);
  static const Color inputFocusedBorderLight = primary;
  static const Color inputErrorBorderLight = error;

  /// Input Field - Dark Theme
  static const Color inputFillDark = Color(0xFF26272F);
  static const Color inputBorderDark = Color(0xFF363843);
  static const Color inputFocusedBorderDark = primary;
  static const Color inputErrorBorderDark = error;

  /// Card Colors
  static const Color cardLight = white;
  static const Color cardDark = Color(0xFF1A1A1A);

  /// Helper method to get theme-appropriate colors
  static Color getGreyScale(int level, bool isDark) {
    if (isDark) {
      switch (level) {
        case 50:
          return grey50Dark;
        case 100:
          return grey100Dark;
        case 200:
          return grey200Dark;
        case 300:
          return grey300Dark;
        case 400:
          return grey400Dark;
        case 500:
          return grey500Dark;
        case 600:
          return grey600Dark;
        case 700:
          return grey700Dark;
        case 800:
          return grey800Dark;
        case 900:
          return grey900Dark;
        case 950:
          return grey950Dark;
        default:
          return grey500Dark;
      }
    } else {
      switch (level) {
        case 50:
          return grey50Light;
        case 100:
          return grey100Light;
        case 200:
          return grey200Light;
        case 300:
          return grey300Light;
        case 400:
          return grey400Light;
        case 500:
          return grey500Light;
        case 600:
          return grey600Light;
        case 700:
          return grey700Light;
        case 800:
          return grey800Light;
        case 900:
          return grey900Light;
        case 950:
          return grey950Light;
        default:
          return grey500Light;
      }
    }
  }

  /// Helper method to get background color based on theme
  static Color getBackground(bool isDark) {
    return isDark ? darkBackground : lightBackground;
  }

  /// Helper method to get surface color based on theme
  static Color getSurface(bool isDark) {
    return isDark ? darkSurface : lightSurface;
  }

  /// Helper method to get text primary color based on theme
  static Color getTextPrimary(bool isDark) {
    return isDark ? textPrimaryDark : textPrimaryLight;
  }

  /// Helper method to get text secondary color based on theme
  static Color getTextSecondary(bool isDark) {
    return isDark ? textSecondaryDark : textSecondaryLight;
  }

  /// Helper method to get text hint color based on theme
  static Color getTextHint(bool isDark) {
    return isDark ? textHintDark : textHintLight;
  }

  /// Helper method to get card color based on theme
  static Color getCard(bool isDark) {
    return isDark ? cardDark : cardLight;
  }

  /// Helper method to get border color based on theme
  static Color getBorder(bool isDark) {
    return isDark ? darkBorder : lightBorder;
  }

  /// Helper method to get app bar background based on theme
  static Color getAppBarBackground(bool isDark) {
    return isDark ? appBarBackgroundDark : appBarBackgroundLight;
  }

  /// Helper method to get app bar foreground based on theme
  static Color getAppBarForeground(bool isDark) {
    return isDark ? appBarForegroundDark : appBarForegroundLight;
  }

  /// Helper method to get input fill color based on theme
  static Color getInputFill(bool isDark) {
    return isDark ? inputFillDark : inputFillLight;
  }

  /// Helper method to get input border color based on theme
  static Color getInputBorder(bool isDark) {
    return isDark ? inputBorderDark : inputBorderLight;
  }
}

/// Typography Styles - Based on Figma Design System
class AppTextStyles {
  AppTextStyles._();

  /// Font Family
  static const String fontFamily = 'Inter';

  /// Font Weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // ==================== HEADINGS ====================

  /// H-50-54-700: Heading size 50, line height 54, bold
  static TextStyle h50({bool isDark = false}) => TextStyle(
    fontSize: 50,
    fontWeight: bold,
    fontFamily: fontFamily,
    height: 54 / 50,
    letterSpacing: -1.5,
    color: AppColors.getTextPrimary(isDark),
  );

  /// H-44-56-700: Heading size 44, line height 56, bold
  static TextStyle h44({bool isDark = false}) => TextStyle(
    fontSize: 44,
    fontWeight: bold,
    fontFamily: fontFamily,
    height: 56 / 44,
    letterSpacing: -1.0,
    color: AppColors.getTextPrimary(isDark),
  );

  /// H-38-38-600: Heading size 38, line height 38, semibold
  static TextStyle h38({bool isDark = false}) => TextStyle(
    fontSize: 38,
    fontWeight: semiBold,
    fontFamily: fontFamily,
    height: 38 / 38,
    letterSpacing: -0.75,
    color: AppColors.getTextPrimary(isDark),
  );

  /// H-34-42-700: Heading size 34, line height 42, bold
  static TextStyle h34Bold({bool isDark = false}) => TextStyle(
    fontSize: 34,
    fontWeight: bold,
    fontFamily: fontFamily,
    height: 42 / 34,
    letterSpacing: -0.5,
    color: AppColors.getTextPrimary(isDark),
  );

  /// H-34-34-600: Heading size 34, line height 34, semibold
  static TextStyle h34({bool isDark = false}) => TextStyle(
    fontSize: 34,
    fontWeight: semiBold,
    fontFamily: fontFamily,
    height: 34 / 34,
    letterSpacing: -0.5,
    color: AppColors.getTextPrimary(isDark),
  );

  /// H-30-30-600: Heading size 30, line height 30, semibold
  static TextStyle h30({bool isDark = false}) => TextStyle(
    fontSize: 30,
    fontWeight: semiBold,
    fontFamily: fontFamily,
    height: 30 / 30,
    letterSpacing: -0.5,
    color: AppColors.getTextPrimary(isDark),
  );

  /// H-26-26-600: Heading size 26, line height 26, semibold
  static TextStyle h26({bool isDark = false}) => TextStyle(
    fontSize: 26,
    fontWeight: semiBold,
    fontFamily: fontFamily,
    height: 26 / 26,
    letterSpacing: -0.25,
    color: AppColors.getTextPrimary(isDark),
  );

  /// H-24-24-600: Heading size 24, line height 24, semibold
  static TextStyle h24({bool isDark = false}) => TextStyle(
    fontSize: 24,
    fontWeight: semiBold,
    fontFamily: fontFamily,
    height: 24 / 24,
    letterSpacing: -0.25,
    color: AppColors.getTextPrimary(isDark),
  );

  /// H-22-38-500: Heading size 22, line height 38, medium
  static TextStyle h22({bool isDark = false}) => TextStyle(
    fontSize: 22,
    fontWeight: medium,
    fontFamily: fontFamily,
    height: 38 / 22,
    letterSpacing: 0,
    color: AppColors.getTextPrimary(isDark),
  );

  /// H-22-22-600: Heading size 22, line height 22, semibold
  static TextStyle h22Compact({bool isDark = false}) => TextStyle(
    fontSize: 22,
    fontWeight: semiBold,
    fontFamily: fontFamily,
    height: 22 / 22,
    letterSpacing: 0,
    color: AppColors.getTextPrimary(isDark),
  );

  // ==================== BODY TEXT ====================

  /// B-20-30-500: Body size 20, line height 30, medium
  static TextStyle b20Medium({bool isDark = false}) => TextStyle(
    fontSize: 20,
    fontWeight: medium,
    fontFamily: fontFamily,
    height: 30 / 20,
    letterSpacing: 0.15,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-20-20-500: Body size 20, line height 20, medium
  static TextStyle b20({bool isDark = false}) => TextStyle(
    fontSize: 20,
    fontWeight: medium,
    fontFamily: fontFamily,
    height: 20 / 20,
    letterSpacing: 0.15,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-20-20-600: Body size 20, line height 20, semibold
  static TextStyle b20SemiBold({bool isDark = false}) => TextStyle(
    fontSize: 20,
    fontWeight: semiBold,
    fontFamily: fontFamily,
    height: 20 / 20,
    letterSpacing: 0.15,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-18-30-500: Body size 18, line height 30, medium
  static TextStyle b18Medium({bool isDark = false}) => TextStyle(
    fontSize: 18,
    fontWeight: medium,
    fontFamily: fontFamily,
    height: 30 / 18,
    letterSpacing: 0.15,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-18-25-300: Body size 18, line height 25, light
  static TextStyle b18Light({bool isDark = false}) => TextStyle(
    fontSize: 18,
    fontWeight: light,
    fontFamily: fontFamily,
    height: 25 / 18,
    letterSpacing: 0.15,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-18-25-500: Body size 18, line height 25, medium
  static TextStyle b18({bool isDark = false}) => TextStyle(
    fontSize: 18,
    fontWeight: medium,
    fontFamily: fontFamily,
    height: 25 / 18,
    letterSpacing: 0.15,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-18-25-600: Body size 18, line height 25, semibold
  static TextStyle b18SemiBold({bool isDark = false}) => TextStyle(
    fontSize: 18,
    fontWeight: semiBold,
    fontFamily: fontFamily,
    height: 25 / 18,
    letterSpacing: 0.15,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-18-18-500: Body size 18, line height 18, medium
  static TextStyle b18Compact({bool isDark = false}) => TextStyle(
    fontSize: 18,
    fontWeight: medium,
    fontFamily: fontFamily,
    height: 18 / 18,
    letterSpacing: 0.15,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-18-18-600: Body size 18, line height 18, semibold
  static TextStyle b18CompactSemiBold({bool isDark = false}) => TextStyle(
    fontSize: 18,
    fontWeight: semiBold,
    fontFamily: fontFamily,
    height: 18 / 18,
    letterSpacing: 0.15,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-16-25-500: Body size 16, line height 25, medium
  static TextStyle b16Medium({bool isDark = false}) => TextStyle(
    fontSize: 16,
    fontWeight: medium,
    fontFamily: fontFamily,
    height: 25 / 16,
    letterSpacing: 0.15,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-16-25-600: Body size 16, line height 25, semibold
  static TextStyle b16SemiBold({bool isDark = false}) => TextStyle(
    fontSize: 16,
    fontWeight: semiBold,
    fontFamily: fontFamily,
    height: 25 / 16,
    letterSpacing: 0.15,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-16-16-400: Body size 16, line height 16, regular
  static TextStyle b16({bool isDark = false}) => TextStyle(
    fontSize: 16,
    fontWeight: regular,
    fontFamily: fontFamily,
    height: 16 / 16,
    letterSpacing: 0.5,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-16-16-500: Body size 16, line height 16, medium
  static TextStyle b16Compact({bool isDark = false}) => TextStyle(
    fontSize: 16,
    fontWeight: medium,
    fontFamily: fontFamily,
    height: 16 / 16,
    letterSpacing: 0.5,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-16-16-600: Body size 16, line height 16, semibold
  static TextStyle b16CompactSemiBold({bool isDark = false}) => TextStyle(
    fontSize: 16,
    fontWeight: semiBold,
    fontFamily: fontFamily,
    height: 16 / 16,
    letterSpacing: 0.5,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-15-24-400: Body size 15, line height 24, regular
  static TextStyle b15({bool isDark = false}) => TextStyle(
    fontSize: 15,
    fontWeight: regular,
    fontFamily: fontFamily,
    height: 24 / 15,
    letterSpacing: 0.15,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-15-24-500: Body size 15, line height 24, medium
  static TextStyle b15Medium({bool isDark = false}) => TextStyle(
    fontSize: 15,
    fontWeight: medium,
    fontFamily: fontFamily,
    height: 24 / 15,
    letterSpacing: 0.15,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-15-16-400: Body size 15, line height 16, regular
  static TextStyle b15Compact({bool isDark = false}) => TextStyle(
    fontSize: 15,
    fontWeight: regular,
    fontFamily: fontFamily,
    height: 16 / 15,
    letterSpacing: 0.25,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-15-16-500: Body size 15, line height 16, medium
  static TextStyle b15CompactMedium({bool isDark = false}) => TextStyle(
    fontSize: 15,
    fontWeight: medium,
    fontFamily: fontFamily,
    height: 16 / 15,
    letterSpacing: 0.25,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-15-16-600: Body size 15, line height 16, semibold
  static TextStyle b15CompactSemiBold({bool isDark = false}) => TextStyle(
    fontSize: 15,
    fontWeight: semiBold,
    fontFamily: fontFamily,
    height: 16 / 15,
    letterSpacing: 0.25,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-14-22-400: Body size 14, line height 22, regular
  static TextStyle b14({bool isDark = false}) => TextStyle(
    fontSize: 14,
    fontWeight: regular,
    fontFamily: fontFamily,
    height: 22 / 14,
    letterSpacing: 0.25,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-14-22-500: Body size 14, line height 22, medium
  static TextStyle b14Medium({bool isDark = false}) => TextStyle(
    fontSize: 14,
    fontWeight: medium,
    fontFamily: fontFamily,
    height: 22 / 14,
    letterSpacing: 0.25,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-14-14-400: Body size 14, line height 14, regular
  static TextStyle b14Compact({bool isDark = false}) => TextStyle(
    fontSize: 14,
    fontWeight: regular,
    fontFamily: fontFamily,
    height: 14 / 14,
    letterSpacing: 0.25,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-14-14-500: Body size 14, line height 14, medium
  static TextStyle b14CompactMedium({bool isDark = false}) => TextStyle(
    fontSize: 14,
    fontWeight: medium,
    fontFamily: fontFamily,
    height: 14 / 14,
    letterSpacing: 0.25,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-14-14-600: Body size 14, line height 14, semibold
  static TextStyle b14CompactSemiBold({bool isDark = false}) => TextStyle(
    fontSize: 14,
    fontWeight: semiBold,
    fontFamily: fontFamily,
    height: 14 / 14,
    letterSpacing: 0.25,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-14-14-700: Body size 14, line height 14, bold
  static TextStyle b14CompactBold({bool isDark = false}) => TextStyle(
    fontSize: 14,
    fontWeight: bold,
    fontFamily: fontFamily,
    height: 14 / 14,
    letterSpacing: 0.25,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-13-20-400: Body size 13, line height 20, regular
  static TextStyle b13({bool isDark = false}) => TextStyle(
    fontSize: 13,
    fontWeight: regular,
    fontFamily: fontFamily,
    height: 20 / 13,
    letterSpacing: 0.25,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-13-20-500: Body size 13, line height 20, medium
  static TextStyle b13Medium({bool isDark = false}) => TextStyle(
    fontSize: 13,
    fontWeight: medium,
    fontFamily: fontFamily,
    height: 20 / 13,
    letterSpacing: 0.25,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-13-14-400: Body size 13, line height 14, regular
  static TextStyle b13Compact({bool isDark = false}) => TextStyle(
    fontSize: 13,
    fontWeight: regular,
    fontFamily: fontFamily,
    height: 14 / 13,
    letterSpacing: 0.4,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-13-14-500: Body size 13, line height 14, medium
  static TextStyle b13CompactMedium({bool isDark = false}) => TextStyle(
    fontSize: 13,
    fontWeight: medium,
    fontFamily: fontFamily,
    height: 14 / 13,
    letterSpacing: 0.4,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-13-14-600: Body size 13, line height 14, semibold
  static TextStyle b13CompactSemiBold({bool isDark = false}) => TextStyle(
    fontSize: 13,
    fontWeight: semiBold,
    fontFamily: fontFamily,
    height: 14 / 13,
    letterSpacing: 0.4,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-13-14-700: Body size 13, line height 14, bold
  static TextStyle b13CompactBold({bool isDark = false}) => TextStyle(
    fontSize: 13,
    fontWeight: bold,
    fontFamily: fontFamily,
    height: 14 / 13,
    letterSpacing: 0.4,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-12-19-400: Body size 12, line height 19, regular
  static TextStyle b12({bool isDark = false}) => TextStyle(
    fontSize: 12,
    fontWeight: regular,
    fontFamily: fontFamily,
    height: 19 / 12,
    letterSpacing: 0.4,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-12-12-400: Body size 12, line height 12, regular
  static TextStyle b12Compact({bool isDark = false}) => TextStyle(
    fontSize: 12,
    fontWeight: regular,
    fontFamily: fontFamily,
    height: 12 / 12,
    letterSpacing: 0.4,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-12-12-500: Body size 12, line height 12, medium
  static TextStyle b12CompactMedium({bool isDark = false}) => TextStyle(
    fontSize: 12,
    fontWeight: medium,
    fontFamily: fontFamily,
    height: 12 / 12,
    letterSpacing: 0.4,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-12-12-600: Body size 12, line height 12, semibold
  static TextStyle b12CompactSemiBold({bool isDark = false}) => TextStyle(
    fontSize: 12,
    fontWeight: semiBold,
    fontFamily: fontFamily,
    height: 12 / 12,
    letterSpacing: 0.4,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-12-12-700: Body size 12, line height 12, bold
  static TextStyle b12CompactBold({bool isDark = false}) => TextStyle(
    fontSize: 12,
    fontWeight: bold,
    fontFamily: fontFamily,
    height: 12 / 12,
    letterSpacing: 0.4,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-11-12-400: Body size 11, line height 12, regular
  static TextStyle b11({bool isDark = false}) => TextStyle(
    fontSize: 11,
    fontWeight: regular,
    fontFamily: fontFamily,
    height: 12 / 11,
    letterSpacing: 0.5,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-11-12-500: Body size 11, line height 12, medium
  static TextStyle b11Medium({bool isDark = false}) => TextStyle(
    fontSize: 11,
    fontWeight: medium,
    fontFamily: fontFamily,
    height: 12 / 11,
    letterSpacing: 0.5,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-11-12-600: Body size 11, line height 12, medium (note: Figma shows Medium 500 but this maintains semibold)
  static TextStyle b11SemiBold({bool isDark = false}) => TextStyle(
    fontSize: 11,
    fontWeight: medium,
    fontFamily: fontFamily,
    height: 12 / 11,
    letterSpacing: 0.5,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-10-10-400: Body size 10, line height 10, regular
  static TextStyle b10({bool isDark = false}) => TextStyle(
    fontSize: 10,
    fontWeight: regular,
    fontFamily: fontFamily,
    height: 10 / 10,
    letterSpacing: 0.5,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-10-10-500: Body size 10, line height 10, medium
  static TextStyle b10Medium({bool isDark = false}) => TextStyle(
    fontSize: 10,
    fontWeight: medium,
    fontFamily: fontFamily,
    height: 10 / 10,
    letterSpacing: 0.5,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-10-10-600: Body size 10, line height 10, semibold
  static TextStyle b10SemiBold({bool isDark = false}) => TextStyle(
    fontSize: 10,
    fontWeight: semiBold,
    fontFamily: fontFamily,
    height: 10 / 10,
    letterSpacing: 0.5,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-9-10-400: Body size 9, line height 10, regular
  static TextStyle b9({bool isDark = false}) => TextStyle(
    fontSize: 9,
    fontWeight: regular,
    fontFamily: fontFamily,
    height: 10 / 9,
    letterSpacing: 0.5,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-9-10-500: Body size 9, line height 10, medium
  static TextStyle b9Medium({bool isDark = false}) => TextStyle(
    fontSize: 9,
    fontWeight: medium,
    fontFamily: fontFamily,
    height: 10 / 9,
    letterSpacing: 0.5,
    color: AppColors.getTextPrimary(isDark),
  );

  /// B-9-10-600: Body size 9, line height 10, semibold
  static TextStyle b9SemiBold({bool isDark = false}) => TextStyle(
    fontSize: 9,
    fontWeight: semiBold,
    fontFamily: fontFamily,
    height: 10 / 9,
    letterSpacing: 0.5,
    color: AppColors.getTextPrimary(isDark),
  );

  // ==================== COMMON ALIASES ====================
  // These provide easy-to-remember names for frequently used styles

  /// Display text (largest heading)
  static TextStyle display({bool isDark = false}) => h50(isDark: isDark);

  /// Page title
  static TextStyle title({bool isDark = false}) => h34Bold(isDark: isDark);

  /// Section heading
  static TextStyle heading({bool isDark = false}) => h24(isDark: isDark);

  /// Subheading
  static TextStyle subheading({bool isDark = false}) => h22(isDark: isDark);

  /// Body text (default)
  static TextStyle body({bool isDark = false}) => b16(isDark: isDark);

  /// Body text medium weight
  static TextStyle bodyMedium({bool isDark = false}) =>
      b16Compact(isDark: isDark);

  /// Small body text
  static TextStyle bodySmall({bool isDark = false}) => b14(isDark: isDark);

  /// Caption text
  static TextStyle caption({bool isDark = false}) => b12(isDark: isDark);

  /// Button text
  static TextStyle button({bool isDark = false}) =>
      b16CompactSemiBold(isDark: isDark);

  /// Label text
  static TextStyle label({bool isDark = false}) =>
      b14CompactMedium(isDark: isDark);

  // ==================== STATUS TEXT STYLES ====================

  /// Error text style
  static TextStyle error({bool isDark = false}) =>
      b14(isDark: isDark).copyWith(color: AppColors.error);

  /// Success text style
  static TextStyle success({bool isDark = false}) =>
      b14(isDark: isDark).copyWith(color: AppColors.success);

  /// Warning text style
  static TextStyle warning({bool isDark = false}) =>
      b14(isDark: isDark).copyWith(color: AppColors.warning);

  /// Info text style
  static TextStyle info({bool isDark = false}) => b14(
    isDark: isDark,
  ).copyWith(color: isDark ? AppColors.infoDark : AppColors.info);
}

/// Common Widget Decorations
class AppDecorations {
  AppDecorations._();

  /// Theme-aware Card Decoration
  static BoxDecoration card({bool isDark = false}) => BoxDecoration(
    color: AppColors.getCard(isDark),
    borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
    border: Border.all(color: AppColors.getBorder(isDark), width: 0.5),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadow,
        offset: const Offset(0, 2),
        blurRadius: 4,
        spreadRadius: 0,
      ),
    ],
  );

  /// Theme-aware Elevated Card Decoration
  static BoxDecoration elevatedCard({bool isDark = false}) => BoxDecoration(
    color: AppColors.getCard(isDark),
    borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
    border: Border.all(color: AppColors.getBorder(isDark), width: 0.5),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadow,
        offset: const Offset(0, 4),
        blurRadius: 8,
        spreadRadius: 0,
      ),
    ],
  );

  /// Theme-aware Input Field Decoration
  static InputDecoration inputDecoration({
    String? hintText,
    String? labelText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool isError = false,
    bool isDark = false,
  }) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.getInputFill(isDark),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        borderSide: BorderSide(color: AppColors.getInputBorder(isDark)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        borderSide: BorderSide(color: AppColors.getInputBorder(isDark)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        borderSide: BorderSide(
          color: isError ? AppColors.error : AppColors.primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      contentPadding: AppSpacing.paddingMD,
      hintStyle: AppTextStyles.bodyMedium(
        isDark: isDark,
      ).copyWith(color: AppColors.getTextHint(isDark)),
      labelStyle: AppTextStyles.bodyMedium(
        isDark: isDark,
      ).copyWith(color: AppColors.getTextSecondary(isDark)),
      errorStyle: AppTextStyles.error(isDark: isDark),
    );
  }

  /// Theme-aware Button Styles
  static ButtonStyle primaryButtonStyle({bool isDark = false}) =>
      ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: AppConstants.elevationLow,
        padding: AppSpacing.paddingHorizontalLG,
        minimumSize: const Size(
          AppConstants.buttonMinWidth,
          AppConstants.buttonHeightMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        ),
        textStyle: AppTextStyles.button(isDark: isDark),
      );

  static ButtonStyle secondaryButtonStyle({bool isDark = false}) =>
      OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        padding: AppSpacing.paddingHorizontalLG,
        minimumSize: const Size(
          AppConstants.buttonMinWidth,
          AppConstants.buttonHeightMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        ),
        textStyle: AppTextStyles.button(
          isDark: isDark,
        ).copyWith(color: AppColors.primary),
      );

  static ButtonStyle textButtonStyle({bool isDark = false}) =>
      TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: AppSpacing.paddingHorizontalMD,
        minimumSize: const Size(
          AppConstants.buttonMinWidth,
          AppConstants.buttonHeightMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        ),
        textStyle: AppTextStyles.button(
          isDark: isDark,
        ).copyWith(color: AppColors.primary),
      );
}

/// Screen Breakpoints for Responsive Design
class AppBreakpoints {
  AppBreakpoints._();

  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
  static const double largeDesktop = 1600;
}

/// Common Asset Paths
class AppAssets {
  AppAssets._();

  /// Images
  static const String imagesPath = 'assets/images/';
  static const String logo = '${imagesPath}logo.png';
  static const String placeholder = '${imagesPath}placeholder.png';

  /// Icons
  static const String iconsPath = 'assets/icons/';

  /// Fonts
  static const String fontsPath = 'assets/fonts/';
}

/// Common Durations and Curves
class AppAnimations {
  AppAnimations._();

  /// Curves
  static const Curve easeIn = Curves.easeIn;
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve bounceIn = Curves.bounceIn;
  static const Curve bounceOut = Curves.bounceOut;
  static const Curve elasticIn = Curves.elasticIn;
  static const Curve elasticOut = Curves.elasticOut;

  /// Durations
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);
}

/// Aurora Theme - Centralized Card Design System
/// This class contains all the custom design patterns used across dashboard cards
/// to maintain consistency and make it easy to update the design globally
class AuroraTheme {
  AuroraTheme._();

  // ========== CARD CONTAINER STYLING ==========

  /// Standard card decoration with shadow and border radius
  static BoxDecoration cardDecoration(bool isDark) {
    return BoxDecoration(
      color: AppColors.getCard(isDark),
      borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
      boxShadow: [
        BoxShadow(
          color: AppColors.shadowLight,
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  /// Card decoration with custom shadow
  static BoxDecoration cardDecorationWithShadow({
    required bool isDark,
    Color? shadowColor,
    double? blurRadius,
    Offset? offset,
    double? borderRadius,
  }) {
    return BoxDecoration(
      color: AppColors.getCard(isDark),
      borderRadius: BorderRadius.circular(
        borderRadius ?? AppConstants.radiusLarge,
      ),
      boxShadow: [
        BoxShadow(
          color: shadowColor ?? AppColors.shadowLight,
          blurRadius: blurRadius ?? 10,
          offset: offset ?? const Offset(0, 2),
        ),
      ],
    );
  }

  // ========== CARD HEADER STYLING ==========

  /// Card title text style with letter spacing and font weight
  static TextStyle cardTitleStyle(bool isDark) {
    return AppTextStyles.h22Compact(
      isDark: isDark,
    ).copyWith(letterSpacing: 1.4, fontWeight: AppTextStyles.semiBold);
  }

  /// Card subtitle text style
  static TextStyle cardSubtitleStyle(bool isDark) {
    return AppTextStyles.b14(
      isDark: isDark,
    ).copyWith(color: AppColors.getTextSecondary(isDark));
  }

  /// Menu icon (three dots) for card header
  static Icon cardMenuIcon(bool isDark, {double size = 24}) {
    return Icon(
      Icons.more_horiz,
      color: AppColors.getTextSecondary(isDark),
      size: size,
    );
  }

  // ========== VALUE DISPLAY STYLING ==========

  /// Main value text style (large numbers like $63.02)
  static TextStyle mainValueStyle(bool isDark) {
    return AppTextStyles.h30(
      isDark: isDark,
    ).copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.5);
  }

  /// Percentage change container decoration
  static BoxDecoration percentageContainerDecoration({
    required bool isPositive,
    required bool isDark,
    double borderRadius = 4,
  }) {
    return BoxDecoration(
      color: isPositive
          ? (isDark ? AppColors.successSoftDark : AppColors.successSoft)
          : (isDark ? AppColors.errorSoftDark : AppColors.errorSoft),
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  /// Percentage change text style
  static TextStyle percentageTextStyle({
    required bool isPositive,
    required bool isDark,
  }) {
    return AppTextStyles.b12(isDark: isDark).copyWith(
      color: isPositive
          ? (isDark ? AppColors.successActiveDark : AppColors.success)
          : (isDark ? AppColors.errorActiveDark : AppColors.error),
      fontWeight: FontWeight.w500,
    );
  }

  /// Change label text style (e.g., "vs last month")
  static TextStyle changeLabelStyle(bool isDark) {
    return AppTextStyles.b12(isDark: isDark).copyWith(
      color: AppColors.getTextSecondary(isDark),
      fontWeight: FontWeight.w400,
    );
  }

  // ========== LEGEND/BADGE STYLING ==========

  /// Legend item container (colored square indicator)
  static Widget legendIndicator({
    required Color color,
    double size = 12,
    double borderRadius = 2,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }

  /// Legend item text style
  static TextStyle legendTextStyle(bool isDark) {
    return AppTextStyles.b14(
      isDark: isDark,
    ).copyWith(color: AppColors.getTextSecondary(isDark));
  }

  // ========== TOOLTIP STYLING ==========

  /// Standard tooltip container decoration
  static BoxDecoration tooltipDecoration({
    Color? backgroundColor,
    double borderRadius = 6,
    Color? shadowColor,
    double shadowBlur = 10,
    double shadowOffsetY = 3,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? const Color(0xFF2D3748),
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: shadowColor ?? Colors.black.withValues(alpha: 0.3),
          blurRadius: shadowBlur,
          offset: Offset(0, shadowOffsetY),
        ),
      ],
    );
  }

  /// Tooltip text style (primary text)
  static TextStyle tooltipTextStyle({
    Color? color,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return TextStyle(
      color: color ?? Colors.white,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  /// Tooltip secondary text style
  static TextStyle tooltipSecondaryTextStyle({
    Color? color,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      color: color ?? Colors.white70,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  /// Tooltip indicator (colored circle/square for legend)
  static Widget tooltipIndicator({
    required Color color,
    double size = 8,
    BoxShape shape = BoxShape.circle,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: shape),
    );
  }

  // ========== CHART BAR STYLING ==========

  /// Border radius for chart bars (vertical bars)
  static BorderRadius chartBarBorderRadius({
    double topRadius = 2,
    double bottomRadius = 0,
  }) {
    return BorderRadius.vertical(
      top: Radius.circular(topRadius),
      bottom: Radius.circular(bottomRadius),
    );
  }

  /// Border radius for horizontal bars
  static BorderRadius chartHorizontalBarBorderRadius({double radius = 4}) {
    return BorderRadius.horizontal(
      left: Radius.circular(radius),
      right: Radius.circular(radius),
    );
  }

  // ========== DROPDOWN/FILTER STYLING ==========

  /// Dropdown button decoration
  static BoxDecoration dropdownDecoration(bool isDark) {
    return BoxDecoration(
      color: AppColors.getGreyScale(100, isDark),
      borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
    );
  }

  /// Dropdown text style
  static TextStyle dropdownTextStyle(bool isDark) {
    return AppTextStyles.b14(
      isDark: isDark,
    ).copyWith(fontWeight: FontWeight.w500);
  }

  // ========== SPACING HELPERS ==========

  /// Standard spacing between card header and content
  static SizedBox cardHeaderSpacing() => SizedBox(height: AppSpacing.xl);

  /// Standard spacing between legend and chart
  static SizedBox legendChartSpacing() => SizedBox(height: AppSpacing.xl);

  /// Small vertical spacing
  static SizedBox smallVerticalSpacing() => SizedBox(height: AppSpacing.xs);

  /// Medium vertical spacing
  static SizedBox mediumVerticalSpacing() => SizedBox(height: AppSpacing.md);

  /// Standard horizontal spacing for legend items
  static SizedBox legendItemSpacing() => SizedBox(width: AppSpacing.md + 4);

  // ========== CHART CONFIGURATION ==========

  /// Standard chart padding
  static EdgeInsets chartPadding() => AppSpacing.paddingLG;

  /// Standard chart height for small cards
  static const double smallChartHeight = 150.0;

  /// Standard chart height for medium cards
  static const double mediumChartHeight = 250.0;

  /// Standard chart height for large cards
  static const double largeChartHeight = 280.0;

  // ========== RESPONSIVE HELPERS ==========

  /// Get responsive chart height based on card width
  static double getResponsiveChartHeight(double cardWidth) {
    if (cardWidth > 300) {
      return mediumChartHeight;
    }
    return 200.0;
  }

  // ========== ICON HELPERS ==========

  /// Standard icon size for card headers
  static const double cardHeaderIconSize = 24.0;

  /// Standard icon size for legend indicators
  static const double legendIconSize = 12.0;

  /// Standard icon size for tooltips
  static const double tooltipIconSize = 8.0;
}
