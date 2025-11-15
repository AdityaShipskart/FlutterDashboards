import 'package:flutter/material.dart';
import 'package:flutte_design_application/widgets/dashboard_line_chart.dart';
import 'package:flutte_design_application/widgets/dashboard_pie_chart.dart';
import 'package:flutte_design_application/widgets/dashboard_recent_data.dart';
import 'package:flutte_design_application/widgets/dashboard_financial_card.dart';

class Catalogue extends StatelessWidget {
  const Catalogue({super.key});

  // Dashboard widget data - embedded directly
  static final Map<String, dynamic> dashboardWidgetData = {
    'recentActivity': {
      'title': 'Total Revenue',
      'totalValue': 485200,
      'currency': 'USD',
      'percentageChange': 12.5,
      'isPositive': true,
      'products': [
        {'name': 'Premium', 'percentage': 65, 'color': 4280368368},
        {'name': 'Standard', 'percentage': 25, 'color': 4294963492},
        {'name': 'Basic', 'percentage': 10, 'color': 4285221776},
      ],
      'channels': [
        {'id': 'subscription', 'name': 'Subscriptions', 'icon': 'card_membership_outlined', 'value': 315000, 'percentageChange': 15.2, 'isPositive': true},
        {'id': 'one_time', 'name': 'One-time Sales', 'icon': 'shopping_cart_outlined', 'value': 125000, 'percentageChange': 5.8, 'isPositive': true},
        {'id': 'consulting', 'name': 'Consulting', 'icon': 'business_center_outlined', 'value': 32000, 'percentageChange': 22.3, 'isPositive': true},
        {'id': 'support', 'name': 'Support Plans', 'icon': 'support_agent_outlined', 'value': 13200, 'percentageChange': 3.5, 'isPositive': false},
      ],
    },
    'lineChart': {
      'cardTitle': 'Product Sales Trends',
      'cardSubtitle': 'Track product performance over time',
      'thisYearLabel': '2025',
      'lastYearLabel': '2024',
      'percentageChange': '+15.8%',
      'isPositiveChange': true,
      'chartConfig': {'minX': 0, 'maxX': 11, 'minY': 0, 'maxY': 10},
      'thisYearData': [
        {'x': 0, 'y': 3.5}, {'x': 1, 'y': 4.2}, {'x': 2, 'y': 3.8}, {'x': 3, 'y': 5.1},
        {'x': 4, 'y': 6.5}, {'x': 5, 'y': 5.8}, {'x': 6, 'y': 7.2}, {'x': 7, 'y': 8.1},
        {'x': 8, 'y': 7.8}, {'x': 9, 'y': 8.5}, {'x': 10, 'y': 8.2}, {'x': 11, 'y': 9.0},
      ],
      'lastYearData': [
        {'x': 0, 'y': 2.5}, {'x': 1, 'y': 3.2}, {'x': 2, 'y': 2.8}, {'x': 3, 'y': 4.1},
        {'x': 4, 'y': 5.2}, {'x': 5, 'y': 4.8}, {'x': 6, 'y': 5.5}, {'x': 7, 'y': 6.2},
        {'x': 8, 'y': 5.8}, {'x': 9, 'y': 6.5}, {'x': 10, 'y': 6.8}, {'x': 11, 'y': 7.2},
      ],
      'labels': ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
    },
    'pieChart': {
      'cardTitle': 'Product Categories',
      'cardSubtitle': 'Distribution by category',
      'totalLeads': '5,247',
      'pieChartData': [
        {'label': 'Electronics', 'value': 40, 'color': 4280368368},
        {'label': 'Clothing', 'value': 35, 'color': 4294963492},
        {'label': 'Home & Garden', 'value': 25, 'color': 4285221776},
      ],
    },
    'financialCard': {
      'title': 'Catalogue Metrics',
      'items': [
        {'label': 'Total Products', 'value': '1,247', 'trend': '+8.3%', 'isPositive': true},
        {'label': 'Active SKUs', 'value': '985', 'trend': '+12.1%', 'isPositive': true},
        {'label': 'Out of Stock', 'value': '23', 'trend': '-15.4%', 'isPositive': true},
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
            DashboardRecentData(data: dashboardWidgetData['recentActivity'], type: 'revenue'),
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
          ],
        ),
      ),
    );
  }
}