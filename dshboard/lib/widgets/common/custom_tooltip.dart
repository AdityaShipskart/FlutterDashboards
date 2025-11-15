// Standalone Reusable Custom Chart Tooltip Widget
// This widget provides a consistent tooltip design across all dashboard cards
// Used in: customer_feedback_card, revenue_bar_chart_card, and other chart cards
//
// Example usage:
// ```dart
// CustomChartTooltip(
//   cursorPosition: Offset(100, 150),
//   items: [
//     TooltipDataItem(color: Colors.blue, label: 'Revenue', value: '\$5.2K'),
//     TooltipDataItem(color: Colors.green, label: 'Profit', value: '\$2.1K'),
//   ],
//   headerText: 'January',
//   availableWidth: 400,
//   availableHeight: 300,
//   isVisible: true,
// )
// ```

import 'package:flutter/material.dart';

/// Custom tooltip widget for chart hover interactions
/// Displays data in a consistent, visually appealing format
///
/// Features:
/// - Automatic positioning based on cursor location
/// - Boundary detection to keep tooltip in view
/// - Dynamic content via list of tooltip items
/// - All styling is self-contained (no external dependencies)
class CustomChartTooltip extends StatelessWidget {
  /// Current cursor position (required for tooltip placement)
  final Offset? cursorPosition;

  /// List of tooltip data items to display
  /// Each item should have: color, label, value
  final List<TooltipDataItem> items;

  /// Optional header text (e.g., month name, category)
  final String? headerText;

  /// Available width for tooltip positioning
  /// Used to ensure tooltip stays within bounds
  final double availableWidth;

  /// Available height for tooltip positioning
  final double availableHeight;

  /// Whether to show the tooltip
  /// Set to false to hide (e.g., when not hovering)
  final bool isVisible;

  /// Right padding offset (for charts with Y-axis labels on right)
  final double rightPadding;

  const CustomChartTooltip({
    super.key,
    required this.cursorPosition,
    this.items = const [], // Default empty list
    this.headerText,
    this.availableWidth = 400,
    this.availableHeight = 300,
    this.isVisible = true,
    this.rightPadding = 0,
  });

  // Inline constants - no external dependencies
  static const double _tooltipIconSize = 8.0;

  // Inline tooltip decoration method
  static BoxDecoration _tooltipDecoration({
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

  // Inline tooltip text style method
  static TextStyle _tooltipTextStyle({
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

  // Inline tooltip secondary text style method
  static TextStyle _tooltipSecondaryTextStyle({
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

  // Inline tooltip indicator method
  static Widget _tooltipIndicator({
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

  @override
  Widget build(BuildContext context) {
    // Don't render if not visible or no data
    if (!isVisible || items.isEmpty) {
      return const SizedBox.shrink();
    }

    // Calculate tooltip position near cursor
    double tooltipLeft = 10;
    double tooltipTop = 10;

    if (cursorPosition != null) {
      // Position tooltip relative to cursor with offset
      tooltipLeft = cursorPosition!.dx + 15; // 15px right of cursor
      tooltipTop = cursorPosition!.dy - 50; // 50px above cursor

      // Ensure tooltip stays within chart bounds
      // Estimated tooltip dimensions: width ~160px, height varies by items
      final tooltipWidth = 160.0;
      final tooltipHeight = 80.0 + (items.length * 20.0);
      final effectiveWidth = availableWidth - rightPadding;

      // Horizontal bounds check
      if (tooltipLeft > effectiveWidth - tooltipWidth) {
        // Show on left side of cursor if too close to right edge
        tooltipLeft = cursorPosition!.dx - tooltipWidth - 15;
      }

      // Vertical bounds check
      if (tooltipTop < 5) {
        tooltipTop = 5; // Minimum top margin
      }
      if (tooltipTop > availableHeight - tooltipHeight) {
        tooltipTop = availableHeight - tooltipHeight; // Keep in view
      }
    }

    return Positioned(
      left: tooltipLeft,
      top: tooltipTop,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: _tooltipDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Optional header (e.g., "January", "Q1", etc.)
            if (headerText != null) ...[
              Text(
                headerText!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
            ],

            // Tooltip data items
            ...items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index < items.length - 1 ? 4 : 0,
                ),
                child: _buildTooltipRow(
                  color: item.color,
                  label: item.label,
                  value: item.value,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  /// Helper method to build a single tooltip row
  Widget _buildTooltipRow({
    required Color color,
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Colored dot indicator
        _tooltipIndicator(color: color, size: _tooltipIconSize),
        const SizedBox(width: 8),
        // Label text
        Text(label, style: _tooltipSecondaryTextStyle()),
        const SizedBox(width: 12),
        // Value text
        Text(value, style: _tooltipTextStyle()),
      ],
    );
  }
}

/// Data model for a single tooltip item
/// Represents one row in the tooltip display
class TooltipDataItem {
  /// Color indicator for this data series
  final Color color;

  /// Label text (e.g., "25th", "Positive", "Revenue")
  final String label;

  /// Formatted value text (e.g., "5.2K", "$1.2M", "75%")
  final String value;

  const TooltipDataItem({
    required this.color,
    required this.label,
    required this.value,
  });

  /// Create from map (useful for dynamic data from backend)
  factory TooltipDataItem.fromMap(Map<String, dynamic> map) {
    return TooltipDataItem(
      color: map['color'] is Color
          ? map['color']
          : Color(int.parse(map['color'] as String)),
      label: map['label'] as String,
      value: map['value'] as String,
    );
  }

  /// Convert to map (useful for serialization)
  Map<String, dynamic> toMap() {
    return {
      'color': color.toARGB32().toString(),
      'label': label,
      'value': value,
    };
  }
}

// ============ USAGE EXAMPLES ============
//
// 1. BASIC USAGE:
//
// CustomChartTooltip(
//   cursorPosition: cursorPosition,
//   items: [
//     TooltipDataItem(
//       color: Colors.blue,
//       label: 'Revenue',
//       value: '\$5.2K',
//     ),
//     TooltipDataItem(
//       color: Colors.green,
//       label: 'Profit',
//       value: '\$2.1K',
//     ),
//   ],
//   availableWidth: constraints.maxWidth,
//   availableHeight: constraints.maxHeight,
//   isVisible: touchedIndex >= 0,
// )
//
// 2. WITH HEADER:
//
// CustomChartTooltip(
//   cursorPosition: cursorPosition,
//   headerText: 'January',
//   items: tooltipItems,
//   availableWidth: constraints.maxWidth,
//   availableHeight: 250,
//   rightPadding: 45,
// )
//
// 3. DYNAMIC FROM BACKEND DATA:
//
// final items = (data['tooltipItems'] as List)
//     .map((item) => TooltipDataItem.fromMap(item))
//     .toList();
//
// CustomChartTooltip(
//   cursorPosition: cursorPosition,
//   items: items,
//   availableWidth: constraints.maxWidth,
//   availableHeight: 300,
// )
