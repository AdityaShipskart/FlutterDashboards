import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../data/dummy_revenue_data.dart';
import '../const/constant.dart';

/// Model class to represent a line dataset in the chart
/// Supports dynamic number of lines - can have 2, 3, 4, or more lines
class LineDataset {
  final String label;
  final List<FlSpot> data;
  final Color color;
  final double strokeWidth;
  final bool showDots;

  LineDataset({
    required this.label,
    required this.data,
    required this.color,
    this.strokeWidth = 2.5,
    this.showDots = true,
  });

  /// Convert JSON from API to LineDataset object
  factory LineDataset.fromJson(Map<String, dynamic> json) {
    return LineDataset(
      label: json['label'] ?? '',
      data: DummyRevenueData.convertToFlSpots(json['data'] ?? []),
      color: _parseColor(json['color']),
      strokeWidth: (json['strokeWidth'] ?? 2.5).toDouble(),
      showDots: json['showDots'] ?? true,
    );
  }

  /// Parse color from various formats
  /// Supports: Hex strings ("#4F46E5"), RGB values, etc.
  static Color _parseColor(dynamic colorValue) {
    if (colorValue is String) {
      // Handle hex color strings like "#4F46E5" or "4F46E5"
      String hexColor = colorValue.replaceFirst('#', '');
      if (hexColor.length == 6) {
        return Color(int.parse('0xFF$hexColor'));
      } else if (hexColor.length == 8) {
        return Color(int.parse('0x$hexColor'));
      }
    } else if (colorValue is int) {
      return Color(colorValue);
    }

    // Fallback to primary color
    return AppColors.primary;
  }

  /// Convert to JSON for API communication
  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'data': data.map((spot) => {'x': spot.x, 'y': spot.y}).toList(),
      'color':
          '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
      'strokeWidth': strokeWidth,
      'showDots': showDots,
    };
  }
}
