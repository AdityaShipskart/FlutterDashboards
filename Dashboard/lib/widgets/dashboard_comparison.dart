import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import '../const/constant.dart';

class MultiAnalyticsOveriview extends StatefulWidget {
  final String? jsonFilePath;
  final Map<String, dynamic>? data;

  /// Example data for demo purposes
  static const Map<String, dynamic> exampleData = {
    'tabs': [
      {
        'label': 'Orders Overview',
        'subtitle': 'On-time vs Delayed comparison',
        'onTimeOrder': [
          20000,
          35000,
          45000,
          60000,
          50000,
          70000,
          65000,
          80000,
          75000,
          65000,
        ],
        'delayedOrder': [
          25000,
          30000,
          40000,
          55000,
          45000,
          65000,
          60000,
          75000,
          70000,
          60000,
        ],
        'maxY': 80000,
        'legend': [
          {'label': 'Approval', 'color': '0xFF5B8FF7', 'isDashed': false},
          {'label': 'Delayed', 'color': '0xFF10B981', 'isDashed': true},
        ],
      },
    ],
  };

  const MultiAnalyticsOveriview({super.key, this.jsonFilePath, this.data});

  @override
  State<MultiAnalyticsOveriview> createState() =>
      _MultiAnalyticsOveriviewState();
}

class _MultiAnalyticsOveriviewState extends State<MultiAnalyticsOveriview> {
  // Loading state
  bool isLoading = true;
  String? errorMessage;

  // All tabs data
  List<Map<String, dynamic>> tabsData = [];

  // Current selected tab index
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadAnalyticsData();
  }

  Future<void> _loadAnalyticsData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Use provided data if available, otherwise load from JSON file, or use example data
      final data =
          widget.data ??
          (widget.jsonFilePath != null
                  ? json.decode(
                      await rootBundle.loadString(widget.jsonFilePath!),
                    )
                  : MultiAnalyticsOveriview.exampleData)
              as Map<String, dynamic>;

      setState(() {
        tabsData = List<Map<String, dynamic>>.from(data['tabs']);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load data: $e';
        isLoading = false;
      });
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
          // Header with title and subtitle
          if (!isLoading && tabsData.isNotEmpty) _buildHeader(isDark),

          SizedBox(height: AppSpacing.xl),

          // Legend
          if (!isLoading && tabsData.isNotEmpty) _buildLegend(),

          SizedBox(height: AppSpacing.lg),

          // Chart Area
          if (isLoading)
            Center(
              child: Padding(
                padding: AppSpacing.paddingXL * 3,
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            )
          else if (errorMessage != null)
            Center(
              child: Padding(
                padding: AppSpacing.paddingXL * 3,
                child: Text(
                  errorMessage!,
                  style: AppTextStyles.b14(
                    isDark: isDark,
                  ).copyWith(color: AppColors.error),
                ),
              ),
            )
          else
            _buildChart(),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    if (tabsData.isEmpty) return const SizedBox.shrink();

    final tab = tabsData[0];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tab['label'] ?? '',
                style: AuroraTheme.cardTitleStyle(isDark),
              ),
              SizedBox(height: AppSpacing.xs),
              Text(
                tab['subtitle'] ?? '',
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
    );
  }

  Widget _buildLegend() {
    if (tabsData.isEmpty) return const SizedBox.shrink();

    final currentTab = tabsData[selectedTabIndex];
    final legendData = currentTab['legend'] as List<dynamic>?;

    if (legendData == null || legendData.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        for (int i = 0; i < legendData.length; i++) ...[
          _buildLegendItem(
            legendData[i]['label'] as String,
            Color(int.parse(legendData[i]['color'] as String)),
            legendData[i]['isDashed'] as bool,
          ),
          if (i < legendData.length - 1) SizedBox(width: AppSpacing.lg),
        ],
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color, bool isDashed) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppSpacing.xl,
          height: 3,
          decoration: BoxDecoration(
            color: isDashed ? Colors.transparent : color,
            borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
          ),
          child: isDashed
              ? CustomPaint(painter: DashedLinePainter(color: color))
              : null,
        ),
        SizedBox(width: AppSpacing.ml),
        Text(
          label,
          style: AppTextStyles.b14(isDark: false).copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.grey700Light,
          ),
        ),
      ],
    );
  }

  Widget _buildChart() {
    if (tabsData.isEmpty || selectedTabIndex >= tabsData.length) {
      return const SizedBox.shrink();
    }

    final currentTab = tabsData[0];
    final actualData = List<double>.from(
      (currentTab['onTimeOrder'] as List).map((e) => (e as num).toDouble()),
    );
    final projectedData = List<double>.from(
      (currentTab['delayedOrder'] as List).map((e) => (e as num).toDouble()),
    );
    final maxY = (currentTab['maxY'] as num).toDouble();

    // Get colors from legend data
    final legendData = currentTab['legend'] as List<dynamic>?;
    final approvalColor = legendData != null && legendData.isNotEmpty
        ? Color(int.parse(legendData[0]['color'] as String))
        : const Color(0xFF5B8FF7);
    final delayedColor = legendData != null && legendData.length > 1
        ? Color(int.parse(legendData[1]['color'] as String))
        : const Color(0xFF10B981);

    return AnimatedSwitcher(
      duration: AppAnimations.normal,
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: SizedBox(
        key: ValueKey(selectedTabIndex),
        height: AuroraTheme.mediumChartHeight,
        child: Padding(
          padding: EdgeInsets.only(
            right: AppSpacing.ml,
            top: AppSpacing.md,
            bottom: AppSpacing.sm,
          ),
          child: LineChart(
            duration: AppAnimations.normal,
            curve: Curves.easeInOut,
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: maxY / 4,
                getDrawingHorizontalLine: (value) {
                  return FlLine(color: AppColors.grey200Light, strokeWidth: 1);
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: maxY / 4,
                    getTitlesWidget: (value, meta) {
                      // Only show labels for 0, 20K, 40K, 60K, 80K (every other line)
                      if (value % (maxY / 4) == 0) {
                        return Transform.translate(
                          offset: const Offset(0, 0),
                          child: Padding(
                            padding: EdgeInsets.only(right: AppSpacing.sm),
                            child: Text(
                              _formatYAxisLabel(value),
                              style: AppTextStyles.b12(isDark: false).copyWith(
                                color: AppColors.grey700Light,
                                height: 1,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    reservedSize: 42,
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border(
                  top: BorderSide(color: AppColors.grey200Light, width: 1),
                  bottom: BorderSide(color: AppColors.grey200Light, width: 1),
                  left: BorderSide.none,
                  right: BorderSide.none,
                ),
              ),
              minX: 0,
              maxX: (actualData.length - 1).toDouble(),
              minY: 0,
              maxY: maxY,
              lineBarsData: [
                // Actual Value Line
                LineChartBarData(
                  spots: actualData.asMap().entries.map((entry) {
                    return FlSpot(entry.key.toDouble(), entry.value);
                  }).toList(),
                  isCurved: true,
                  curveSmoothness: 0.3,
                  preventCurveOverShooting: true,
                  preventCurveOvershootingThreshold: 10,
                  color: approvalColor,
                  barWidth: 2.5,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        approvalColor.withValues(alpha: 0.25),
                        approvalColor.withValues(alpha: 0.12),
                        approvalColor.withValues(alpha: 0.05),
                        approvalColor.withValues(alpha: 0.01),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.3, 0.7, 1.0],
                    ),
                  ),
                ),
                // Projected Value Line
                LineChartBarData(
                  spots: projectedData.asMap().entries.map((entry) {
                    return FlSpot(entry.key.toDouble(), entry.value);
                  }).toList(),
                  isCurved: true,
                  curveSmoothness: 0.3,
                  preventCurveOverShooting: true,
                  preventCurveOvershootingThreshold: 10,
                  color: delayedColor,
                  barWidth: 2.5,
                  isStrokeCapRound: true,
                  dashArray: [6, 4],
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
              lineTouchData: LineTouchData(
                enabled: true,
                touchTooltipData: LineTouchTooltipData(
                  tooltipPadding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.ml,
                    vertical: AppSpacing.ml,
                  ),
                  tooltipMargin: AppSpacing.sm,
                  fitInsideHorizontally: true,
                  fitInsideVertically: true,
                  maxContentWidth: 200,
                  getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                    // Get the date/label based on x position
                    final xIndex = touchedBarSpots.first.x.toInt();
                    final dateLabel = _getDateLabel(xIndex);

                    // Find actual and projected spots
                    LineBarSpot? actualSpot;
                    LineBarSpot? projectedSpot;

                    for (var spot in touchedBarSpots) {
                      if (spot.barIndex == 0) {
                        actualSpot = spot;
                      } else if (spot.barIndex == 1) {
                        projectedSpot = spot;
                      }
                    }

                    // Create a list with the exact same length as touchedBarSpots
                    final List<LineTooltipItem?> tooltipItems = [];

                    for (int i = 0; i < touchedBarSpots.length; i++) {
                      if (i == 0) {
                        // First item shows the full tooltip content
                        tooltipItems.add(
                          LineTooltipItem(
                            '',
                            const TextStyle(color: Colors.transparent),
                            textAlign: TextAlign.left,
                            children: [
                              // Date header on the left
                              TextSpan(
                                text: '$dateLabel\n',
                                style: AppTextStyles.b11Medium(
                                  isDark: true,
                                ).copyWith(color: Colors.white, height: 1.6),
                              ),
                              // On-time line (label and value on same line)
                              if (actualSpot != null) ...[
                                TextSpan(
                                  text: '● ',
                                  style: AppTextStyles.b10(
                                    isDark: true,
                                  ).copyWith(color: approvalColor, height: 1.8),
                                ),
                                TextSpan(
                                  text:
                                      'Approved  ${_formatTooltipValue(actualSpot.y)}\n',
                                  style: AppTextStyles.b11(
                                    isDark: true,
                                  ).copyWith(color: Colors.white, height: 1.8),
                                ),
                              ],
                              // Delayed line (label and value on same line)
                              if (projectedSpot != null) ...[
                                TextSpan(
                                  text: '● ',
                                  style: AppTextStyles.b10(
                                    isDark: true,
                                  ).copyWith(color: delayedColor, height: 1.8),
                                ),
                                TextSpan(
                                  text:
                                      'Delayed  ${_formatTooltipValue(projectedSpot.y)}',
                                  style: AppTextStyles.b11(
                                    isDark: true,
                                  ).copyWith(color: Colors.white, height: 1.8),
                                ),
                              ],
                            ],
                          ),
                        );
                      } else {
                        // Remaining items are transparent placeholders
                        tooltipItems.add(
                          const LineTooltipItem(
                            '',
                            TextStyle(
                              color: Colors.transparent,
                              fontSize: 0,
                              height: 0,
                            ),
                          ),
                        );
                      }
                    }

                    return tooltipItems;
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatYAxisLabel(double value) {
    // Simple formatting for On-time vs Delayed data
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(0)}K';
    }
    return value.toInt().toString();
  }

  String _formatTooltipValue(double value) {
    // Simple formatting for On-time vs Delayed data
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(0)}K';
    }
    return value.toInt().toString();
  }

  String _getDateLabel(int index) {
    // Generate date labels like "Oct 02", "Oct 03", etc.
    // For demo, use October with day based on index
    final day = (index % 31) + 1;
    return 'Oct ${day.toString().padLeft(2, '0')}';
  }
}

// Custom painter for dashed line in legend
class DashedLinePainter extends CustomPainter {
  final Color color;

  DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashWidth = 4;
    const dashSpace = 3;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
