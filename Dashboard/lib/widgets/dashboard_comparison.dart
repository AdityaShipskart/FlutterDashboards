import 'dart:convert';
import 'dart:math' as math;
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
        'values': [
          [
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
          [
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
  static const List<Color> _fallbackSeriesColors = [
    Color(0xFF5B8FF7),
    Color(0xFF10B981),
    Color(0xFFF97316),
    Color(0xFF7C3AED),
    Color(0xFFEC4899),
  ];

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

    final tab = tabsData[selectedTabIndex];

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
            _parseColorValue(legendData[i]['color'], i),
            (legendData[i]['isDashed'] as bool?) ?? false,
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

    final currentTab = tabsData[selectedTabIndex];
    final valuesData = currentTab['values'] as List<dynamic>?;

    if (valuesData == null || valuesData.isEmpty) {
      return const SizedBox.shrink();
    }

    final seriesData = valuesData
        .map(
          (series) => List<double>.from(
            (series as List).map((e) => (e as num).toDouble()),
          ),
        )
        .toList();

    final legendData = currentTab['legend'] as List<dynamic>?;
    final seriesMeta = _buildSeriesMeta(
      legendData,
      seriesData.length,
      _fallbackSeriesColors,
    );
    final seriesLabels = seriesMeta.labels;
    final seriesColors = seriesMeta.colors;
    final seriesDashed = seriesMeta.isDashed;

    final maxSeriesLength = seriesData.fold<int>(
      0,
      (previousValue, series) =>
          series.length > previousValue ? series.length : previousValue,
    );

    if (maxSeriesLength == 0) {
      return const SizedBox.shrink();
    }

    final maxY = _resolveMaxY(currentTab, seriesData);
    final double horizontalInterval = maxY > 0 ? maxY / 4 : 1.0;

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
                horizontalInterval: horizontalInterval,
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
                    interval: horizontalInterval,
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
              maxX: math.max(0, maxSeriesLength - 1).toDouble(),
              minY: 0,
              maxY: maxY,
              lineBarsData: seriesData.asMap().entries.map((entry) {
                final seriesIndex = entry.key;
                final color = seriesColors[seriesIndex];
                final isDashed = seriesDashed[seriesIndex];

                return LineChartBarData(
                  spots: entry.value
                      .asMap()
                      .entries
                      .map((point) => FlSpot(point.key.toDouble(), point.value))
                      .toList(),
                  isCurved: true,
                  curveSmoothness: 0.3,
                  preventCurveOverShooting: true,
                  preventCurveOvershootingThreshold: 10,
                  color: color,
                  barWidth: 2.5,
                  isStrokeCapRound: true,
                  dashArray: isDashed ? const [6, 4] : null,
                  dotData: const FlDotData(show: false),
                  belowBarData: seriesIndex == 0
                      ? BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              color.withValues(alpha: 0.25),
                              color.withValues(alpha: 0.12),
                              color.withValues(alpha: 0.05),
                              color.withValues(alpha: 0.01),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 0.3, 0.7, 1.0],
                          ),
                        )
                      : BarAreaData(show: false),
                );
              }).toList(),
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
                    if (touchedBarSpots.isEmpty) {
                      return const <LineTooltipItem>[];
                    }

                    final xIndex = touchedBarSpots.first.x.toInt();
                    final dateLabel = _getDateLabel(xIndex);

                    final Map<int, LineBarSpot> spotsByBarIndex = {};
                    for (final spot in touchedBarSpots) {
                      spotsByBarIndex[spot.barIndex] = spot;
                    }

                    final List<TextSpan> spans = [
                      TextSpan(
                        text: '$dateLabel\n',
                        style: AppTextStyles.b11Medium(
                          isDark: true,
                        ).copyWith(color: Colors.white, height: 1.6),
                      ),
                    ];

                    for (int i = 0; i < seriesLabels.length; i++) {
                      final seriesSpot = spotsByBarIndex[i];
                      if (seriesSpot == null) continue;

                      spans.add(
                        TextSpan(
                          text: '● ',
                          style: AppTextStyles.b10(
                            isDark: true,
                          ).copyWith(color: seriesColors[i], height: 1.8),
                        ),
                      );
                      spans.add(
                        TextSpan(
                          text:
                              '${seriesLabels[i]}  ${_formatTooltipValue(seriesSpot.y)}\n',
                          style: AppTextStyles.b11(
                            isDark: true,
                          ).copyWith(color: Colors.white, height: 1.8),
                        ),
                      );
                    }

                    if (spans.length > 1) {
                      final lastSpan = spans.last;
                      if (lastSpan.text != null &&
                          lastSpan.text!.endsWith('\n')) {
                        spans[spans.length - 1] = TextSpan(
                          text: lastSpan.text!.substring(
                            0,
                            lastSpan.text!.length - 1,
                          ),
                          style: lastSpan.style,
                        );
                      }
                    }

                    final tooltipItems = <LineTooltipItem?>[];
                    for (int i = 0; i < touchedBarSpots.length; i++) {
                      if (i == 0) {
                        tooltipItems.add(
                          LineTooltipItem(
                            '',
                            const TextStyle(color: Colors.transparent),
                            textAlign: TextAlign.left,
                            children: spans,
                          ),
                        );
                      } else {
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

  Color _parseColorValue(dynamic value, int fallbackIndex) {
    if (value is int) {
      return Color(value);
    }
    if (value is String) {
      try {
        return Color(int.parse(value));
      } catch (_) {
        final sanitized = value.toUpperCase().replaceFirst('0X', '');
        try {
          return Color(int.parse('0x$sanitized'));
        } catch (_) {
          // Ignore and fall back
        }
      }
    }
    return _fallbackSeriesColors[fallbackIndex % _fallbackSeriesColors.length];
  }

  _SeriesMeta _buildSeriesMeta(
    List<dynamic>? legendData,
    int seriesCount,
    List<Color> fallbackColors,
  ) {
    final labels = <String>[];
    final colors = <Color>[];
    final dashed = <bool>[];

    for (int i = 0; i < seriesCount; i++) {
      if (legendData != null && i < legendData.length) {
        final entry = legendData[i] as Map<String, dynamic>;
        labels.add(entry['label'] as String? ?? 'Series ${i + 1}');
        colors.add(_parseColorValue(entry['color'], i));
        dashed.add((entry['isDashed'] as bool?) ?? false);
      } else {
        labels.add('Series ${i + 1}');
        colors.add(fallbackColors[i % fallbackColors.length]);
        dashed.add(false);
      }
    }

    return _SeriesMeta(labels: labels, colors: colors, isDashed: dashed);
  }

  double _resolveMaxY(Map<String, dynamic> tab, List<List<double>> seriesData) {
    final providedMaxY = tab['maxY'];
    if (providedMaxY != null) {
      return (providedMaxY as num).toDouble();
    }

    double maxValue = 0;
    for (final series in seriesData) {
      for (final value in series) {
        if (value > maxValue) {
          maxValue = value;
        }
      }
    }

    if (maxValue == 0) {
      return 10;
    }

    return maxValue * 1.1;
  }
}

class _SeriesMeta {
  const _SeriesMeta({
    required this.labels,
    required this.colors,
    required this.isDashed,
  });

  final List<String> labels;
  final List<Color> colors;
  final List<bool> isDashed;
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
