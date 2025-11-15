import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'common/custom_tooltip.dart';

class DashboardFinancialCard extends StatefulWidget {
  final String? jsonFilePath;
  final Map<String, dynamic>? data;

  /// Example data for demo purposes
  static const Map<String, dynamic> exampleData = {
    'cardTitle': 'Visitor Value',
    'cardSubtitle': 'Avg. income per site visit',
    'mainValue': '\$63.02',
    'percentageChange': '-1.03%',
    'isPositiveChange': false,
    'changeLabel': 'vs last month',
    'barData': [
      {'x': 0, 'y': 45},
      {'x': 1, 'y': 78},
      {'x': 2, 'y': 52},
      {'x': 3, 'y': 90},
      {'x': 4, 'y': 65},
      {'x': 5, 'y': 82},
      {'x': 6, 'y': 58},
      {'x': 7, 'y': 95},
      {'x': 8, 'y': 72},
      {'x': 9, 'y': 88},
    ],
    'labels': [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
      'Mon',
      'Tue',
      'Wed',
    ],
    'chartConfig': {'minX': 0, 'maxX': 9, 'minY': 0, 'maxY': 100},
  };

  const DashboardFinancialCard({super.key, this.jsonFilePath, this.data});

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
      // Use provided data if available, otherwise load from JSON file, or use example data
      final data =
          widget.data ??
          (widget.jsonFilePath != null
              ? json.decode(await rootBundle.loadString(widget.jsonFilePath!))
              : DashboardFinancialCard.exampleData);

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
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F000000),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
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
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                        height: 22 / 22,
                        letterSpacing: 1.4,
                        color: isDark
                            ? const Color(0xFFFFFFFF)
                            : const Color(0xFF212121),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      cardSubtitle, // Dynamic from API
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                        height: 22 / 14,
                        letterSpacing: 0.25,
                        color: isDark
                            ? const Color(0xFFB5B7C8)
                            : const Color(0xFF757575),
                      ),
                    ),
                  ],
                ),
              ),
              // Three dots menu icon
              Icon(
                Icons.more_horiz,
                color: isDark
                    ? const Color(0xFFB5B7C8)
                    : const Color(0xFF757575),
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 32.0),

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
                  color: isDark
                      ? const Color(0xFFFFFFFF)
                      : const Color(0xFF212121),
                  height: 1.0,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(width: 16.0),
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
                      decoration: BoxDecoration(
                        color: isPositiveChange
                            ? (isDark
                                  ? const Color(0xFF064E3B)
                                  : const Color(0xFFD1FAE5))
                            : (isDark
                                  ? const Color(0xFF7F1D1D)
                                  : const Color(0xFFFEE2E2)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        percentageChange, // Dynamic from API
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                          height: 19 / 12,
                          letterSpacing: 0.4,
                          color: isPositiveChange
                              ? (isDark
                                    ? const Color(0xFF34D399)
                                    : const Color(0xFF10B981))
                              : (isDark
                                    ? const Color(0xFFF87171)
                                    : const Color(0xFFEF4444)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Change label - grey text
                    Text(
                      changeLabel, // Dynamic from API
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                        height: 19 / 12,
                        letterSpacing: 0.4,
                        color: isDark
                            ? const Color(0xFFB5B7C8)
                            : const Color(0xFF757575),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32.0),

          // Bar Chart with custom tooltip
          SizedBox(
            height:
                290, // Increased from 120 to better utilize the taller container
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: const Color(0xFF1379F0),
                    ),
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
                                  color: const Color(0xFF1379F0),
                                  borderRadius: BorderRadius.horizontal(
                                    left: const Radius.circular(4),
                                    right: const Radius.circular(4),
                                  ),
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
        color: const Color(0xFF1379F0),
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
