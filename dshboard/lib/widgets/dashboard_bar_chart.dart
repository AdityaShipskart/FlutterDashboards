import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import '../const/constant.dart';
import 'common/custom_tooltip.dart';

class DashboardBarChart extends StatefulWidget {
  final String? jsonFilePath;
  final Map<String, dynamic>? data;

  const DashboardBarChart({super.key, this.jsonFilePath, this.data});

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
      // Use provided data if available, otherwise load from JSON file
      final data =
          widget.data ??
          (widget.jsonFilePath != null
                  ? json.decode(
                      await rootBundle.loadString(widget.jsonFilePath!),
                    )
                  : throw Exception(
                      'Either data or jsonFilePath must be provided',
                    ))
              as Map<String, dynamic>;

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
                    AuroraTheme.smallVerticalSpacing(),
                    Text(
                      cardSubtitle,
                      style: AuroraTheme.cardSubtitleStyle(isDark),
                    ),
                  ],
                ),
              ),
              // Three dots menu icon
              AuroraTheme.cardMenuIcon(isDark),
            ],
          ),
          AuroraTheme.legendChartSpacing(),

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
                    AuroraTheme.legendItemSpacing(),
                    _buildLegendItem('50th', const Color(0xFF4CAF50), isDark),
                    AuroraTheme.legendItemSpacing(),
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
                        AuroraTheme.legendItemSpacing(),
                      ],
                    );
                  }).toList(),
          ),
          AuroraTheme.legendChartSpacing(),

          // Bar Chart with hover overlay
          SizedBox(
            height: 280,
            width: double.infinity,
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
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
                                  if (value == 0) {
                                    return Text(
                                      '0k',
                                      style: AppTextStyles.b11(isDark: isDark)
                                          .copyWith(
                                            color: AppColors.getTextSecondary(
                                              isDark,
                                            ),
                                          ),
                                    );
                                  }
                                  if (value == 100000) {
                                    return Text(
                                      '100k',
                                      style: AppTextStyles.b11(isDark: isDark)
                                          .copyWith(
                                            color: AppColors.getTextSecondary(
                                              isDark,
                                            ),
                                          ),
                                    );
                                  }
                                  if (value == 200000) {
                                    return Text(
                                      '200k',
                                      style: AppTextStyles.b11(isDark: isDark)
                                          .copyWith(
                                            color: AppColors.getTextSecondary(
                                              isDark,
                                            ),
                                          ),
                                    );
                                  }
                                  if (value == 300000) {
                                    return Text(
                                      '300k',
                                      style: AppTextStyles.b11(isDark: isDark)
                                          .copyWith(
                                            color: AppColors.getTextSecondary(
                                              isDark,
                                            ),
                                          ),
                                    );
                                  }
                                  if (value == 400000) {
                                    return Text(
                                      '400k',
                                      style: AppTextStyles.b11(isDark: isDark)
                                          .copyWith(
                                            color: AppColors.getTextSecondary(
                                              isDark,
                                            ),
                                          ),
                                    );
                                  }
                                  if (value == 500000) {
                                    return Text(
                                      '500k',
                                      style: AppTextStyles.b11(isDark: isDark)
                                          .copyWith(
                                            color: AppColors.getTextSecondary(
                                              isDark,
                                            ),
                                          ),
                                    );
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
                                getTitlesWidget: (double value, TitleMeta meta) {
                                  if (value.toInt() >= 0 &&
                                      value.toInt() < chartData.length) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        top: AppSpacing.sm,
                                      ),
                                      child: Text(
                                        chartData[value.toInt()]['label'],
                                        style: AppTextStyles.b11(isDark: isDark)
                                            .copyWith(
                                              color: AppColors.getTextSecondary(
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
          borderRadius: AuroraTheme.chartBarBorderRadius(),
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
        : AppColors.getGreyScale(300, isDark);
    final color50 = legendData.isNotEmpty && legendData.length > 1
        ? Color(int.parse(legendData[1]['color'] as String))
        : const Color(0xFF4CAF50);
    final color75 = legendData.isNotEmpty && legendData.length > 2
        ? Color(int.parse(legendData[2]['color'] as String))
        : AppColors.primary;

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
