import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'common/custom_tooltip.dart';

/// Standalone DashboardBarChart Widget
/// Displays revenue bar chart with multiple data series
///
/// Example usage:
/// ```dart
/// DashboardBarChart() // Uses example data
/// DashboardBarChart(data: myData) // Custom data
/// ```
class DashboardBarChart extends StatefulWidget {
  final String? jsonFilePath;
  final Map<String, dynamic>? data;

  const DashboardBarChart({super.key, this.jsonFilePath, this.data});

  // Example data
  static const Map<String, dynamic> exampleData = {
    'cardTitle': 'Revenue Generated',
    'cardSubtitle': 'Amount of revenue in this month',
    'maxY': 500000.0,
    'minY': 0.0,
    'yAxisInterval': 100000.0,
    'barWidth': 8.0,
    'barsSpace': 3.0,
    'chartData': [
      {
        'label': 'Jan',
        'values': [
          {'value': 150000.0, 'color': 0xFFE0E0E0},
          {'value': 250000.0, 'color': 0xFF4CAF50},
          {'value': 350000.0, 'color': 0xFF4F46E5},
        ],
        'percentile25': 150000.0,
        'percentile50': 250000.0,
        'percentile75': 350000.0,
      },
      {
        'label': 'Feb',
        'values': [
          {'value': 180000.0, 'color': 0xFFE0E0E0},
          {'value': 280000.0, 'color': 0xFF4CAF50},
          {'value': 380000.0, 'color': 0xFF4F46E5},
        ],
        'percentile25': 180000.0,
        'percentile50': 280000.0,
        'percentile75': 380000.0,
      },
      {
        'label': 'Mar',
        'values': [
          {'value': 120000.0, 'color': 0xFFE0E0E0},
          {'value': 220000.0, 'color': 0xFF4CAF50},
          {'value': 320000.0, 'color': 0xFF4F46E5},
        ],
        'percentile25': 120000.0,
        'percentile50': 220000.0,
        'percentile75': 320000.0,
      },
    ],
    'legendData': [
      {'label': '25th', 'color': '0xFFE0E0E0'},
      {'label': '50th', 'color': '0xFF4CAF50'},
      {'label': '75th', 'color': '0xFF4F46E5'},
    ],
  };

  @override
  State<DashboardBarChart> createState() => _DashboardBarChartState();
}

class _DashboardBarChartState extends State<DashboardBarChart> {
  // Inline constants - no external dependencies
  static const double _spacingSm = 8.0;
  static const double _spacingMd = 16.0;
  static const double _spacingLg = 24.0;
  static const double _radiusLarge = 12.0;
  static const double _radiusMedium = 8.0;
  static const double _legendIconSize = 8.0;
  static const double _iconSizeMedium = 24.0;

  static const Color _darkSurface = Color(0xFF1A1A1A);
  static const Color _darkBorder = Color(0xFF363843);
  static const Color _lightBorder = Color(0xFFE0E0E0);
  static const Color _textPrimaryDark = Color(0xFFFFFFFF);
  static const Color _textPrimaryLight = Color(0xFF212121);
  static const Color _textSecondaryDark = Color(0xFFB5B7C8);
  static const Color _textSecondaryLight = Color(0xFF757575);
  static const Color _grey100Light = Color(0xFFF5F5F5);
  static const Color _grey100Dark = Color(0xFF2A2A2A);
  static const Color _grey300Light = Color(0xFFE0E0E0);
  static const Color _grey300Dark = Color(0xFF4A4A4A);
  static const Color _grey600Dark = Color(0xFF808290);
  static const Color _grey600Light = Color(0xFF8E9198);
  static const Color _primary = Color(0xFF4F46E5);
  static const Color _error = Color(0xFFEF4444);

  // ============ ALL DYNAMIC DATA FROM .NET BACKEND ============

  // Card content - all dynamic from backend
  String cardTitle = ''; // e.g., "Revenue Generated"
  String cardSubtitle = ''; // e.g., "Amount of revenue in this month"

  // Bar chart data - comes from backend API
  List<Map<String, dynamic>> chartData = [];

  // Legend data - comes from backend API
  List<Map<String, dynamic>> legendData = [];

  // Chart configuration - comes from backend
  double maxY = 500000;
  double minY = 0;
  double yAxisInterval = 100000;
  double barWidth = 8;
  double barsSpace = 3;

  // Loading state
  bool isLoading = true;
  String? errorMessage;

  // Hover state
  int touchedGroupIndex = -1;
  Offset? cursorPosition;

  @override
  void initState() {
    super.initState();
    _loadRevenueBarChartData();
  }

  // Method to load revenue bar chart data from JSON asset file
  // TODO: In future, replace asset loading with actual .NET API call using http package
  Future<void> _loadRevenueBarChartData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Use provided data if available, otherwise load from JSON file or use example data
      Map<String, dynamic> data;
      if (widget.data != null) {
        data = widget.data!;
      } else if (widget.jsonFilePath != null) {
        data =
            json.decode(await rootBundle.loadString(widget.jsonFilePath!))
                as Map<String, dynamic>;
      } else {
        // Use example data when nothing is provided
        data = DashboardBarChart.exampleData;
      }

      if (!mounted) return;

      setState(() {
        // Card content
        cardTitle = data['cardTitle'] ?? 'Revenue Generated';
        cardSubtitle = data['cardSubtitle'] ?? '';

        // Chart data
        chartData = List<Map<String, dynamic>>.from(data['chartData'] ?? []);

        // Legend data
        legendData = List<Map<String, dynamic>>.from(
          data['legendData'] ?? data['legend'] ?? [],
        );

        // Chart configuration - read from top level
        maxY = (data['maxY'] as num?)?.toDouble() ?? 500000;
        minY = (data['minY'] as num?)?.toDouble() ?? 0;
        yAxisInterval = (data['yAxisInterval'] as num?)?.toDouble() ?? 100000;
        barWidth = (data['barWidth'] as num?)?.toDouble() ?? 16;
        barsSpace = (data['barsSpace'] as num?)?.toDouble() ?? 4;

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
          backgroundColor: _error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(_spacingLg),
      decoration: BoxDecoration(
        color: isDark ? _darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(_radiusLarge),
        border: Border.all(color: isDark ? _darkBorder : _lightBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cardTitle,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDark ? _textPrimaryDark : _textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: _spacingSm),
                    Text(
                      cardSubtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark
                            ? _textSecondaryDark
                            : _textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              // Three dots menu icon
              Icon(
                Icons.more_vert,
                size: _iconSizeMedium,
                color: isDark ? _grey600Dark : _grey600Light,
              ),
            ],
          ),
          const SizedBox(height: _spacingMd),

          // Legend - Dynamic from API
          Row(
            children: legendData.isEmpty
                ? [
                    // Fallback if no legend data
                    _buildLegendItem(
                      '25th',
                      isDark ? _grey300Dark : _grey300Light,
                      isDark,
                    ),
                    const SizedBox(width: _spacingMd),
                    _buildLegendItem('50th', const Color(0xFF4CAF50), isDark),
                    const SizedBox(width: _spacingMd),
                    _buildLegendItem('75th', _primary, isDark),
                  ]
                : legendData.map((legend) {
                    final colorValue = legend['color'];
                    final color = colorValue is int
                        ? Color(colorValue)
                        : Color(int.parse(colorValue as String));
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildLegendItem(
                          legend['label'] as String,
                          color,
                          isDark,
                        ),
                        const SizedBox(width: _spacingMd),
                      ],
                    );
                  }).toList(),
          ),
          const SizedBox(height: _spacingMd),

          // Bar Chart with hover overlay
          SizedBox(
            height: 280,
            width: double.infinity,
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: _primary),
                  )
                : Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Bar Chart
                      BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY:
                              maxY +
                              (yAxisInterval *
                                  0.05), // Add 5% padding to show 500k line
                          minY: minY, // Dynamic from API
                          barTouchData: BarTouchData(
                            enabled: true,
                            touchCallback:
                                (
                                  FlTouchEvent event,
                                  BarTouchResponse? response,
                                ) {
                                  setState(() {
                                    if (!event.isInterestedForInteractions ||
                                        response == null ||
                                        response.spot == null) {
                                      touchedGroupIndex = -1;
                                      cursorPosition = null;
                                      return;
                                    }
                                    touchedGroupIndex =
                                        response.spot!.touchedBarGroupIndex;
                                    if (event is FlPointerHoverEvent ||
                                        event is FlPanUpdateEvent ||
                                        event is FlTapUpEvent) {
                                      cursorPosition = event.localPosition;
                                    }
                                  });
                                },
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor: Colors.transparent,
                              getTooltipItem:
                                  (group, groupIndex, rod, rodIndex) {
                                    // Hide default tooltip
                                    return null;
                                  },
                            ),
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 50,
                                getTitlesWidget: (value, meta) {
                                  final textStyle = TextStyle(
                                    fontSize: 11,
                                    color: isDark
                                        ? _textSecondaryDark
                                        : _textSecondaryLight,
                                  );
                                  if (value == 0) {
                                    return Text('0k', style: textStyle);
                                  }
                                  if (value == 100000) {
                                    return Text('100k', style: textStyle);
                                  }
                                  if (value == 200000) {
                                    return Text('200k', style: textStyle);
                                  }
                                  if (value == 300000) {
                                    return Text('300k', style: textStyle);
                                  }
                                  if (value == 400000) {
                                    return Text('400k', style: textStyle);
                                  }
                                  if (value == 500000) {
                                    return Text('500k', style: textStyle);
                                  }
                                  return const Text('');
                                },
                              ),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            leftTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget:
                                    (double value, TitleMeta meta) {
                                      if (value.toInt() >= 0 &&
                                          value.toInt() < chartData.length) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            top: _spacingSm,
                                          ),
                                          child: Text(
                                            chartData[value.toInt()]['label'],
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: isDark
                                                  ? _textSecondaryDark
                                                  : _textSecondaryLight,
                                            ),
                                          ),
                                        );
                                      }
                                      return const Text('');
                                    },
                              ),
                            ),
                          ),
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            horizontalInterval:
                                yAxisInterval, // Dynamic from API
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: isDark ? _grey100Dark : _grey100Light,
                                strokeWidth: 1,
                              );
                            },
                            checkToShowHorizontalLine: (value) {
                              // Show lines at 0k, 100k, 200k, 300k, 400k, and 500k
                              return value >= 0 && value <= maxY;
                            },
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: _buildBarGroups(isDark),
                        ),
                      ),
                      // Custom tooltip overlay - using reusable CustomChartTooltip
                      if (touchedGroupIndex >= 0 &&
                          touchedGroupIndex < chartData.length &&
                          cursorPosition != null)
                        CustomChartTooltip(
                          cursorPosition: cursorPosition,
                          items: _buildTooltipItems(isDark),
                          availableWidth: 350,
                          availableHeight: 250,
                          isVisible: true,
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups(bool isDark) {
    if (chartData.isEmpty) return [];

    return chartData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;

      // Get values array from data
      final values = data['values'] as List? ?? [];

      // Add opacity when not hovered
      final isHovered = touchedGroupIndex == index;
      final isSomeoneHovered = touchedGroupIndex >= 0;
      final opacity = !isSomeoneHovered || isHovered ? 1.0 : 0.3;

      // Build bar rods from values array
      final barRods = values.asMap().entries.map((valueEntry) {
        final valueData = valueEntry.value as Map<String, dynamic>;
        final value = (valueData['value'] as num?)?.toDouble() ?? 0;
        final colorInt = valueData['color'] as int? ?? 4278239141;
        final color = Color(colorInt);

        return BarChartRodData(
          toY: value,
          color: color.withValues(alpha: opacity),
          width: barWidth,
          borderRadius: BorderRadius.circular(_radiusMedium),
        );
      }).toList();

      return BarChartGroupData(
        x: index,
        barRods: barRods,
        barsSpace: barsSpace,
      );
    }).toList();
  }

  Widget _buildLegendItem(String label, Color color, bool isDark) {
    return Row(
      children: [
        Container(
          width: _legendIconSize,
          height: _legendIconSize,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: _spacingSm),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? _textSecondaryDark : _textSecondaryLight,
          ),
        ),
      ],
    );
  }

  // Build tooltip items for CustomChartTooltip widget
  // Prepares data items to display in the tooltip
  List<TooltipDataItem> _buildTooltipItems(bool isDark) {
    if (touchedGroupIndex < 0 || touchedGroupIndex >= chartData.length) {
      return [];
    }

    final data = chartData[touchedGroupIndex];
    final percentile25 = (data['percentile25'] as num).toDouble();
    final percentile50 = (data['percentile50'] as num).toDouble();
    final percentile75 = (data['percentile75'] as num).toDouble();

    // Get colors from legend
    final color25 = legendData.isNotEmpty && legendData.isNotEmpty
        ? Color(int.parse(legendData[0]['color'] as String))
        : (isDark ? _grey300Dark : _grey300Light);
    final color50 = legendData.isNotEmpty && legendData.length > 1
        ? Color(int.parse(legendData[1]['color'] as String))
        : const Color(0xFF4CAF50);
    final color75 = legendData.isNotEmpty && legendData.length > 2
        ? Color(int.parse(legendData[2]['color'] as String))
        : _primary;

    return [
      // 25th percentile
      TooltipDataItem(
        color: color25,
        label: '25th',
        value: '${(percentile25 / 1000).toStringAsFixed(1)}K',
      ),
      // 50th percentile
      TooltipDataItem(
        color: color50,
        label: '50th',
        value: '${(percentile50 / 1000).toStringAsFixed(1)}K',
      ),
      // 75th percentile
      TooltipDataItem(
        color: color75,
        label: '75th',
        value: '${(percentile75 / 1000).toStringAsFixed(1)}K',
      ),
    ];
  }
}
