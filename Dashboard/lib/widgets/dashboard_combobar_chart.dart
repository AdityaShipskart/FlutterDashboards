import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'common/custom_tooltip.dart';

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

  // Inline constants
  static const double _spacingLg = 24.0;
  static const double _spacingXl = 32.0;
  static const double _spacingXs = 4.0;
  static const double _radiusLarge = 12.0;
  static const Color _primary = Color(0xFF1379F0);
  static const Color _shadowLight = Color(0x0F000000);

  static Color _getCard(bool isDark) =>
      isDark ? const Color(0xFF1A1A1A) : Colors.white;
  static Color _getTextPrimary(bool isDark) =>
      isDark ? Colors.white : const Color(0xFF212121);
  static Color _getTextSecondary(bool isDark) =>
      isDark ? const Color(0xFFB5B7C8) : const Color(0xFF757575);
  static Color _getGreyScale(int level, bool isDark) {
    if (isDark) {
      return level >= 600 ? const Color(0xFF808290) : const Color(0xFF363843);
    }
    return level >= 600 ? const Color(0xFF8E9198) : const Color(0xFFEEEEEE);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(_spacingLg),
      decoration: BoxDecoration(
        color: _getCard(isDark),
        borderRadius: BorderRadius.circular(_radiusLarge),
        boxShadow: const [
          BoxShadow(color: _shadowLight, blurRadius: 10, offset: Offset(0, 2)),
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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: _getTextPrimary(isDark),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: _spacingXs),
                    Text(
                      cardSubtitle,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _getTextSecondary(isDark),
                      ),
                    ),
                  ],
                ),
              ),
              // Three dots menu icon
              Icon(
                Icons.more_horiz,
                color: _getTextSecondary(isDark),
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: _spacingLg),

          // Bar Chart with Line (responsive height)
          LayoutBuilder(
            builder: (context, constraints) {
              // Calculate responsive chart height based on card width
              final chartHeight = constraints.maxWidth > 300 ? 250.0 : 200.0;

              return SizedBox(
                height: chartHeight,
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: _primary),
                      )
                    : Stack(
                        clipBehavior: Clip.none, // Allow tooltip to overflow
                        children: [
                          // Bar Chart (bars only)
                          BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              // Chart range - dynamic from .NET backend
                              // TODO: Backend provides minY, maxY values
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
                                    reservedSize: constraints.maxWidth < 300
                                        ? 35
                                        : 45,
                                    getTitlesWidget: (value, meta) {
                                      // Y-axis labels - FULLY DYNAMIC from .NET backend
                                      // TODO: .NET backend returns array "yAxisLabels" with format:
                                      // [{"value": 0, "label": "0k"}, {"value": 5000, "label": "5k"}, ...]

                                      final textStyle = TextStyle(
                                        fontSize: constraints.maxWidth < 300
                                            ? 10
                                            : 11,
                                        color: _getGreyScale(600, isDark),
                                      );

                                      // Find matching label for this value from backend data
                                      for (var labelConfig in yAxisLabels) {
                                        if (labelConfig['value'] == value) {
                                          return Text(
                                            labelConfig['label'],
                                            style: textStyle,
                                          );
                                        }
                                      }

                                      // No label for this value
                                      return const Text('');
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
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
                                    color: _getGreyScale(200, isDark),
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
                                              lineTouchResponse.lineBarSpots ==
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
          const SizedBox(height: _spacingXl),

          // Legend (responsive layout)
          LayoutBuilder(
            builder: (context, constraints) {
              // Use Wrap for narrow screens, Row for wider screens
              final useWrap = constraints.maxWidth < 350;

              final legendItems = [
                // Wins
                _buildLegendItem(
                  color: const Color(0xFF8AB4F8),
                  label: 'Wins',
                  isDark: isDark,
                  isLine: false,
                ),
                // Losses
                _buildLegendItem(
                  color: const Color(0xFFDBE6EB),
                  label: 'Losses',
                  isDark: isDark,
                  isLine: false,
                ),
                // Win Rate
                _buildLegendItem(
                  color: const Color(0xFF4F9EF8),
                  label: 'Win Rate',
                  isDark: isDark,
                  isLine: true,
                ),
              ];

              if (useWrap) {
                return Wrap(spacing: 16, runSpacing: 12, children: legendItems);
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
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return chartData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;

      // Responsive bar width (8px for narrow, 12px for normal)
      final barWidth = MediaQuery.of(context).size.width < 600 ? 8.0 : 12.0;

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
            borderRadius: BorderRadius.circular(4),
          );
        }).toList();
      } else {
        // Old format with wins/losses
        final wins = (data['wins'] as num?)?.toDouble() ?? 0;
        final losses = (data['losses'] as num?)?.toDouble() ?? 0;
        barRods = [
          BarChartRodData(
            toY: wins,
            color: const Color(0xFF8AB4F8),
            width: barWidth,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(4),
              bottom: Radius.circular(0),
            ),
          ),
          BarChartRodData(
            toY: losses,
            color: const Color(0xFFDBE6EB),
            width: barWidth,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(4),
              bottom: Radius.circular(0),
            ),
          ),
        ];
      }

      return BarChartGroupData(x: index, barRods: barRods, barsSpace: 4);
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
          width: 12,
          height: isLine ? 2 : 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(isLine ? 1 : 2),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _getTextSecondary(isDark),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Build tooltip items for CustomChartTooltip widget
  // Prepares data items to display in the tooltip
  List<TooltipDataItem> _buildTooltipItems(
    Map<String, dynamic> data,
    bool isDark,
  ) {
    final wins = (data['wins'] as num).toDouble();
    final losses = (data['losses'] as num).toDouble();
    final winRate = (data['winRate'] as num).toDouble();

    return [
      // Wins value
      TooltipDataItem(
        color: const Color(0xFF8AB4F8),
        label: 'Wins',
        value: wins.toStringAsFixed(0),
      ),
      // Losses value
      TooltipDataItem(
        color: const Color(0xFFDBE6EB),
        label: 'Losses',
        value: losses.toStringAsFixed(0),
      ),
      // Win Rate value
      TooltipDataItem(
        color: const Color(0xFF4F9EF8),
        label: 'Win Rate',
        value: '${winRate.toStringAsFixed(1)}%',
      ),
    ];
  }
}
