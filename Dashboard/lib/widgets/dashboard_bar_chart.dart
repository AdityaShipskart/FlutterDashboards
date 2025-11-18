import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'common/custom_tooltip.dart';
import '../const/constant.dart';

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
    'yAxisLabels': [
      {'value': 0.0, 'label': '0K'},
      {'value': 100000.0, 'label': '100K'},
      {'value': 200000.0, 'label': '200K'},
      {'value': 300000.0, 'label': '300K'},
      {'value': 400000.0, 'label': '400K'},
      {'value': 500000.0, 'label': '500K'},
    ],
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
        'tooltip': [
          {'label': '25th', 'value': '150K'},
          {'label': '50th', 'value': '250K'},
          {'label': '75th', 'value': '350K'},
        ],
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
        'tooltip': [
          {'label': '25th', 'value': '180K'},
          {'label': '50th', 'value': '280K'},
          {'label': '75th', 'value': '380K'},
        ],
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
        'tooltip': [
          {'label': '25th', 'value': '120K'},
          {'label': '50th', 'value': '220K'},
          {'label': '75th', 'value': '320K'},
        ],
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
  List<Map<String, dynamic>> yAxisLabels = [];

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
        yAxisLabels = List<Map<String, dynamic>>.from(
          data['yAxisLabels'] ?? [],
        );

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
      decoration: BoxDecoration(
        color: AppColors.getCard(isDark),
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        border: Border.all(color: AppColors.getBorder(isDark)),
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
                    Text(cardTitle, style: AuroraTheme.cardTitleStyle(isDark)),
                    SizedBox(height: AppSpacing.sm),
                    Text(
                      cardSubtitle,
                      style: AuroraTheme.cardSubtitleStyle(isDark),
                    ),
                  ],
                ),
              ),
              // Three dots menu icon
              Icon(
                Icons.more_vert,
                size: AppConstants.iconSizeMedium,
                color: AppColors.getTextSecondary(isDark),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),

          // Legend - Dynamic from API
          Row(
            children: legendData.isEmpty
                ? [
                    // Fallback if no legend data
                    _buildLegendItem(
                      '25th',
                      AppColors.getGreyScale(300, isDark),
                      isDark,
                    ),
                    SizedBox(width: AppSpacing.md),
                    _buildLegendItem('50th', const Color(0xFF4CAF50), isDark),
                    SizedBox(width: AppSpacing.md),
                    _buildLegendItem('75th', AppColors.primary, isDark),
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
                        SizedBox(width: AppSpacing.md),
                      ],
                    );
                  }).toList(),
          ),
          SizedBox(height: AppSpacing.md),

          // Bar Chart with hover overlay
          LayoutBuilder(
            builder: (context, constraints) {
              final chartHeight = AuroraTheme.getResponsiveChartHeight(
                constraints.maxWidth,
              );
              return SizedBox(
                height: chartHeight,
                width: double.infinity,
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
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
                                        if (!event
                                                .isInterestedForInteractions ||
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
                                    showTitles: yAxisLabels.isNotEmpty,
                                    reservedSize: 50,
                                    getTitlesWidget: (value, meta) {
                                      if (yAxisLabels.isEmpty) {
                                        return const Text('');
                                      }

                                      final textStyle =
                                          AppTextStyles.b11(
                                            isDark: isDark,
                                          ).copyWith(
                                            color: AppColors.getTextSecondary(
                                              isDark,
                                            ),
                                          );

                                      // Find matching label from yAxisLabels
                                      for (final labelData in yAxisLabels) {
                                        final labelValue =
                                            (labelData['value'] as num?)
                                                ?.toDouble();
                                        if (labelValue != null &&
                                            labelValue == value) {
                                          return Text(
                                            labelData['label'] as String? ?? '',
                                            style: textStyle,
                                          );
                                        }
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
                                              value.toInt() <
                                                  chartData.length) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                top: AppSpacing.sm,
                                              ),
                                              child: Text(
                                                chartData[value
                                                    .toInt()]['label'],
                                                style:
                                                    AppTextStyles.b11(
                                                      isDark: isDark,
                                                    ).copyWith(
                                                      color:
                                                          AppColors.getTextSecondary(
                                                            isDark,
                                                          ),
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
                                    color: AppColors.getGreyScale(100, isDark),
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
              );
            },
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
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
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
        AuroraTheme.legendIndicator(
          color: color,
          size: AuroraTheme.legendIconSize,
        ),
        SizedBox(width: AppSpacing.sm),
        Text(label, style: AuroraTheme.legendTextStyle(isDark)),
      ],
    );
  }

  // Build tooltip items for CustomChartTooltip widget
  // Prepares data items to display in the tooltip
  // Labels always match legendData for consistency
  List<TooltipDataItem> _buildTooltipItems(bool isDark) {
    if (touchedGroupIndex < 0 || touchedGroupIndex >= chartData.length) {
      return [];
    }

    final data = chartData[touchedGroupIndex];

    // Check if dynamic tooltip data is provided in JSON
    if (data.containsKey('tooltip') && data['tooltip'] is List) {
      final tooltipData = data['tooltip'] as List;
      return tooltipData.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value as Map<String, dynamic>;

        // Get color from legendData
        Color itemColor;
        if (legendData.isNotEmpty && index < legendData.length) {
          final colorValue = legendData[index]['color'];
          itemColor = colorValue is int
              ? Color(colorValue)
              : Color(int.parse(colorValue as String));
        } else if (data['values'] != null &&
            index < (data['values'] as List).length) {
          itemColor = Color((data['values'][index]['color'] as int));
        } else {
          // Fallback colors
          itemColor = index == 0
              ? AppColors.getGreyScale(300, isDark)
              : index == 1
              ? const Color(0xFF4CAF50)
              : AppColors.primary;
        }

        // Use label from legendData if available, otherwise from tooltip
        final label = (legendData.isNotEmpty && index < legendData.length)
            ? legendData[index]['label'] as String
            : item['label'] as String? ?? '';

        return TooltipDataItem(
          color: itemColor,
          label: label,
          value: item['value'] as String? ?? '',
        );
      }).toList();
    }

    // Fallback: Use legendData labels with calculated values
    if (legendData.isNotEmpty) {
      final values = data['values'] as List? ?? [];
      return legendData.asMap().entries.map((entry) {
        final index = entry.key;
        final legend = entry.value;

        // Get color from legendData
        final colorValue = legend['color'];
        final color = colorValue is int
            ? Color(colorValue)
            : Color(int.parse(colorValue as String));

        // Get value from values array
        String value = '0';
        if (index < values.length) {
          final valueData = values[index] as Map<String, dynamic>;
          final numValue = (valueData['value'] as num?)?.toDouble() ?? 0;
          value = '${(numValue / 1000).toStringAsFixed(1)}K';
        }

        return TooltipDataItem(
          color: color,
          label: legend['label'] as String,
          value: value,
        );
      }).toList();
    }

    // Final fallback using values array
    final values = data['values'] as List? ?? [];
    return values.asMap().entries.map((entry) {
      final index = entry.key;
      final valueData = entry.value as Map<String, dynamic>;
      final numValue = (valueData['value'] as num?)?.toDouble() ?? 0;
      final colorInt = valueData['color'] as int? ?? 4278239141;

      return TooltipDataItem(
        color: Color(colorInt),
        label: 'Item ${index + 1}',
        value: '${(numValue / 1000).toStringAsFixed(1)}K',
      );
    }).toList();
  }
}
