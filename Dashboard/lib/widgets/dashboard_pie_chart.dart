import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
// import 'package:get/utils.dart';
import 'common/custom_tooltip.dart';
import '../const/constant.dart';

class DashboardPieChart extends StatefulWidget {
  final String? jsonFilePath;
  final Map<String, dynamic>? data;

  /// Example data for demo purposes
  static const Map<String, dynamic> exampleData = {
    'cardTitle': 'Lead Sources',
    'cardSubtitle': 'Ratio of generated leads',
    'totalLeads': '2847',
    'pieChartData': [
      {'label': 'Direct', 'value': 45.0, 'color': '0xFF1379F0'},
      {'label': 'Referral', 'value': 30.0, 'color': '0xFF10B981'},
      {'label': 'Social Media', 'value': 15.0, 'color': '0xFFFEC524'},
      {'label': 'Email', 'value': 10.0, 'color': '0xFFEF4444'},
    ],
    'legendData': [
      {'label': 'Direct', 'color': '0xFF1379F0'},
      {'label': 'Referral', 'color': '0xFF10B981'},
      {'label': 'Social Media', 'color': '0xFFFEC524'},
      {'label': 'Email', 'color': '0xFFEF4444'},
    ],
  };

  const DashboardPieChart({super.key, this.jsonFilePath, this.data});

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

  // Method to load lead sources data from JSON file or use provided data
  // TODO: In future, replace JSON file loading with actual .NET API call using http package
  Future<void> _loadLeadSourcesData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Use provided data if available, otherwise load from JSON file, or use example data
      final data =
          widget.data ??
          (widget.jsonFilePath != null
              ? json.decode(await rootBundle.loadString(widget.jsonFilePath!))
              : DashboardPieChart.exampleData);

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
      margin: EdgeInsets.all(AppSpacing.sm),
      padding: EdgeInsets.all(AppSpacing.md),

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
                      SizedBox(height: AppSpacing.xs),
                      Text(
                        cardSubtitle, // Dynamic from API
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
            SizedBox(height: AppSpacing.xxxl + 16),
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
                                  style: AppTextStyles.h24(isDark: isDark)
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                        height: 1.0,
                                        letterSpacing: 0.15,
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
            SizedBox(height: AppSpacing.xxl + 8),
            // Compact Legend with grid layout for maximum data display
            Padding(
              padding: EdgeInsets.all(AppSpacing.ml),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Calculate optimal grid layout based on available width
                  final availableWidth = constraints.maxWidth;

                  // Fixed grid layout: exactly 3 items per row for consistent display
                  final crossAxisCount = 3;

                  // Calculate item width for consistent sizing
                  final spacing = 8.0;
                  final totalSpacing = (crossAxisCount - 1) * spacing;
                  final itemWidth =
                      (availableWidth - totalSpacing) / crossAxisCount;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: 8,
                    children: legendItems.map((item) {
                      return SizedBox(
                        width: itemWidth,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Compact color indicator
                            Container(
                              width: AuroraTheme.legendIconSize,
                              height: AuroraTheme.legendIconSize,
                              decoration: BoxDecoration(
                                color: item.color,
                                borderRadius: BorderRadius.circular(
                                  AppConstants.radiusSmall,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: item.color.withValues(alpha: 0.4),
                                    blurRadius: 1,
                                    offset: const Offset(0, 0.5),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: AppSpacing.sd),
                            // Compact label
                            Expanded(
                              child: Text(
                                item.label,
                                style: AppTextStyles.b11Medium(
                                  isDark: isDark,
                                ).copyWith(height: 16 / 11, letterSpacing: 0.2),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
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
