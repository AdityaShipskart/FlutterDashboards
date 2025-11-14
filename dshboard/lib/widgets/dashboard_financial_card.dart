import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import '../const/constant.dart';
import 'common/custom_tooltip.dart';

class DashboardFinancialCard extends StatefulWidget {
  final String jsonFilePath;

  const DashboardFinancialCard({super.key, required this.jsonFilePath});

  @override
  State<DashboardFinancialCard> createState() => _DashboardFinancialCardState();
}

class _DashboardFinancialCardState extends State<DashboardFinancialCard> {
  // ============ ALL DYNAMIC DATA FROM .NET BACKEND ============

  // Chart data - comes from backend API
  List<BarChartGroupData> barData = [];
  List<String> labels = [];

  // Card content - all dynamic from backend
  String cardTitle = ''; // e.g., "Visitor Value"
  String cardSubtitle = ''; // e.g., "Avg. income per site visit"
  String mainValue = ''; // e.g., "$63.02"
  String percentageChange = ''; // e.g., "-1.03%"
  bool isPositiveChange = true; // true for positive, false for negative
  String changeLabel = ''; // e.g., "vs last month"

  // Chart configuration - comes from backend
  double minX = 0;
  double maxX = 9;
  double minY = 0;
  double maxY = 100;

  // Loading state
  bool isLoading = true;
  String? errorMessage;

  // Touch state for hover effect
  int touchedIndex = -1;

  // Cursor position for tooltip placement
  Offset? cursorPosition;

  @override
  void initState() {
    super.initState();
    _loadVisitorValueData();
  }

  // Method to load visitor value data from JSON file
  // TODO: In future, replace JSON file loading with actual .NET API call using http package
  Future<void> _loadVisitorValueData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Load data from JSON file
      // TO INTEGRATE WITH .NET API:
      // 1. Add http package to pubspec.yaml: http: ^1.1.0
      // 2. Import: import 'package:http/http.dart' as http;
      // 3. Replace next lines with:
      //    final response = await http.get(
      //      Uri.parse('https://your-dotnet-api.com/api/visitor-value/dashboard'),
      //      headers: {'Authorization': 'Bearer YOUR_TOKEN'},
      //    );
      //    final data = json.decode(response.body);
      final String jsonString = await rootBundle.loadString(
        widget.jsonFilePath,
      );
      final data = json.decode(jsonString);

      if (!mounted) return;

      setState(() {
        // Card content
        cardTitle = data['cardTitle'] ?? 'Visitor Value';
        cardSubtitle = data['cardSubtitle'] ?? '';
        mainValue = data['mainValue'] ?? '\$0.00';
        percentageChange = data['percentageChange'] ?? '+0.00%';
        isPositiveChange = data['isPositiveChange'] ?? true;
        changeLabel = data['changeLabel'] ?? '';

        // Chart data - convert from JSON format to BarChartGroupData
        barData = _convertToBarChartData(data['barData'] ?? []);

        labels = List<String>.from(data['labels'] ?? []);

        // Chart configuration
        final chartConfig = _parseChartConfig(data['chartConfig'] ?? {});
        minX = chartConfig['minX'] ?? 0;
        maxX = chartConfig['maxX'] ?? 9;
        minY = chartConfig['minY'] ?? 0;
        maxY = chartConfig['maxY'] ?? 100;

        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load data: ${e.toString()}';
      });

      // Show error to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $errorMessage'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: AuroraTheme.chartPadding(),
      decoration: AuroraTheme.cardDecoration(isDark),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with title and menu icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cardTitle, // Dynamic from API
                      style: AuroraTheme.cardTitleStyle(isDark),
                    ),
                    AuroraTheme.smallVerticalSpacing(),
                    Text(
                      cardSubtitle, // Dynamic from API
                      style: AuroraTheme.cardSubtitleStyle(isDark),
                    ),
                  ],
                ),
              ),
              // Three dots menu icon
              AuroraTheme.cardMenuIcon(isDark),
            ],
          ),
          AuroraTheme.cardHeaderSpacing(),

          // Main value and percentage change
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Main value (large text)
              Text(
                mainValue, // Dynamic from API
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: AppColors.getTextPrimary(isDark),
                  height: 1.0,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(width: AppSpacing.md),
              // Percentage change badge and label in one line
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    // Percentage badge - soft orange/peach background for negative
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: AuroraTheme.percentageContainerDecoration(
                        isPositive: isPositiveChange,
                        isDark: isDark,
                      ),
                      child: Text(
                        percentageChange, // Dynamic from API
                        style: AuroraTheme.percentageTextStyle(
                          isPositive: isPositiveChange,
                          isDark: isDark,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Change label - grey text
                    Text(
                      changeLabel, // Dynamic from API
                      style: AuroraTheme.changeLabelStyle(isDark),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AuroraTheme.cardHeaderSpacing(),

          // Bar Chart with custom tooltip
          SizedBox(
            height:
                300, // Increased from 120 to better utilize the taller container
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                : Stack(
                    clipBehavior: Clip.none, // Allow tooltip to overflow
                    children: [
                      // Bar Chart
                      BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceEvenly,
                          maxY: maxY,
                          minY: minY,
                          barTouchData: BarTouchData(
                            enabled: true,
                            touchCallback: (FlTouchEvent event, barTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    barTouchResponse == null ||
                                    barTouchResponse.spot == null) {
                                  touchedIndex = -1;
                                  cursorPosition = null;
                                  return;
                                }

                                touchedIndex =
                                    barTouchResponse.spot!.touchedBarGroupIndex;

                                // Capture cursor position for tooltip placement
                                if (event is FlPointerHoverEvent ||
                                    event is FlPanUpdateEvent ||
                                    event is FlTapUpEvent) {
                                  cursorPosition = event.localPosition;
                                }
                              });
                            },
                            // Disable default tooltip
                            touchTooltipData: BarTouchTooltipData(
                              getTooltipItem:
                                  (group, groupIndex, rod, rodIndex) => null,
                            ),
                          ),
                          titlesData: FlTitlesData(
                            show: false, // Hide all axis labels for clean look
                          ),
                          borderData: FlBorderData(show: false),
                          gridData: FlGridData(show: false),
                          barGroups: barData.map((group) {
                            return BarChartGroupData(
                              x: group.x,
                              barRods: group.barRods.map((rod) {
                                return BarChartRodData(
                                  toY: rod.toY,
                                  width: 8,
                                  color: AppColors.primary,
                                  borderRadius:
                                      AuroraTheme.chartHorizontalBarBorderRadius(),
                                );
                              }).toList(),
                            );
                          }).toList(),
                        ),
                      ),
                      // Custom tooltip overlay
                      if (touchedIndex >= 0 &&
                          touchedIndex < labels.length &&
                          touchedIndex < barData.length &&
                          !isLoading &&
                          cursorPosition != null)
                        CustomChartTooltip(
                          cursorPosition: cursorPosition,
                          items: _buildTooltipItems(touchedIndex),
                          availableWidth: double.infinity,
                          availableHeight: 120,
                          isVisible: true,
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  // Build tooltip items for CustomChartTooltip widget
  List<TooltipDataItem> _buildTooltipItems(int index) {
    if (index >= labels.length || index >= barData.length) {
      return [];
    }

    final label = labels[index];
    final value = barData[index].barRods.isNotEmpty
        ? barData[index].barRods.first.toY
        : 0.0;

    return [
      TooltipDataItem(
        color: AppColors.primary,
        label: label,
        value: '\$${value.toStringAsFixed(2)}',
      ),
    ];
  }

  /// Helper method to convert JSON data to BarChartGroupData for fl_chart
  List<BarChartGroupData> _convertToBarChartData(List<dynamic> dataPoints) {
    return dataPoints.asMap().entries.map((entry) {
      final index = entry.key;
      final point = entry.value;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: (point['y'] as num).toDouble(),
            width: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();
  }

  /// Parse chart configuration from JSON response
  Map<String, double> _parseChartConfig(Map<String, dynamic> config) {
    return {
      'minX': (config['minX'] as num?)?.toDouble() ?? 0.0,
      'maxX': (config['maxX'] as num?)?.toDouble() ?? 9.0,
      'minY': (config['minY'] as num?)?.toDouble() ?? 0.0,
      'maxY': (config['maxY'] as num?)?.toDouble() ?? 100.0,
    };
  }
}
