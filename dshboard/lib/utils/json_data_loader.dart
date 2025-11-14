import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Utility class to simplify JSON data loading across widgets
/// Eliminates duplicate loading logic and provides consistent error handling
class JsonDataLoader {
  /// Load data from either provided Map or JSON file path
  ///
  /// Throws exception if neither data nor jsonFilePath is provided
  ///
  /// Example:
  /// ```dart
  /// final data = await JsonDataLoader.loadData(
  ///   providedData: widget.data,
  ///   jsonFilePath: widget.jsonFilePath,
  /// );
  /// ```
  static Future<Map<String, dynamic>> loadData({
    Map<String, dynamic>? providedData,
    String? jsonFilePath,
    String errorContext = 'widget',
  }) async {
    if (providedData != null) {
      return providedData;
    }

    if (jsonFilePath != null) {
      try {
        final String jsonString = await rootBundle.loadString(jsonFilePath);
        return json.decode(jsonString) as Map<String, dynamic>;
      } catch (e) {
        throw Exception(
          'Failed to load $errorContext data from $jsonFilePath: $e',
        );
      }
    }

    throw Exception(
      'Either data or jsonFilePath must be provided for $errorContext',
    );
  }

  /// Safe value extraction with default fallback
  ///
  /// Example:
  /// ```dart
  /// final title = JsonDataLoader.getString(data, 'title', 'Default Title');
  /// final value = JsonDataLoader.getDouble(data, 'value', 0.0);
  /// ```
  static String getString(
    Map<String, dynamic> data,
    String key,
    String defaultValue,
  ) {
    return data[key]?.toString() ?? defaultValue;
  }

  static int getInt(Map<String, dynamic> data, String key, int defaultValue) {
    final value = data[key];
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  static double getDouble(
    Map<String, dynamic> data,
    String key,
    double defaultValue,
  ) {
    final value = data[key];
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  static bool getBool(
    Map<String, dynamic> data,
    String key,
    bool defaultValue,
  ) {
    final value = data[key];
    if (value is bool) return value;
    if (value is String) {
      if (value.toLowerCase() == 'true') return true;
      if (value.toLowerCase() == 'false') return false;
    }
    return defaultValue;
  }

  static List<T> getList<T>(
    Map<String, dynamic> data,
    String key,
    List<T> Function(List<dynamic>) converter,
  ) {
    final value = data[key];
    if (value is List) {
      return converter(value);
    }
    return [];
  }

  static Map<String, dynamic> getMap(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return {};
  }
}

/// Mixin for widgets that load JSON data
/// Provides consistent loading state management
mixin JsonLoadingStateMixin<T extends StatefulWidget> on State<T> {
  bool isLoading = true;
  String? errorMessage;

  /// Start loading state
  void startLoading() {
    if (mounted) {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });
    }
  }

  /// Complete loading successfully
  void completeLoading() {
    if (mounted) {
      setState(() {
        isLoading = false;
        errorMessage = null;
      });
    }
  }

  /// Complete loading with error
  void failLoading(String error) {
    if (mounted) {
      setState(() {
        isLoading = false;
        errorMessage = error;
      });
    }
  }

  /// Execute async operation with automatic state management
  Future<void> executeLoad(Future<void> Function() operation) async {
    startLoading();
    try {
      await operation();
      completeLoading();
    } catch (e) {
      failLoading('Failed to load data: $e');
    }
  }
}
