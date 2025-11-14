import 'package:flutter/material.dart';

/// Responsive breakpoints for adaptive layouts
class Responsive {
  /// Mobile: width < 850px
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  /// Tablet: 850px <= width < 1100px
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 850;

  /// Desktop: width >= 1100px
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  /// Get grid columns based on screen size
  static int getGridColumns(BuildContext context) {
    if (isMobile(context)) {
      return 2; // 2 columns on mobile
    } else if (isTablet(context)) {
      return 3; // 3 columns on tablet
    } else {
      return 4; // 4 columns on desktop
    }
  }

  /// Get spacing based on screen size
  static double getSpacing(BuildContext context) {
    if (isMobile(context)) {
      return 12.0;
    } else if (isTablet(context)) {
      return 16.0;
    } else {
      return 20.0;
    }
  }

  /// Get padding based on screen size
  static EdgeInsets getPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.all(12);
    } else if (isTablet(context)) {
      return const EdgeInsets.all(16);
    } else {
      return const EdgeInsets.all(24);
    }
  }

  /// Responsive widget builder
  static Widget builder({
    required BuildContext context,
    required Widget mobile,
    Widget? tablet,
    required Widget desktop,
  }) {
    if (isDesktop(context)) {
      return desktop;
    } else if (isTablet(context)) {
      return tablet ?? mobile;
    } else {
      return mobile;
    }
  }

  /// Get row height for Pluto Grid based on screen size
  static double getRowHeight(BuildContext context) {
    if (isMobile(context)) {
      return 150.0;
    } else if (isTablet(context)) {
      return 180.0;
    } else {
      return 200.0;
    }
  }
}
