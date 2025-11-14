import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import '../const/constant.dart';
import 'common/custom_tooltip.dart';

class DashboardPieChart extends StatefulWidget {
  final String jsonFilePath;

  const DashboardPieChart({super.key, required this.jsonFilePath});

  @override
  State<DashboardPieChart> createState() => _DashboardPieChartState();
}

class _DashboardPieChartState extends State<DashboardPieChart> {
  // ============ ALL DYNAMIC DATA FROM .NET BACKEND ============

  // Card content - all dynamic from backend
  String cardTitle = ''; // e.g., "Lead Sources"
  String cardSubtitle = ''; // e.g., "Ratio of generated leads"
  String totalLeads = ''; // e.g., "2847"

  // Pie chart data - comes from backend API
  List<PieChartSectionData> pieChartSections = [];

  // Legend data - comes from backend API
  List<LeadSourceItem> legendItems = [];

  // Tooltip data - stores label and value for each section
  List<Map<String, dynamic>> tooltipData = [];

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
    _loadLeadSourcesData();
  }

  // Method to load lead sources data from JSON file
  // TODO: In future, replace JSON file loading with actual .NET API call using http package
  Future<void> _loadLeadSourcesData() async {
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
      //      Uri.parse('https://your-dotnet-api.com/api/lead-sources/dashboard'),
      //      headers: {'Authorization': 'Bearer YOUR_TOKEN'},
      //    );
      //    final data = json.decode(response.body);
      final String jsonString = await rootBundle.loadString(
        widget.jsonFilePath,
      );
      final data = json.decode(jsonString);

      if (!mounted) return;

      setState(() {
        // Card content
        cardTitle = data['cardTitle'] ?? 'Lead Sources';
        cardSubtitle = data['cardSubtitle'] ?? '';
        totalLeads = data['totalLeads'] ?? '0';

        // Store tooltip data (label + value for each section)
        tooltipData = List<Map<String, dynamic>>.from(
          data['pieChartData'] ?? [],
        );

        // Convert pie chart data from JSON format to PieChartSectionData
        // Pass touchedIndex to enable hover scaling effect
        pieChartSections = _convertToPieChartData(
          data['pieChartData'] ?? [],
          touchedIndex: touchedIndex,
        );

        // Convert legend data from JSON format
        legendItems = _convertToLegendItems(data['legendData'] ?? []);

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
      child: SingleChildScrollView(
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
                        cardTitle, // Dynamic from API
                        style: AuroraTheme.cardTitleStyle(isDark),
                      ),
                      AuroraTheme.smallVerticalSpacing(),
                      Text(
                        cardSubtitle, // Dynamic from API
                        style: AuroraTheme.cardSubtitleStyle(isDark),
                      ),
                    ],
                  ),
                ),
                // Three dots menu icon
                AuroraTheme.cardMenuIcon(isDark),
              ],
            ),
            AuroraTheme.cardHeaderSpacing(),
            const SizedBox(
              height: 48,
            ), // Additional space between title and chart
            // Donut Chart with center text (wrapped in outer Stack for external tooltip)
            Center(
              child: Stack(
                clipBehavior:
                    Clip.none, // Allow tooltip to overflow chart container
                children: [
                  // Chart container
                  SizedBox(
                    height: 200, // Reduced from 220
                    width: 200, // Reduced from 220
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          )
                        : Stack(
                            children: [
                              // Pie Chart (bottom layer)
                              Center(
                                child: SizedBox(
                                  height: 180, // Reduced from 200
                                  width: 180, // Reduced from 200
                                  child: PieChart(
                                    PieChartData(
                                      sectionsSpace: 4, // Gap between sections
                                      centerSpaceRadius:
                                          58, // Reduced donut hole size proportionally
                                      startDegreeOffset: -90, // Start from top
                                      sections: pieChartSections,
                                      pieTouchData: PieTouchData(
                                        enabled: true,
                                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                          setState(() {
                                            if (!event
                                                    .isInterestedForInteractions ||
                                                pieTouchResponse == null ||
                                                pieTouchResponse
                                                        .touchedSection ==
                                                    null) {
                                              touchedIndex = -1;
                                              cursorPosition = null;
                                              // Rebuild sections without hover effect
                                              pieChartSections =
                                                  _convertToPieChartData(
                                                    tooltipData,
                                                    touchedIndex: -1,
                                                  );
                                              return;
                                            }
                                            touchedIndex = pieTouchResponse
                                                .touchedSection!
                                                .touchedSectionIndex;

                                            // Capture cursor position for tooltip placement
                                            if (event is FlPointerHoverEvent ||
                                                event is FlPanUpdateEvent ||
                                                event is FlTapUpEvent) {
                                              cursorPosition =
                                                  event.localPosition;
                                            }

                                            // Rebuild sections with hover effect on touched section
                                            pieChartSections =
                                                _convertToPieChartData(
                                                  tooltipData,
                                                  touchedIndex: touchedIndex,
                                                );
                                          });
                                        },
                                      ),
                                      borderData: FlBorderData(show: false),
                                    ),
                                  ),
                                ),
                              ),
                              // Center text (middle layer)
                              Center(
                                child: Text(
                                  totalLeads, // Dynamic from API
                                  style: TextStyle(
                                    fontSize: 28, // Reduced from 36
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.getTextPrimary(isDark),
                                    height: 1.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                  // Tooltip overlay - using reusable CustomChartTooltip
                  if (touchedIndex >= 0 &&
                      touchedIndex < tooltipData.length &&
                      !isLoading &&
                      cursorPosition != null)
                    CustomChartTooltip(
                      cursorPosition: Offset(
                        cursorPosition!.dx + 10,
                        cursorPosition!.dy + 10,
                      ), // Add chart offset
                      items: _buildTooltipItems(tooltipData[touchedIndex]),
                      availableWidth: 220,
                      availableHeight: 220,
                      isVisible: true,
                    ),
                ],
              ),
            ),
            AuroraTheme.legendChartSpacing(),

            const SizedBox(height: 58),
            // Legend with flex layout (horizontal items, each with column structure)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: legendItems.map((item) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Label on top
                        Text(
                          item.label, // Dynamic from API
                          style: AppTextStyles.b12(isDark: isDark).copyWith(
                            color: AppColors.getGreyScale(600, isDark),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Color bar below (full width within this flex item)
                        Container(
                          width: double.infinity,
                          height: 4,
                          decoration: BoxDecoration(
                            color: item.color,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Build tooltip items for CustomChartTooltip widget
  // Prepares data items to display in the tooltip
  List<TooltipDataItem> _buildTooltipItems(Map<String, dynamic> data) {
    final label = data['label'] as String;
    final value = (data['value'] as double).toInt();

    // Get color from data
    final colorValue = int.parse(data['color'] as String);
    final sectionColor = Color(colorValue);

    return [
      TooltipDataItem(
        color: sectionColor,
        label: label,
        value: value.toString(),
      ),
    ];
  }

  /// Converts JSON pie chart data to fl_chart PieChartSectionData format
  /// Can accept optional touchedIndex to scale the hovered section
  List<PieChartSectionData> _convertToPieChartData(
    List<dynamic> pieData, {
    int touchedIndex = -1,
  }) {
    return pieData.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      final colorValue = int.parse(item['color'] as String);
      final isTouched = index == touchedIndex;

      return PieChartSectionData(
        color: Color(colorValue),
        value: item['value'] as double,
        title: '', // No text on sections - we use center text instead
        radius: isTouched ? 85 : 75, // Scale up on hover
        titleStyle: const TextStyle(fontSize: 0), // Hide section text
        badgeWidget: null,
        borderSide: BorderSide.none,
      );
    }).toList();
  }

  /// Converts JSON legend data to LeadSourceItem format
  List<LeadSourceItem> _convertToLegendItems(List<dynamic> legendData) {
    return legendData.map((item) {
      final colorValue = int.parse(item['color'] as String);
      return LeadSourceItem(
        label: item['label'] as String,
        color: Color(colorValue),
      );
    }).toList();
  }
}

// Model class for legend items
class LeadSourceItem {
  final String label;
  final Color color;

  LeadSourceItem({required this.label, required this.color});
}
