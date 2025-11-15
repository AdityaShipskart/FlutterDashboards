import 'package:flutter/material.dart';

/// Standalone PercentageChip widget - displays percentage change with arrow indicator
///
/// Example usage:
/// ```dart
/// PercentageChip(
///   percentage: 5.3,
///   isDark: false,
/// )
/// ```
///
/// Example data: percentage = 5.3 (for +5.3% increase)
class PercentageChip extends StatelessWidget {
  final double percentage;
  final bool isDark;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? fontSize;
  final FontWeight? fontWeight;

  const PercentageChip({
    super.key,
    this.percentage = 5.3, // Default example: +5.3%
    this.isDark = false,
    this.horizontalPadding,
    this.verticalPadding,
    this.fontSize,
    this.fontWeight,
  });

  // Inline constants - no external dependencies
  static const double _radiusXLarge = 16.0;
  static const double _iconSizeSmall = 16.0;
  static const double _spacingSm = 8.0;
  static const double _spacingXs = 4.0;

  // Inline colors - no external dependencies
  static const Color _successLight = Color(0xFF10B981);
  static const Color _successDark = Color(0xFF34D399);
  static const Color _successSoftLight = Color(0xFFD1FAE5);
  static const Color _successSoftDark = Color(0xFF064E3B);
  static const Color _errorLight = Color(0xFFEF4444);
  static const Color _errorDark = Color(0xFFF87171);
  static const Color _errorSoftLight = Color(0xFFFEE2E2);
  static const Color _errorSoftDark = Color(0xFF7F1D1D);

  @override
  Widget build(BuildContext context) {
    final isPositive = percentage >= 0;

    // Color for text and icon
    final color = isPositive
        ? (isDark ? _successDark : _successLight)
        : (isDark ? _errorDark : _errorLight);

    // Background color with transparency
    final bgColor = isPositive
        ? (isDark ? _successSoftDark : _successSoftLight)
        : (isDark ? _errorSoftDark : _errorSoftLight);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? (_spacingSm + 2),
        vertical: verticalPadding ?? _spacingXs,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(_radiusXLarge),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive ? Icons.arrow_upward : Icons.arrow_downward,
            size: _iconSizeSmall - 4,
            color: color,
          ),
          const SizedBox(width: _spacingXs),
          Text(
            '${percentage.abs().toStringAsFixed(1)}%',
            style: TextStyle(
              fontSize: fontSize ?? 13,
              fontWeight: fontWeight ?? FontWeight.w600,
              color: color,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }
}
