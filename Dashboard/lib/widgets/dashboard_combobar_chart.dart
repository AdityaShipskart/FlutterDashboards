import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'common/custom_tooltip.dart';
import '../const/constant.dart';

class DashboardcombobarChart extends StatefulWidget {
  final String? jsonFilePath;
  final Map<String, dynamic>? data;

  const DashboardcombobarChart({super.key, this.jsonFilePath, this.data});

  // Example data
  static const Map<String, dynamic> exampleData = {
    'cardTitle': 'Customer Feedback',
    'cardSubtitle': 'Number of clients with response',
    'minY': 0.0,
    'maxY': 100.0,
    'gridInterval': 20.0,
    'yAxisLabels': [
      {'value': 0, 'label': '0%'},
      {'value': 20, 'label': '20%'},
      {'value': 40, 'label': '40%'},
      {'value': 60, 'label': '60%'},
      {'value': 80, 'label': '80%'},
      {'value': 100, 'label': '100%'},
    ],
    'legendLabels': {'firstBar': 'Wins', 'secondBar': 'Losses'},
    'chartData': [
      {'month': 'Jan', 'wins': 45.0, 'losses': 15.0, 'winRate': 75.0},
      {'month': 'Feb', 'wins': 52.0, 'losses': 18.0, 'winRate': 74.3},
      {'month': 'Mar', 'wins': 61.0, 'losses': 12.0, 'winRate': 83.6},
      {'month': 'Apr', 'wins': 58.0, 'losses': 14.0, 'winRate': 80.6},
      {'month': 'May', 'wins': 65.0, 'losses': 10.0, 'winRate': 86.7},
      {'month': 'Jun', 'wins': 72.0, 'losses': 8.0, 'winRate': 90.0},
    ],
  };

  @override
  State<DashboardcombobarChart> createState() => _DashboardcombobarChartState();
}

class _DashboardcombobarChartState extends State<DashboardcombobarChart> {
  // ============ ALL DYNAMIC DATA FROM .NET BACKEND ============

  // Card content - all dynamic from backend
  String cardTitle = ''; // e.g., "Customer Feedback"
  String cardSubtitle = ''; // e.g., "Number of clients with response"

  // Chart data - comes from backend API
  List<Map<String, dynamic>> chartData = [];

  // Y-axis labels configuration - all dynamic from backend
  // Format: [{"value": 0, "label": "0k"}, {"value": 5000, "label": "5k"}, ...]
  List<Map<String, dynamic>> yAxisLabels = [];

  // Chart configuration - comes from backend
  double minY = 0;
  double maxY = 100;
  double gridInterval = 20;

  // Legend labels - dynamic from backend
  String firstBarLabel = 'Wins';
  String secondBarLabel = 'Losses';
  String thirdBarLabel = '';
  String lineLabel = 'Win Rate';

  // Loading state
  bool isLoading = true;
  String? errorMessage;

  // Touch state for hover effect on line chart
  int touchedIndex = -1;

  // Cursor position for tooltip placement
  Offset? cursorPosition;

  @override
  void initState() {
    super.initState();
    _loadCustomerFeedbackData();
  }

  // Default Y-axis labels if backend doesn't provide them
  List<Map<String, dynamic>> _getDefaultYAxisLabels() {
    return [
      {"value": 0, "label": "0%"},
      {"value": 20, "label": "20%"},
      {"value": 40, "label": "40%"},
      {"value": 60, "label": "60%"},
      {"value": 80, "label": "80%"},
      {"value": 100, "label": "100%"},
    ];
  }

  // Method to load customer feedback data from JSON file
  // TODO: In future, replace with actual .NET API call using http package
  Future<void> _loadCustomerFeedbackData() async {
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
      //      Uri.parse('https://your-dotnet-api.com/api/customer-feedback/dashboard'),
      //      headers: {'Authorization': 'Bearer YOUR_TOKEN'},
      //    );
      //    final data = json.decode(response.body);
      // Use provided data, JSON file, or fallback to example data
      final data =
          widget.data ??
          (widget.jsonFilePath != null
              ? json.decode(await rootBundle.loadString(widget.jsonFilePath!))
              : DashboardcombobarChart.exampleData);

      if (!mounted) return;

      setState(() {
        // Card content
        cardTitle = data['cardTitle'] ?? 'Customer Feedback';
        cardSubtitle = data['cardSubtitle'] ?? '';
        final chartDataRaw = data['chartData'] ?? [];
        chartData = (chartDataRaw as List)
            .map((item) => Map<String, dynamic>.from(item as Map))
            .toList();

        // Y-axis labels configuration - dynamic from backend
        // TODO: .NET backend should return "yAxisLabels" array
        // Format: [{"value": 0, "label": "0%"}, {"value": 20, "label": "20%"}, ...]
        final yAxisData = data['yAxisLabels'] ?? _getDefaultYAxisLabels();
        yAxisLabels = (yAxisData as List)
            .map((item) => Map<String, dynamic>.from(item as Map))
            .toList();

        // Chart range configuration - dynamic from backend
        // TODO: .NET backend should return "minY", "maxY", "gridInterval"
        minY = (data['minY'] ?? 0).toDouble();
        maxY = (data['maxY'] ?? 100).toDouble();
        gridInterval = (data['gridInterval'] ?? 20).toDouble();

        final legendLabelsData = data['legendLabels'];
        if (legendLabelsData != null && legendLabelsData is Map) {
          // Clear existing labels
          firstBarLabel = '';
          secondBarLabel = '';
          thirdBarLabel = '';
          lineLabel = '';

          // Set labels based on available keys
          if (legendLabelsData.containsKey('firstBar')) {
            firstBarLabel = legendLabelsData['firstBar'] ?? '';
          }
          if (legendLabelsData.containsKey('secondBar')) {
            secondBarLabel = legendLabelsData['secondBar'] ?? '';
          }
          if (legendLabelsData.containsKey('thirdBar')) {
            thirdBarLabel = legendLabelsData['thirdBar'] ?? '';
          }
          if (legendLabelsData.containsKey('line')) {
            lineLabel = legendLabelsData['line'] ?? '';
          }
        } else {
          // No legend data provided
          firstBarLabel = '';
          secondBarLabel = '';
          thirdBarLabel = '';
          lineLabel = '';
        }
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

    return LayoutBuilder(
      builder: (context, constraints) => Container(
        width: double.infinity,
        height: constraints.maxHeight,
        padding: AuroraTheme.chartPadding(),
        decoration: BoxDecoration(
          color: AppColors.getCard(isDark),
          borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        cardTitle,
                        style: AuroraTheme.cardTitleStyle(isDark),
                      ),
                      SizedBox(height: AppSpacing.xs),
                      Text(
                        cardSubtitle,
                        style: AuroraTheme.cardSubtitleStyle(isDark),
                      ),
                    ],
                  ),
                ),
                // Three dots menu icon
                Icon(
                  Icons.more_horiz,
                  color: AppColors.getTextSecondary(isDark),
                  size: AppConstants.iconSizeMedium,
                ),
              ],
            ),
            SizedBox(height: AppSpacing.md),

            // Bar Chart with Line (responsive height)
            LayoutBuilder(
              builder: (context, constraints) {
                // Calculate responsive chart height based on card width
                final chartHeight = AuroraTheme.getResponsiveChartHeight(
                  constraints.maxWidth,
                );

                return SizedBox(
                  height: chartHeight,
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        )
                      : Stack(
                          clipBehavior: Clip.none, // Allow tooltip to overflow
                          children: [
                            // Bar Chart (bars only)
                            BarChart(
                              BarChartData(
                                alignment: BarChartAlignment.spaceAround,
                                // Chart range - dynamic from .NET backend
                                maxY: maxY,
                                minY: minY,
                                barTouchData: BarTouchData(enabled: false),
                                titlesData: FlTitlesData(
                                  show: true,
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: gridInterval,
                                      reservedSize: constraints.maxWidth < 300
                                          ? 35
                                          : 45,
                                      getTitlesWidget: (value, meta) {
                                        // Y-axis labels - FULLY DYNAMIC from .NET backend
                                        // [{"value": 0, "label": "0k"}, {"value": 5000, "label": "5k"}, ...]

                                        // Find matching label for this value from backend data
                                        // Use tolerance for floating point comparison
                                        for (var labelConfig in yAxisLabels) {
                                          final labelValue =
                                              (labelConfig['value'] as num)
                                                  .toDouble();
                                          if ((labelValue - value).abs() <
                                              0.1) {
                                            return Text(
                                              labelConfig['label'],
                                              style:
                                                  AppTextStyles.b11(
                                                    isDark: isDark,
                                                  ).copyWith(
                                                    color:
                                                        AppColors.getTextSecondary(
                                                          isDark,
                                                        ),
                                                    fontSize:
                                                        constraints.maxWidth <
                                                            300
                                                        ? 10
                                                        : 11,
                                                  ),
                                            );
                                          }
                                        }

                                        // No label for this value
                                        return const Text('');
                                      },
                                    ),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 30,
                                      getTitlesWidget: (value, meta) {
                                        // Show month labels from chartData
                                        final index = value.toInt();
                                        if (index >= 0 &&
                                            index < chartData.length) {
                                          final month =
                                              chartData[index]['month']
                                                  as String? ??
                                              '';
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                            ),
                                            child: Text(
                                              month,
                                              style:
                                                  AppTextStyles.b11(
                                                    isDark: isDark,
                                                  ).copyWith(
                                                    color:
                                                        AppColors.getTextSecondary(
                                                          isDark,
                                                        ),
                                                    fontSize:
                                                        constraints.maxWidth <
                                                            300
                                                        ? 10
                                                        : 11,
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
                                  // Grid interval - dynamic from .NET backend
                                  // TODO: Backend provides gridInterval value
                                  horizontalInterval: gridInterval,
                                  getDrawingHorizontalLine: (value) {
                                    return FlLine(
                                      color: AppColors.getGreyScale(
                                        200,
                                        isDark,
                                      ),
                                      strokeWidth: 1,
                                    );
                                  },
                                ),
                                borderData: FlBorderData(show: false),
                                barGroups: _buildBarGroups(),
                              ),
                            ),
                            // Line Chart overlay (75th percentile smooth curve)
                            Padding(
                              padding: EdgeInsets.only(
                                left: 0,
                                right: constraints.maxWidth < 300 ? 35 : 45,
                              ),
                              child: LineChart(
                                LineChartData(
                                  // Chart range - dynamic from .NET backend
                                  minY: minY,
                                  maxY: maxY,
                                  minX: 0,
                                  maxX: (chartData.length - 1).toDouble(),
                                  clipData: FlClipData.all(),
                                  lineTouchData: LineTouchData(
                                    enabled: true,
                                    touchCallback:
                                        (
                                          FlTouchEvent event,
                                          LineTouchResponse? lineTouchResponse,
                                        ) {
                                          setState(() {
                                            if (!event
                                                    .isInterestedForInteractions ||
                                                lineTouchResponse == null ||
                                                lineTouchResponse
                                                        .lineBarSpots ==
                                                    null ||
                                                lineTouchResponse
                                                    .lineBarSpots!
                                                    .isEmpty) {
                                              touchedIndex = -1;
                                              cursorPosition = null;
                                              return;
                                            }

                                            // Get the touched spot index
                                            final spot = lineTouchResponse
                                                .lineBarSpots!
                                                .first;
                                            touchedIndex = spot.spotIndex;

                                            // Capture cursor position for tooltip placement
                                            if (event is FlPointerHoverEvent ||
                                                event is FlPanUpdateEvent ||
                                                event is FlTapUpEvent) {
                                              cursorPosition =
                                                  event.localPosition;
                                            }
                                          });
                                        },
                                    touchTooltipData: LineTouchTooltipData(
                                      getTooltipItems:
                                          (List<LineBarSpot> touchedSpots) {
                                            // Return list of nulls to hide default fl_chart tooltip
                                            return touchedSpots
                                                .map((spot) => null)
                                                .toList();
                                          },
                                    ),
                                  ),
                                  titlesData: FlTitlesData(show: false),
                                  gridData: FlGridData(show: false),
                                  borderData: FlBorderData(show: false),
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: _buildLineSpots(),
                                      isCurved: true,
                                      curveSmoothness: 0.35,
                                      color: const Color(0xFF4F9EF8),
                                      barWidth: 2.5,
                                      isStrokeCapRound: true,
                                      dotData: FlDotData(
                                        show: touchedIndex >= 0,
                                        checkToShowDot: (spot, barData) {
                                          // Only show dot at the touched index
                                          return spot.x.toInt() == touchedIndex;
                                        },
                                        getDotPainter:
                                            (spot, percent, barData, index) {
                                              // Show small dot only on hovered point
                                              if (index == touchedIndex) {
                                                return FlDotCirclePainter(
                                                  radius: 3,
                                                  color: Colors.white,
                                                  strokeWidth: 1.5,
                                                  strokeColor: const Color(
                                                    0xFF4F9EF8,
                                                  ),
                                                );
                                              }
                                              return FlDotCirclePainter(
                                                radius: 0,
                                                color: Colors.transparent,
                                              );
                                            },
                                      ),
                                      belowBarData: BarAreaData(show: false),
                                      preventCurveOverShooting: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Tooltip overlay - using reusable CustomChartTooltip
                            if (touchedIndex >= 0 &&
                                touchedIndex < chartData.length &&
                                cursorPosition != null)
                              CustomChartTooltip(
                                cursorPosition: cursorPosition,
                                headerText:
                                    chartData[touchedIndex]['month'] as String,
                                items: _buildTooltipItems(
                                  chartData[touchedIndex],
                                  isDark,
                                ),
                                availableWidth: constraints.maxWidth,
                                availableHeight: 250,
                                rightPadding: constraints.maxWidth < 300
                                    ? 35
                                    : 45,
                                isVisible: true,
                              ),
                          ],
                        ),
                );
              },
            ),
            SizedBox(height: AppSpacing.xl),

            // Legend (responsive layout)
            LayoutBuilder(
              builder: (context, constraints) {
                // Use Wrap for narrow screens, Row for wider screens
                final useWrap = constraints.maxWidth < 250;

                final legendItems = <Widget>[];

                // Build legend items dynamically based on available labels
                if (firstBarLabel.isNotEmpty) {
                  legendItems.add(
                    _buildLegendItem(
                      color: AppColors.primary,
                      label: firstBarLabel,
                      isDark: isDark,
                      isLine: false,
                    ),
                  );
                }

                if (secondBarLabel.isNotEmpty) {
                  legendItems.add(
                    _buildLegendItem(
                      color: AppColors.grey500Light,
                      label: secondBarLabel,
                      isDark: isDark,
                      isLine: false,
                    ),
                  );
                }

                if (thirdBarLabel.isNotEmpty) {
                  legendItems.add(
                    _buildLegendItem(
                      color: AppColors.primaryAccentLight,
                      label: thirdBarLabel,
                      isDark: isDark,
                      isLine: false,
                    ),
                  );
                }

                if (lineLabel.isNotEmpty) {
                  legendItems.add(
                    _buildLegendItem(
                      color: const Color(0xFF4F9EF8),
                      label: lineLabel,
                      isDark: isDark,
                      isLine: true,
                    ),
                  );
                }

                // If no legend items, show "no data found"
                if (legendItems.isEmpty) {
                  legendItems.add(
                    Text(
                      'No data found',
                      style: AuroraTheme.legendTextStyle(isDark).copyWith(
                        color: AppColors.getTextSecondary(isDark),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  );
                }

                if (useWrap) {
                  return Wrap(
                    spacing: AppSpacing.md,
                    runSpacing: AppSpacing.ml,
                    children: legendItems,
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: legendItems
                        .map((item) => Expanded(child: item))
                        .toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return chartData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;

      // Responsive bar width (6px for narrow, 9px for normal)
      final barWidth = MediaQuery.of(context).size.width < 600 ? 6.0 : 9.0;

      // Support both old format (wins/losses) and new format (bars array)
      List<BarChartRodData> barRods;
      if (data.containsKey('bars')) {
        // New format with bars array
        final bars = data['bars'] as List;
        barRods = bars.map((bar) {
          final barMap = bar as Map<String, dynamic>;
          final value = (barMap['value'] as num?)?.toDouble() ?? 0;
          final colorInt = barMap['color'] as int? ?? 4278239141;
          return BarChartRodData(
            toY: value,
            color: Color(colorInt),
            width: barWidth,
            borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
          );
        }).toList();
      } else {
        // Old format with wins/losses/thirdBar (optional)
        final wins = (data['wins'] as num?)?.toDouble() ?? 0;
        final losses = (data['losses'] as num?)?.toDouble() ?? 0;
        final thirdBar = (data['thirdBar'] as num?)?.toDouble();

        barRods = [
          BarChartRodData(
            toY: wins,
            color: AppColors.primary,
            width: barWidth,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppConstants.radiusSmall),
              bottom: Radius.circular(0),
            ),
          ),
          BarChartRodData(
            toY: losses,
            color: AppColors.grey500Light,
            width: barWidth,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppConstants.radiusSmall),
              bottom: Radius.circular(0),
            ),
          ),
        ];

        // Add third bar if data exists
        if (thirdBar != null) {
          barRods.add(
            BarChartRodData(
              toY: thirdBar,
              color: AppColors.primaryAccentLight,
              width: barWidth,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppConstants.radiusSmall),
                bottom: Radius.circular(0),
              ),
            ),
          );
        }
      }

      return BarChartGroupData(
        x: index,
        barRods: barRods,
        barsSpace: AppSpacing.xs,
      );
    }).toList();
  }

  // Build smooth line spots for win rate trend
  List<FlSpot> _buildLineSpots() {
    if (chartData.isEmpty) return [];

    // Use the line value from data (new format) or winRate (old format)
    return chartData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      final lineValue = data.containsKey('line')
          ? (data['line'] as num?)?.toDouble() ?? 0
          : (data['winRate'] as num?)?.toDouble() ?? 0;

      return FlSpot(index.toDouble(), lineValue);
    }).toList();
  }

  // Helper method to build legend items
  Widget _buildLegendItem({
    required Color color,
    required String label,
    required bool isDark,
    required bool isLine,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AuroraTheme.legendIconSize,
          height: isLine ? 2 : AuroraTheme.legendIconSize,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              isLine ? 1 : AppConstants.radiusSmall,
            ),
          ),
        ),
        SizedBox(width: AppSpacing.sm),
        Flexible(
          child: Text(
            label,
            style: AuroraTheme.legendTextStyle(isDark),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Build tooltip items for CustomChartTooltip widget
  List<TooltipDataItem> _buildTooltipItems(
    Map<String, dynamic> data,
    bool isDark,
  ) {
    final wins = (data['wins'] as num?)?.toDouble() ?? 0;
    final losses = (data['losses'] as num?)?.toDouble() ?? 0;
    final thirdBar = (data['thirdBar'] as num?)?.toDouble();
    final winRate = (data['winRate'] as num?)?.toDouble() ?? 0;

    final tooltipItems = <TooltipDataItem>[];

    // Add tooltip items only for labels that are available
    if (firstBarLabel.isNotEmpty) {
      tooltipItems.add(
        TooltipDataItem(
          color: AppColors.primary,
          label: firstBarLabel,
          value: wins.toStringAsFixed(0),
        ),
      );
    }

    if (secondBarLabel.isNotEmpty) {
      tooltipItems.add(
        TooltipDataItem(
          color: AppColors.grey500Light,
          label: secondBarLabel,
          value: losses.toStringAsFixed(0),
        ),
      );
    }

    if (thirdBarLabel.isNotEmpty && thirdBar != null) {
      tooltipItems.add(
        TooltipDataItem(
          color: AppColors.primaryAccentLight,
          label: thirdBarLabel,
          value: thirdBar.toStringAsFixed(0),
        ),
      );
    }

    if (lineLabel.isNotEmpty) {
      tooltipItems.add(
        TooltipDataItem(
          color: const Color(0xFF4F9EF8),
          label: lineLabel,
          value: '${winRate.toStringAsFixed(1)}%',
        ),
      );
    }

    return tooltipItems;
  }
}
