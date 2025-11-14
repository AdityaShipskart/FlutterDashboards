import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../const/constant.dart' show DashboardColors, AppColors;

/// Centralized service to load dashboard data once and distribute to widgets
class DashboardDataService {
  /// Load dashboard configuration from a single JSON file
  /// This should be called once at the dashboard level
  static Future<DashboardData> loadDashboardData(String jsonFilePath) async {
    try {
      final String jsonString = await rootBundle.loadString(jsonFilePath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      return DashboardData.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to load dashboard data: $e');
    }
  }

  /// Helper method to convert color strings to Color objects
  static Color _getColorFromString(dynamic colorValue) {
    // If it's already an integer, create Color from it
    if (colorValue is int) {
      return Color(colorValue);
    }

    // If it's a string, parse named colors
    if (colorValue is String) {
      switch (colorValue) {
        case 'freeIcon':
          return DashboardColors.freeIcon;
        case 'goldIcon':
          return DashboardColors.goldIcon;
        case 'platinumIcon':
          return DashboardColors.platinumIcon;
        case 'expiringIcon':
          return DashboardColors.expiringIcon;
        case 'transparent':
          return AppColors.transparent;
        default:
          return Colors.grey;
      }
    }

    return Colors.grey;
  }
}

/// Model representing the entire dashboard configuration
class DashboardData {
  final List<Map<String, dynamic>>? cards;
  final Map<String, dynamic>? lineChart;
  final Map<String, dynamic>? pieChart;
  final Map<String, dynamic>? barChart;
  final Map<String, dynamic>? comboBarChart;
  final Map<String, dynamic>? comparison;
  final Map<String, dynamic>? financialCard;
  final Map<String, dynamic>? recentActivity;
  final Map<String, dynamic>? table;
  final List<Map<String, dynamic>>? leadingPorts;
  final Map<String, dynamic>? salesHighlights;
  final Map<String, dynamic>? contentData;

  // Store the original JSON for custom widgets
  final Map<String, dynamic> rawData;

  DashboardData({
    this.cards,
    this.lineChart,
    this.pieChart,
    this.barChart,
    this.comboBarChart,
    this.comparison,
    this.financialCard,
    this.recentActivity,
    this.table,
    this.leadingPorts,
    this.salesHighlights,
    this.contentData,
    required this.rawData,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      cards: json['cards'] != null
          ? List<Map<String, dynamic>>.from(
              (json['cards'] as List).map((card) {
                final cardMap = Map<String, dynamic>.from(card);
                // Convert color strings to Color objects
                if (cardMap['color'] != null) {
                  cardMap['color'] = DashboardDataService._getColorFromString(
                    cardMap['color'],
                  );
                }
                if (cardMap['iconBgColor'] != null) {
                  cardMap['iconBgColor'] =
                      DashboardDataService._getColorFromString(
                        cardMap['iconBgColor'],
                      );
                }
                return cardMap;
              }),
            )
          : null,
      lineChart: json['lineChart'] != null
          ? Map<String, dynamic>.from(json['lineChart'])
          : null,
      pieChart: json['pieChart'] != null
          ? Map<String, dynamic>.from(json['pieChart'])
          : null,
      barChart: json['barChart'] != null
          ? Map<String, dynamic>.from(json['barChart'])
          : null,
      comboBarChart: json['comboBarChart'] != null
          ? Map<String, dynamic>.from(json['comboBarChart'])
          : null,
      comparison: json['comparison'] != null
          ? Map<String, dynamic>.from(json['comparison'])
          : null,
      financialCard: json['financialCard'] != null
          ? Map<String, dynamic>.from(json['financialCard'])
          : null,
      recentActivity: json['recentActivity'] != null
          ? Map<String, dynamic>.from(json['recentActivity'])
          : null,
      table: json['table'] != null
          ? Map<String, dynamic>.from(json['table'])
          : null,
      leadingPorts: json['leadingPorts'] != null
          ? List<Map<String, dynamic>>.from(
              (json['leadingPorts'] as List).map(
                (e) => Map<String, dynamic>.from(e),
              ),
            )
          : null,
      salesHighlights: json['salesHighlights'] != null
          ? Map<String, dynamic>.from(json['salesHighlights'])
          : null,
      contentData: json['contentData'] != null
          ? Map<String, dynamic>.from(json['contentData'])
          : null,
      rawData: Map<String, dynamic>.from(json),
    );
  }

  /// Check if a specific widget data exists
  bool hasData(String key) {
    switch (key) {
      case 'cards':
        return cards != null && cards!.isNotEmpty;
      case 'lineChart':
        return lineChart != null;
      case 'pieChart':
        return pieChart != null;
      case 'barChart':
        return barChart != null;
      case 'comboBarChart':
        return comboBarChart != null;
      case 'comparison':
        return comparison != null;
      case 'financialCard':
        return financialCard != null;
      case 'recentActivity':
        return recentActivity != null;
      case 'table':
        return table != null;
      case 'leadingPorts':
        return leadingPorts != null && leadingPorts!.isNotEmpty;
      case 'salesHighlights':
        return salesHighlights != null;
      case 'contentData':
        return contentData != null;
      default:
        return rawData.containsKey(key) && rawData[key] != null;
    }
  }

  /// Get custom data by key
  dynamic getCustomData(String key) {
    return rawData[key];
  }
}
