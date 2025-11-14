import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../const/constant.dart' show DashboardColors, AppColors;

class CardDataService {
  /// Load cards data from JSON file and return processed card data
  static Future<List<Map<String, dynamic>>> loadCardsData() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/cards_data.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> cards = jsonData['cards'];

      return cards
          .map(
            (card) => {
              'iconPath': card['iconPath'],
              'value': card['value'],
              'label': card['label'],
              'growth': card['growth'],
              'color': _getColorFromString(card['color']),
              'iconBgColor': _getColorFromString(card['iconBgColor']),
            },
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Helper method to convert color strings to Color objects
  static Color _getColorFromString(String colorName) {
    switch (colorName) {
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
}
