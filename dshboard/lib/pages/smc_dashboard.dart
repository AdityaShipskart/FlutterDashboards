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
import 'package:responsive_grid/responsive_grid.dart';

class SmcDashboard extends StatefulWidget {
  const SmcDashboard({super.key});

  @override
  State<SmcDashboard> createState() => _SmcDashboardState();
}

class _SmcDashboardState extends State<SmcDashboard> {
  Map<String, dynamic>? contentData;
  List<Map<String, dynamic>>? cardsData;
  Map<String, dynamic>? areaChartData;
  Map<String, dynamic>? leadingPortsData;
  Map<String, dynamic>? leadingPortsData2;
  Map<String, dynamic>? leadingPortsData3;
  Map<String, dynamic>? combobarChartData;
  Map<String, dynamic>? pieChartData;
  Map<String, dynamic>? financialCardData;
  Map<String, dynamic>? barChartData;
  Map<String, dynamic>? comparisonData;
  Map<String, dynamic>? tableData;

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
    final String cardsResponse = await rootBundle.loadString(
      'assets/data/cards_data.json',
    );
    final cardsJson = json.decode(cardsResponse);
    final cards = List<Map<String, dynamic>>.from(
      (cardsJson['cards'] as List).map(
        (card) => Map<String, dynamic>.from(card),
      ),
    );

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

    // Load combobar chart data
    final String combobarChartResponse = await rootBundle.loadString(
      'assets/data/combobar_chart.json',
    );

    final combobarChart = json.decode(combobarChartResponse);

    // Load pie chart data
    final String pieChartResponse = await rootBundle.loadString(
      'assets/data/pie_chart.json',
    );

    final pieChart = json.decode(pieChartResponse);

    // Load financial card data
    final String financialCardResponse = await rootBundle.loadString(
      'assets/data/financial_data.json',
    );

    final financialCard = json.decode(financialCardResponse);

    // Load bar chart data
    final String barChartResponse = await rootBundle.loadString(
      'assets/data/bar_chart.json',
    );

    final barChart = json.decode(barChartResponse);

    // Load comparison data
    final String comparisonResponse = await rootBundle.loadString(
      'assets/data/comparison_data.json',
    );

    final comparison = json.decode(comparisonResponse);

    // Load table data
    final String tableResponse = await rootBundle.loadString(
      'assets/data/top_performance_table_data.json',
    );

    final table = json.decode(tableResponse);

    setState(() {
      contentData = data;
      cardsData = cards;
      areaChartData = areaChart;
      leadingPortsData = Map<String, dynamic>.from(leadingPorts);
      leadingPortsData2 = Map<String, dynamic>.from(leadingPorts);
      leadingPortsData3 = Map<String, dynamic>.from(leadingPorts);
      combobarChartData = combobarChart;
      pieChartData = pieChart;
      financialCardData = financialCard;
      barChartData = barChart;
      comparisonData = comparison;
      tableData = table;

      leadingPortsData2!['title'] = 'Top Exporting Ports';
      leadingPortsData2!['subtitle'] = 'Summary of your top exporting ports';

      leadingPortsData3!['title'] = 'Top Importing Ports';
      leadingPortsData3!['subtitle'] = 'Summary of your top importing ports';
    });
  }

  @override
  Widget build(BuildContext context) {
    return cardsData != null &&
            areaChartData != null &&
            leadingPortsData != null &&
            combobarChartData != null &&
            pieChartData != null &&
            financialCardData != null &&
            barChartData != null &&
            comparisonData != null &&
            tableData != null
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
                    ResponsiveGridRow(
                      rowSegments: 12,
                      children: [
                        ResponsiveGridCol(
                          xs: 12,
                          md: 8,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16.0,
                              right: 8.0,
                            ),
                            child: DashboardCardContainer(
                              cards: cardsData!,
                              contentData: contentData,
                              contentKey: "child_dashboard",
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          xs: 12,
                          md: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16.0,
                              left: 8.0,
                            ),
                            child: DashboardRecentData(),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 28),
                    ResponsiveGridRow(
                      children: [
                        ResponsiveGridCol(
                          xs: 12,
                          md: 6,
                          lg: 6,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16.0,
                              right: 8.0,
                            ),
                            child: RevenueGeneratedCard(
                              chartData: areaChartData!,
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          xs: 12,
                          md: 6,
                          lg: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16.0,
                              left: 4.0,
                              right: 4.0,
                            ),
                            child: DashboardPieChart(chartData: pieChartData!),
                          ),
                        ),
                        ResponsiveGridCol(
                          xs: 12,
                          md: 6,
                          lg: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16.0,
                              left: 8.0,
                            ),
                            child: DashboardFinancialCard(
                              chartData: financialCardData!,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    const SizedBox(height: 12),
                    ResponsiveGridRow(
                      children: [
                        ResponsiveGridCol(
                          xs: 12,
                          md: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16.0,
                              right: 8.0,
                            ),
                            child: DashboardFinancialCard(
                              chartData: financialCardData!,
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          xs: 12,
                          md: 8,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16.0,
                              left: 8.0,
                            ),
                            child: DashboardBarChart(chartData: barChartData!),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    const SizedBox(height: 12),
                    ResponsiveGridRow(
                      children: [
                        ResponsiveGridCol(
                          xs: 12,
                          md: 6,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16.0,
                              right: 8.0,
                            ),
                            child: DashboardcombobarChart(
                              chartData: combobarChartData!,
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          xs: 12,
                          md: 6,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16.0,
                              left: 8.0,
                            ),
                            child: MultiAnalyticsOveriview(
                              chartData: comparisonData!,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Performance Table Section
                    const SizedBox(height: 12),
                    DashboardTable(chartData: tableData!),

                    // Multi Table Section
                    const SizedBox(height: 24),

                    ResponsiveGridRow(
                      children: [
                        ResponsiveGridCol(
                          xs: 12,
                          md: 6,
                          lg: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16.0,
                              right: 8.0,
                            ),
                            child: DashboardLeadingPort(
                              data: leadingPortsData!,
                              minWidth: 350,
                              expandToAvailableWidth: true,
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          xs: 12,
                          md: 6,
                          lg: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16.0,
                              left: 4.0,
                              right: 4.0,
                            ),
                            child: DashboardLeadingPort(
                              data: leadingPortsData2!,
                              minWidth: 350,
                              expandToAvailableWidth: true,
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          xs: 12,
                          md: 6,
                          lg: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16.0,
                              left: 8.0,
                            ),
                            child: DashboardLeadingPort(
                              data: leadingPortsData3!,
                              minWidth: 350,
                              expandToAvailableWidth: true,
                            ),
                          ),
                        ),
                      ],
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
          );
  }
}
