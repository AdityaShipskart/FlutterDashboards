// Reusable Custom Chart Tooltip Widget
// This widget provides a consistent tooltip design across all dashboard cards
// Used in: customer_feedback_card, revenue_bar_chart_card, and other chart cards

import 'package:flutter/material.dart';
import '../../const/constant.dart';

/// Custom tooltip widget for chart hover interactions
/// Displays data in a consistent, visually appealing format
///
/// Features:
/// - Automatic positioning based on cursor location
/// - Boundary detection to keep tooltip in view
/// - Dynamic content via list of tooltip items
/// - Uses AuroraTheme for consistent styling
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
    required this.items,
    this.headerText,
    required this.availableWidth,
    required this.availableHeight,
    this.isVisible = true,
    this.rightPadding = 0,
  });

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
        decoration: AuroraTheme.tooltipDecoration(),
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
        AuroraTheme.tooltipIndicator(
          color: color,
          size: AuroraTheme.tooltipIconSize,
        ),
        const SizedBox(width: 8),
        // Label text
        Text(label, style: AuroraTheme.tooltipSecondaryTextStyle()),
        const SizedBox(width: 12),
        // Value text
        Text(value, style: AuroraTheme.tooltipTextStyle()),
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
