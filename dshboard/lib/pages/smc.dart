import 'package:flutter/material.dart';
import 'package:flutte_design_application/widgets/dashboard_comparison.dart';
import 'package:flutte_design_application/widgets/dashboard_line_chart.dart';
import 'package:flutte_design_application/widgets/dashboard_pie_chart.dart';
import 'package:flutte_design_application/widgets/dashboard_recent_data.dart';
import 'package:flutte_design_application/widgets/dashboard_financial_card.dart';

class Smc extends StatelessWidget {
  const Smc({super.key});

  // Dashboard widget data - embedded directly
  static final Map<String, dynamic> dashboardWidgetData = {
    'recentActivity': {
      'title': 'Active Customers',
      'totalValue': 12847,
      'currency': null,
      'percentageChange': 18.3,
      'isPositive': true,
      'products': [
        {'name': 'Enterprise', 'percentage': 15, 'color': 4283413750},
        {'name': 'Business', 'percentage': 35, 'color': 4280368368},
        {'name': 'Individual', 'percentage': 50, 'color': 4278234241},
      ],
      'channels': [
        {'id': 'new_customers', 'name': 'New Customers', 'icon': 'person_add_outlined', 'value': 1247, 'percentageChange': 25.4, 'isPositive': true},
        {'id': 'returning', 'name': 'Returning', 'icon': 'replay_outlined', 'value': 8532, 'percentageChange': 12.1, 'isPositive': true},
        {'id': 'vip', 'name': 'VIP Members', 'icon': 'stars_outlined', 'value': 2147, 'percentageChange': 8.7, 'isPositive': true},
        {'id': 'trial', 'name': 'Trial Users', 'icon': 'timer_outlined', 'value': 921, 'percentageChange': 3.2, 'isPositive': false},
      ],
    },
    'lineChart': {
      'cardTitle': 'Customer Growth',
      'cardSubtitle': 'Track customer acquisition trends',
      'thisYearLabel': '2025',
      'lastYearLabel': '2024',
      'percentageChange': '+22.3%',
      'isPositiveChange': true,
      'chartConfig': {'minX': 0, 'maxX': 11, 'minY': 0, 'maxY': 12},
      'thisYearData': [
        {'x': 0, 'y': 4.5}, {'x': 1, 'y': 5.2}, {'x': 2, 'y': 5.8}, {'x': 3, 'y': 6.5},
        {'x': 4, 'y': 7.5}, {'x': 5, 'y': 7.8}, {'x': 6, 'y': 8.5}, {'x': 7, 'y': 9.2},
        {'x': 8, 'y': 9.8}, {'x': 9, 'y': 10.5}, {'x': 10, 'y': 11.0}, {'x': 11, 'y': 11.5},
      ],
      'lastYearData': [
        {'x': 0, 'y': 3.0}, {'x': 1, 'y': 3.5}, {'x': 2, 'y': 4.0}, {'x': 3, 'y': 4.5},
        {'x': 4, 'y': 5.2}, {'x': 5, 'y': 5.8}, {'x': 6, 'y': 6.5}, {'x': 7, 'y': 7.0},
        {'x': 8, 'y': 7.5}, {'x': 9, 'y': 8.0}, {'x': 10, 'y': 8.5}, {'x': 11, 'y': 9.0},
      ],
      'labels': ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
    },
    'pieChart': {
      'cardTitle': 'Customer Segments',
      'cardSubtitle': 'Distribution by segment',
      'totalLeads': '12,847',
      'pieChartData': [
        {'label': 'New', 'value': 30, 'color': 4278234241},
        {'label': 'Returning', 'value': 50, 'color': 4280368368},
        {'label': 'Inactive', 'value': 20, 'color': 4285221776},
      ],
    },
    'financialCard': {
      'title': 'Supply Chain Metrics',
      'items': [
        {'label': 'Active Shipments', 'value': '342', 'trend': '+5.2%', 'isPositive': true},
        {'label': 'On-Time Delivery', 'value': '94.5%', 'trend': '+2.1%', 'isPositive': true},
        {'label': 'Pending Orders', 'value': '87', 'trend': '-8.3%', 'isPositive': true},
      ],
    },
    'comparison': {
      'title': 'Performance Comparison',
      'subtitle': 'Compare metrics across periods',
      'metrics': [
        {'label': 'Q1 2025', 'value': 85, 'color': 4278234241},
        {'label': 'Q2 2025', 'value': 92, 'color': 4280368368},
        {'label': 'Q3 2025', 'value': 88, 'color': 4288586312},
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Recent Activity
            DashboardRecentData(data: dashboardWidgetData['recentActivity'], type: 'customers'),
            const SizedBox(height: 28),
            
            // Section 2: Line Chart, Pie Chart, Financial Card
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 768;
                if (isMobile) {
                  return Column(
                    children: [
                      RevenueGeneratedCard(chartData: dashboardWidgetData['lineChart']),
                      const SizedBox(height: 20),
                      DashboardPieChart(data: dashboardWidgetData['pieChart']),
                      const SizedBox(height: 20),
                      DashboardFinancialCard(data: dashboardWidgetData['financialCard']),
                    ],
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 35, child: RevenueGeneratedCard(chartData: dashboardWidgetData['lineChart'])),
                    const SizedBox(width: 20),
                    Expanded(flex: 25, child: DashboardPieChart(data: dashboardWidgetData['pieChart'])),
                    const SizedBox(width: 20),
                    Expanded(flex: 20, child: DashboardFinancialCard(data: dashboardWidgetData['financialCard'])),
                  ],
                );
              },
            ),
            const SizedBox(height: 28),
            
            // Section 3: Comparison Widget
            MultiAnalyticsOveriview(data: dashboardWidgetData['comparison']),
          ],
        ),
      ),
    );
  }
}