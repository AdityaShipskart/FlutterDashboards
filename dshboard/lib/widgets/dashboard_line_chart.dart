import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/line_dataset.dart';

class RevenueGeneratedCard extends StatefulWidget {
  final Map<String, dynamic>? chartData;

  /// Example data for demo purposes
  static final Map<String, dynamic> exampleData = {
    'cardTitle': 'Revenue Generated',
    'cardSubtitle': 'Amount of revenue in this month compared to last year',
    'thisYearLabel': '2025',
    'lastYearLabel': '2024',
    'percentageChange': '+6.19%',
    'isPositiveChange': true,
    'availablePeriods': ['Jan-Jun', 'Jul-Dec', 'Full Year'],
    'selectedPeriod': 'Full Year',
    'chartConfig': {'minX': 0, 'maxX': 11, 'minY': 2, 'maxY': 7},
    'thisYearData': [
      {'x': 0, 'y': 3.5},
      {'x': 1, 'y': 3.8},
      {'x': 2, 'y': 4.2},
      {'x': 3, 'y': 4.5},
      {'x': 4, 'y': 5.0},
      {'x': 5, 'y': 5.5},
      {'x': 6, 'y': 5.2},
      {'x': 7, 'y': 5.8},
      {'x': 8, 'y': 6.0},
      {'x': 9, 'y': 6.3},
      {'x': 10, 'y': 6.5},
      {'x': 11, 'y': 6.8},
    ],
    'lastYearData': [
      {'x': 0, 'y': 3.0},
      {'x': 1, 'y': 3.2},
      {'x': 2, 'y': 3.5},
      {'x': 3, 'y': 3.8},
      {'x': 4, 'y': 4.2},
      {'x': 5, 'y': 4.5},
      {'x': 6, 'y': 4.3},
      {'x': 7, 'y': 4.8},
      {'x': 8, 'y': 5.0},
      {'x': 9, 'y': 5.3},
      {'x': 10, 'y': 5.5},
      {'x': 11, 'y': 5.8},
    ],
    'labels': [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ],
  };

  const RevenueGeneratedCard({super.key, this.chartData});

  @override
  State<RevenueGeneratedCard> createState() => _RevenueGeneratedCardState();
}

class _RevenueGeneratedCardState extends State<RevenueGeneratedCard> {
  // ============ ALL DYNAMIC DATA FROM .NET BACKEND ============

  // Period selection - comes from backend
  String selectedPeriod = 'Full Year';
  List<String> availablePeriods = []; // Will be populated from API

  // Static periods (commented - replace with API data)
  // final List<String> staticPeriods = ['Last month', 'Last quarter', 'Last year'];

  // ============================================
  // DYNAMIC DATASETS - Supports N number of lines
  // ============================================
  // This list can contain 2, 3, 4, or more datasets
  // Each dataset represents one line on the chart
  List<LineDataset> datasets = [];
  List<String> labels = [];

  // Card content - all dynamic from backend
  String cardTitle = ''; // e.g., "Revenue Generated"
  String cardSubtitle = ''; // e.g., "Amount of revenue in this month..."
  String percentageChange = ''; // e.g., "+6.19%"
  bool isPositiveChange = true; // true for positive, false for negative

  // Chart configuration - comes from backend
  double minX = 0;
  double maxX = 14;
  double minY = 2;
  double maxY = 7;

  // Loading state
  bool isLoading = true;
  String? errorMessage;

  // Original data to filter from
  Map<String, dynamic>? originalData;

  @override
  void initState() {
    super.initState();
    _loadRevenueData();
  }

  // Method to filter data based on selected period
  Map<String, dynamic> _getFilteredData(String period) {
    if (originalData == null)
      return widget.chartData ?? RevenueGeneratedCard.exampleData;

    final filteredData = Map<String, dynamic>.from(originalData!);

    // Filter data based on period
    List<Map<String, dynamic>> thisYearData = List<Map<String, dynamic>>.from(
      originalData!['thisYearData'] ?? [],
    );
    List<Map<String, dynamic>> lastYearData = List<Map<String, dynamic>>.from(
      originalData!['lastYearData'] ?? [],
    );
    List<String> allLabels = List<String>.from(originalData!['labels'] ?? []);

    List<Map<String, dynamic>> filteredThisYear = [];
    List<Map<String, dynamic>> filteredLastYear = [];
    List<String> filteredLabels = [];

    if (period == 'Jan-Jun') {
      // First 6 months (indices 0-5)
      filteredThisYear = thisYearData
          .where((item) => (item['x'] as int) <= 5)
          .toList();
      filteredLastYear = lastYearData
          .where((item) => (item['x'] as int) <= 5)
          .toList();
      filteredLabels = allLabels.sublist(0, 6);

      // Adjust chart config for first half
      filteredData['chartConfig'] = {
        'minX': 0,
        'maxX': 5,
        'minY': 0,
        'maxY': 8,
      };
    } else if (period == 'Jul-Dec') {
      // Last 6 months (indices 6-11)
      filteredThisYear = thisYearData
          .where((item) => (item['x'] as int) >= 6)
          .map(
            (item) => {
              'x': (item['x'] as int) - 6, // Adjust x to start from 0
              'y': item['y'],
            },
          )
          .toList();
      filteredLastYear = lastYearData
          .where((item) => (item['x'] as int) >= 6)
          .map(
            (item) => {
              'x': (item['x'] as int) - 6, // Adjust x to start from 0
              'y': item['y'],
            },
          )
          .toList();
      filteredLabels = allLabels.sublist(6, 12);

      // Adjust chart config for second half
      filteredData['chartConfig'] = {
        'minX': 0,
        'maxX': 5,
        'minY': 0,
        'maxY': 8,
      };
    } else {
      // Full Year - use all data
      filteredThisYear = thisYearData;
      filteredLastYear = lastYearData;
      filteredLabels = allLabels;
    }

    filteredData['thisYearData'] = filteredThisYear;
    filteredData['lastYearData'] = filteredLastYear;
    filteredData['labels'] = filteredLabels;

    return filteredData;
  }

  // Method to load revenue data from passed parameters
  Future<void> _loadRevenueData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Store original data on first load
      originalData ??= widget.chartData ?? RevenueGeneratedCard.exampleData;

      // Get filtered data based on selected period
      final Map<String, dynamic> data = _getFilteredData(selectedPeriod);

      // ============================================
      // FUTURE: .NET API Integration (COMMENTED OUT)
      // ============================================
      // TODO: Replace above with this API call:
      //
      // final response = await http.get(
      //   Uri.parse('https://your-api.com/api/revenue/dashboard?period=$selectedPeriod&year=${DateTime.now().year}'),
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'Authorization': 'Bearer YOUR_API_TOKEN',
      //   },
      // );
      //
      // if (response.statusCode == 200) {
      //   final data = json.decode(response.body) as Map<String, dynamic>;
      //
      //   // Expected API Response Format: (See dummy_revenue_data.dart)
      //   // {
      //   //   "cardTitle": "Revenue Generated",
      //   //   "cardSubtitle": "Comparison with Last Year",
      //   //   "thisYearLabel": "2025",
      //   //   "lastYearLabel": "2024",
      //   //   "percentageChange": "+6.19%",
      //   //   "isPositiveChange": true,
      //   //   "availablePeriods": ["Jan-Jun", "Jul-Dec", "Full Year"],
      //   //   "selectedPeriod": "Full Year",
      //   //   "chartConfig": { "minX": 0, "maxX": 11, "minY": 2, "maxY": 7 },
      //   //   "thisYearData": [ {"x": 0, "y": 3.5}, ... ],
      //   //   "lastYearData": [ {"x": 0, "y": 3.0}, ... ],
      //   //   "labels": ["Jan", "Feb", "Mar", ...]
      //   // }
      // } else {
      //   throw Exception('Failed to load data: ${response.statusCode}');
      // }

      if (!mounted) return;

      setState(() {
        // Card content
        cardTitle = data['cardTitle'] ?? 'Revenue Generated';
        cardSubtitle = data['cardSubtitle'] ?? '';
        percentageChange = data['percentageChange'] ?? '+0.00%';
        isPositiveChange = data['isPositiveChange'] ?? true;

        // Period options
        availablePeriods = List<String>.from(data['availablePeriods'] ?? []);
        selectedPeriod = data['selectedPeriod'] ?? selectedPeriod;

        // ============================================
        // DYNAMIC DATASETS - Load N number of lines
        // ============================================
        // Create LineDataset objects from thisYearData and lastYearData
        final thisYearDataRaw = List<Map<String, dynamic>>.from(
          data['thisYearData'] ?? [],
        );
        final lastYearDataRaw = List<Map<String, dynamic>>.from(
          data['lastYearData'] ?? [],
        );

        datasets = [];

        // Add this year dataset
        if (thisYearDataRaw.isNotEmpty) {
          datasets.add(
            LineDataset(
              label: data['thisYearLabel'] ?? '2025',
              data: thisYearDataRaw
                  .map(
                    (point) => FlSpot(
                      (point['x'] as num).toDouble(),
                      (point['y'] as num).toDouble(),
                    ),
                  )
                  .toList(),
              color: const Color(0xFF1379F0),
              strokeWidth: 3.0,
              showDots: true,
            ),
          );
        }

        // Add last year dataset
        if (lastYearDataRaw.isNotEmpty) {
          datasets.add(
            LineDataset(
              label: data['lastYearLabel'] ?? '2024',
              data: lastYearDataRaw
                  .map(
                    (point) => FlSpot(
                      (point['x'] as num).toDouble(),
                      (point['y'] as num).toDouble(),
                    ),
                  )
                  .toList(),
              color: const Color(0xFF8E9198),
              strokeWidth: 3.0,
              showDots: true,
            ),
          );
        }

        labels = List<String>.from(data['labels'] ?? []);

        // Chart configuration
        final chartConfig = data['chartConfig'] ?? {};
        minX = (chartConfig['minX'] as num?)?.toDouble() ?? 0;
        maxX = (chartConfig['maxX'] as num?)?.toDouble() ?? 11;
        minY = (chartConfig['minY'] as num?)?.toDouble() ?? 2;
        maxY = (chartConfig['maxY'] as num?)?.toDouble() ?? 7;

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

    return Material(
      color: Colors.transparent,
      child: Container(
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
            // Header
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
                const SizedBox(width: 16.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF141419)
                        : const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: DropdownButton<String>(
                    value: selectedPeriod,
                    underline: const SizedBox(),
                    isDense: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 18,
                      color: isDark
                          ? const Color(0xFFFFFFFF)
                          : const Color(0xFF212121),
                    ),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                      height: 20 / 13,
                      letterSpacing: 0,
                      color: isDark
                          ? const Color(0xFFFFFFFF)
                          : const Color(0xFF212121),
                    ),
                    items: availablePeriods.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedPeriod = newValue;
                        });
                        // Reload data with filtered period
                        _loadRevenueData();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32.0),

            // ============================================
            // DYNAMIC LEGEND - All items in horizontal Row with 4px gap (display: flex)
            // ============================================
            Row(
              children: [
                // Legend items with 4px gap
                ...datasets.asMap().entries.expand(
                  (entry) => [
                    _buildLegendItem(
                      entry.value.label,
                      entry.value.color,
                      isDark,
                    ),
                    SizedBox(width: 14), // 4px gap
                  ],
                ),
                // Percentage change with 4px gap
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
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
                    percentageChange.isEmpty
                        ? '+0.00%'
                        : percentageChange, // Dynamic from API
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
              ],
            ),
            const SizedBox(height: 32.0),

            // Chart with elevated tooltip
            SizedBox(
              height: 300,
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: const Color(0xFF1379F0),
                      ),
                    )
                  : datasets.isEmpty
                  ? Center(
                      child: Text(
                        'No data available',
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
                    )
                  : Stack(
                      clipBehavior: Clip.none,
                      children: [
                        LineChart(
                          LineChartData(
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: true,
                              horizontalInterval: 1,
                              verticalInterval: 1,
                              getDrawingHorizontalLine: (value) {
                                return FlLine(
                                  color: isDark
                                      ? const Color(0xFF141419)
                                      : const Color(0xFFF4F4F4),
                                  strokeWidth: 1,
                                );
                              },
                              getDrawingVerticalLine: (value) {
                                return FlLine(
                                  color: isDark
                                      ? const Color(0xFF141419)
                                      : const Color(0xFFF4F4F4),
                                  strokeWidth: 1,
                                );
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
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 30,
                                  interval: 1,
                                  getTitlesWidget:
                                      (double value, TitleMeta meta) {
                                        // Show all month labels (Jan-Dec)
                                        if (value.toInt() >= 0 &&
                                            value.toInt() < labels.length) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                            ),
                                            child: Text(
                                              labels[value.toInt()],
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Inter',
                                                height: 12 / 11,
                                                letterSpacing: 0.5,
                                                color: isDark
                                                    ? const Color(0xFFB5B7C8)
                                                    : const Color(0xFF757575),
                                              ),
                                            ),
                                          );
                                        }
                                        return const Text('');
                                      },
                                ),
                              ),
                              leftTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            minX: minX, // Dynamic from API
                            maxX: maxX, // Dynamic from API
                            minY: minY, // Dynamic from API
                            maxY: maxY, // Dynamic from API
                            // ============================================
                            // DYNAMIC LINE BARS - Generate from datasets
                            // ============================================
                            lineBarsData: datasets.map((dataset) {
                              return LineChartBarData(
                                spots: dataset.data,
                                isCurved: true,
                                color: dataset.color,
                                barWidth: dataset.strokeWidth,
                                isStrokeCapRound: true,
                                dotData: FlDotData(
                                  show: dataset.showDots,
                                  getDotPainter:
                                      (spot, percent, barData, index) {
                                        return FlDotCirclePainter(
                                          radius: 4,
                                          color: dataset.color,
                                          strokeWidth: 2,
                                          strokeColor: Colors.white,
                                        );
                                      },
                                ),
                                belowBarData: BarAreaData(show: false),
                              );
                            }).toList(),
                            lineTouchData: LineTouchData(
                              touchTooltipData: LineTouchTooltipData(
                                tooltipBgColor: const Color(0xFF2C2D30),
                                tooltipRoundedRadius: 4.0,
                                tooltipPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 7,
                                ),
                                tooltipMargin: 8,
                                tooltipBorder: BorderSide(
                                  color: const Color(
                                    0xFF393B40,
                                  ).withValues(alpha: 0.3),
                                  width: 1,
                                ),
                                maxContentWidth: 200,
                                fitInsideHorizontally: true,
                                fitInsideVertically: true,
                                getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                                  if (touchedBarSpots.isEmpty) return [];

                                  final index = touchedBarSpots.first.x.toInt();
                                  final date =
                                      index >= 0 && index < labels.length
                                      ? labels[index]
                                      : '';

                                  // Sort by barIndex (reverse order so latest appears first)
                                  final sortedSpots = touchedBarSpots.toList()
                                    ..sort(
                                      (a, b) =>
                                          b.barIndex.compareTo(a.barIndex),
                                    );

                                  return sortedSpots.map((barSpot) {
                                    // Get dataset info dynamically
                                    final dataset = datasets[barSpot.barIndex];
                                    final revenue = (barSpot.y * 50)
                                        .toStringAsFixed(1);
                                    final value = '${revenue}K';

                                    return LineTooltipItem(
                                      '',
                                      const TextStyle(
                                        color: Colors.white,
                                        height: 1.4,
                                      ),
                                      textAlign: TextAlign.left,
                                      children: [
                                        // Show date only once at the top (with last dataset)
                                        if (barSpot.barIndex ==
                                            datasets.length - 1) ...[
                                          TextSpan(
                                            text: '$date\n',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Inter',
                                              height: 2,
                                              letterSpacing: 0.4,
                                              color: Color(0xFFEEEEEE),
                                            ),
                                          ),
                                        ],
                                        TextSpan(
                                          text: '●  ',
                                          style: TextStyle(
                                            color: dataset.color,
                                            fontSize: 10,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '${dataset.label}    ',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: 'Inter',
                                            height: 12 / 11,
                                            letterSpacing: 0.5,
                                            color: Color(0xFFDCDDDE),
                                          ),
                                        ),
                                        TextSpan(
                                          text: value,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: 'Inter',
                                            height: 12 / 11,
                                            letterSpacing: 0.5,
                                            color: Color(0xFFDCDDDE),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList();
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, bool isDark) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: 'Inter',
            height: 22 / 14,
            letterSpacing: 0.25,
            color: isDark ? const Color(0xFFB5B7C8) : const Color(0xFF757575),
          ),
        ),
      ],
    );
  }
}
