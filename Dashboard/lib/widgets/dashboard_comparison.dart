import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';

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
        children: [
          // Header with title and subtitle
          if (!isLoading && tabsData.isNotEmpty) _buildHeader(isDark),

          const SizedBox(height: 32.0),

          // Legend
          if (!isLoading && tabsData.isNotEmpty) _buildLegend(),

          const SizedBox(height: 24.0),

          // Chart Area
          if (isLoading)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(48.0),
                child: CircularProgressIndicator(
                  color: const Color(0xFF1379F0),
                ),
              ),
            )
          else if (errorMessage != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(48.0),
                child: Text(
                  errorMessage!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                    height: 22 / 14,
                    letterSpacing: 0.25,
                    color: const Color(0xFFEF4444),
                  ),
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
                tab['subtitle'] ?? '',
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
          color: isDark ? const Color(0xFFB5B7C8) : const Color(0xFF757575),
          size: 24,
        ),
      ],
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildLegendItem('Approval', const Color(0xFF5B8FF7), false),
        const SizedBox(width: 24.0),
        _buildLegendItem('Delayed', const Color(0xFF10B981), true),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color, bool isDashed) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 3,
          decoration: BoxDecoration(
            color: isDashed ? Colors.transparent : color,
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: isDashed
              ? CustomPaint(painter: DashedLinePainter(color: color))
              : null,
        ),
        const SizedBox(width: 12.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
            height: 22 / 14,
            letterSpacing: 0.25,
            color: Color(0xFF676A72),
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

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: SizedBox(
        key: ValueKey(selectedTabIndex),
        height: 260,
        child: Padding(
          padding: const EdgeInsets.only(right: 12.0, top: 16.0, bottom: 8.0),
          child: LineChart(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: maxY / 4,
                getDrawingHorizontalLine: (value) {
                  return const FlLine(color: Color(0xFFEEEEEE), strokeWidth: 1);
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
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              _formatYAxisLabel(value),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Inter',
                                color: Color(0xFF676A72),
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
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
                border: const Border(
                  top: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                  bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
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
                  color: const Color(0xFF5B8FF7),
                  barWidth: 2.5,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF5B8FF7).withValues(alpha: 0.25),
                        const Color(0xFF5B8FF7).withValues(alpha: 0.12),
                        const Color(0xFF5B8FF7).withValues(alpha: 0.05),
                        const Color(0xFF5B8FF7).withValues(alpha: 0.01),
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
                  color: const Color(0xFF10B981),
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
                  tooltipPadding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 12.0,
                  ),
                  tooltipMargin: 8.0,
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
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  height: 1.6,
                                ),
                              ),
                              // On-time line (label and value on same line)
                              if (actualSpot != null) ...[
                                const TextSpan(
                                  text: '● ',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Inter',
                                    color: Color(0xFF5B8FF7),
                                    height: 1.8,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'Approved  ${_formatTooltipValue(actualSpot.y)}\n',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                    height: 1.8,
                                  ),
                                ),
                              ],
                              // Delayed line (label and value on same line)
                              if (projectedSpot != null) ...[
                                const TextSpan(
                                  text: '● ',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Inter',
                                    color: Color(0xFF10B981),
                                    height: 1.8,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'Delayed  ${_formatTooltipValue(projectedSpot.y)}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                    height: 1.8,
                                  ),
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
