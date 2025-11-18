import 'package:flutter/material.dart';
import '../../const/constant.dart';

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

  @override
  Widget build(BuildContext context) {
    final isPositive = percentage >= 0;

    // Color for text and icon
    final color = isPositive
        ? (isDark ? AppColors.successActiveDark : AppColors.success)
        : (isDark ? AppColors.errorActiveDark : AppColors.error);

    // Background color with transparency
    final bgColor = isPositive
        ? (isDark ? AppColors.successSoftDark : AppColors.successSoft)
        : (isDark ? AppColors.errorSoftDark : AppColors.errorSoft);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? (AppSpacing.sm + 2),
        vertical: verticalPadding ?? AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusXLarge),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive ? Icons.arrow_upward : Icons.arrow_downward,
            size: AppConstants.iconSizeSmall - 4,
            color: color,
          ),
          SizedBox(width: AppSpacing.xs),
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
