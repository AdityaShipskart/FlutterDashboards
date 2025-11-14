import 'package:flutte_design_application/widgets/dashboard_bar_chart.dart';
import 'package:flutte_design_application/widgets/dashboard_combobar_chart.dart';
import 'package:flutte_design_application/widgets/dashboard_comparison.dart';
import 'package:flutte_design_application/widgets/dashboard_financial_card.dart';
import 'package:flutte_design_application/widgets/dashboard_leading_port.dart';
import 'package:flutte_design_application/widgets/dashboard_line_chart.dart';
import 'package:flutte_design_application/widgets/dashboard_pie_chart.dart';
import 'package:flutte_design_application/widgets/dashboard_recent_data.dart';
import 'package:flutte_design_application/widgets/dashboard_table.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutte_design_application/widgets/dashboard_card_container.dart';
import 'package:flutte_design_application/services/card_data_service.dart';

class VendorDashboard extends StatefulWidget {
  const VendorDashboard({super.key});

  @override
  State<VendorDashboard> createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  Map<String, dynamic>? contentData;
  List<Map<String, dynamic>>? cardsData;
  Map<String, dynamic>? areaChartData;
  Map<String, dynamic>? leadingPortsData;
  Map<String, dynamic>? leadingPortsData2;
  Map<String, dynamic>? leadingPortsData3;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    // Load dashboard content
    final String response = await rootBundle.loadString(
      'assets/data/dashboard_content.json',
    );
    final data = json.decode(response);

    // Load cards data
    final cards = await CardDataService.loadCardsData();

    // Load area chart data
    final String areaChartResponse = await rootBundle.loadString(
      'assets/data/line_chart.json',
    );

    final areaChart = json.decode(areaChartResponse);

    // Load leading ports data
    final String leadingPortsResponse = await rootBundle.loadString(
      'assets/data/leading_ports_data.json',
    );

    final leadingPorts = json.decode(leadingPortsResponse);

    setState(() {
      contentData = data;
      cardsData = cards;
      areaChartData = areaChart;
      leadingPortsData = Map<String, dynamic>.from(leadingPorts);
      leadingPortsData2 = Map<String, dynamic>.from(leadingPorts);
      leadingPortsData3 = Map<String, dynamic>.from(leadingPorts);

      leadingPortsData2!['title'] = 'Top Exporting Ports';
      leadingPortsData2!['subtitle'] = 'Summary of your top exporting ports';

      leadingPortsData3!['title'] = 'Top Importing Ports';
      leadingPortsData3!['subtitle'] = 'Summary of your top importing ports';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    var dashboard_section_1 = [
      Expanded(
        flex: 7,
        child: DashboardCardContainer(
          cards: cardsData!,
          contentData: contentData,
          contentKey: "child_dashboard",
        ),
      ),
      const SizedBox(width: 16),
      Expanded(flex: 3, child: DashboardRecentData()),
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        title: Text(
          'Vendor Dashboard',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        centerTitle: false,
      ),
      body:
          cardsData != null && areaChartData != null && leadingPortsData != null
          ? RefreshIndicator(
              onRefresh: loadData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First Row - Dashboard Cards and Recent Data
                      Row(children: dashboard_section_1),

                      SizedBox(height: 28),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isMobile = constraints.maxWidth < 768;

                          if (isMobile) {
                            // Stack vertically on mobile
                            return Column(
                              children: [
                                RevenueGeneratedCard(chartData: areaChartData!),
                                const SizedBox(height: 20),
                                DashboardPieChart(
                                  jsonFilePath: 'assets/data/pie_chart.json',
                                ),
                              ],
                            );
                          } else {
                            // Side by side on larger screens
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Revenue chart - 65% width
                                Expanded(
                                  flex: 35,
                                  child: RevenueGeneratedCard(
                                    chartData: areaChartData!,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                // Pie chart - 35% width
                                Expanded(
                                  flex: 25,
                                  child: DashboardPieChart(
                                    jsonFilePath: 'assets/data/pie_chart.json',
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  flex: 25,
                                  child: DashboardFinancialCard(
                                    jsonFilePath:
                                        "assets/data/financial_data.json",
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 28),

                      const SizedBox(height: 12),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isMobile = constraints.maxWidth < 768;

                          if (isMobile) {
                            // Stack vertically on mobile
                            return Column(
                              children: [
                                DashboardFinancialCard(
                                  jsonFilePath:
                                      "assets/data/financial_data.json",
                                ),
                                const SizedBox(height: 20),
                                DashboardBarChart(
                                  jsonFilePath: 'assets/data/bar_chart.json',
                                ),
                              ],
                            );
                          } else {
                            // Side by side on larger screens
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Financial card - 30% width
                                Expanded(
                                  flex: 30,
                                  child: DashboardFinancialCard(
                                    jsonFilePath:
                                        "assets/data/financial_data.json",
                                  ),
                                ),
                                const SizedBox(width: 20),
                                // Bar chart - 70% width
                                Expanded(
                                  flex: 70,
                                  child: DashboardBarChart(
                                    jsonFilePath: 'assets/data/bar_chart.json',
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 28),

                      const SizedBox(height: 12),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isMobile = constraints.maxWidth < 768;

                          if (isMobile) {
                            // Stack vertically on mobile
                            return Column(
                              children: [
                                DashboardcombobarChart(
                                  jsonFilePath:
                                      'assets/data/combobar_chart.json',
                                ),
                                const SizedBox(height: 20),
                                MultiAnalyticsOveriview(
                                  jsonFilePath:
                                      'assets/data/comparison_data.json',
                                ),
                              ],
                            );
                          } else {
                            // Side by side on larger screens - 50/50 split
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Combo bar chart - 50% width
                                Expanded(
                                  flex: 50,
                                  child: DashboardcombobarChart(
                                    jsonFilePath:
                                        'assets/data/combobar_chart.json',
                                  ),
                                ),
                                const SizedBox(width: 20),
                                // Comparison chart - 50% width
                                Expanded(
                                  flex: 50,
                                  child: MultiAnalyticsOveriview(
                                    jsonFilePath:
                                        'assets/data/comparison_data.json',
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 28),

                      // Performance Table Section
                      const SizedBox(height: 12),
                      DashboardTable(
                        jsonFilePath:
                            'assets/data/top_performance_table_data.json',
                      ),

                      // Multi Table Section
                      const SizedBox(height: 24),

                      LayoutBuilder(
                        builder: (context, constraints) {
                          const double gap = 16;
                          final double availableWidth =
                              constraints.hasBoundedWidth &&
                                  constraints.maxWidth.isFinite
                              ? constraints.maxWidth
                              : MediaQuery.of(context).size.width;

                          // Responsive column count
                          final int columns = availableWidth < 768
                              ? 1
                              : availableWidth < 1200
                              ? 2
                              : 3;

                          final double totalGap = columns > 1
                              ? gap * (columns - 1)
                              : 0;
                          final double itemWidth =
                              (availableWidth - totalGap) / columns;

                          return Wrap(
                            spacing: gap,
                            runSpacing: gap,
                            children: [
                              SizedBox(
                                width: itemWidth,
                                child: DashboardLeadingPort(
                                  data: leadingPortsData!,
                                  minWidth: itemWidth,
                                  expandToAvailableWidth: false,
                                ),
                              ),
                              SizedBox(
                                width: itemWidth,
                                child: DashboardLeadingPort(
                                  data: leadingPortsData2!,
                                  minWidth: itemWidth,
                                  expandToAvailableWidth: false,
                                ),
                              ),
                              SizedBox(
                                width: itemWidth,
                                child: DashboardLeadingPort(
                                  data: leadingPortsData3!,
                                  minWidth: itemWidth,
                                  expandToAvailableWidth: false,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Loading dashboard data...',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
    );
  }
}
