import 'package:flutter/material.dart';
import 'package:flutte_design_application/widgets/dashboard_financial_card.dart';
import 'package:flutte_design_application/widgets/dashboard_line_chart.dart';
import 'package:flutte_design_application/widgets/dashboard_pie_chart.dart';
import 'package:flutte_design_application/widgets/dashboard_recent_data.dart';

class Vendor extends StatelessWidget {
  const Vendor({super.key});

  // Dashboard widget data - embedded directly
  static final Map<String, dynamic> dashboardWidgetData = {
    'recentActivity': {
      'title': 'All time sales',
      'totalValue': 295700,
      'currency': 'USD',
      'percentageChange': 2.7,
      'isPositive': true,
      'products': [
        {'name': 'Total sales', 'percentage': 54, 'color': 4278239141},
        {'name': 'Quotes Submitted', 'percentage': 19, 'color': 4294198070},
        {'name': 'Orders', 'percentage': 27, 'color': 4288586312},
      ],
      'channels': [
        {'id': 'products_sold', 'name': 'Products sold', 'icon': 'shopping_cart_outlined', 'value': 172000, 'percentageChange': 3.9, 'isPositive': true},
        {'id': 'active_products', 'name': 'Active Products', 'icon': 'inventory_2_outlined', 'value': 85000, 'percentageChange': 0.7, 'isPositive': false},
        {'id': 'quotations_submitted', 'name': 'Quotations Submitted', 'icon': 'description_outlined', 'value': 36000, 'percentageChange': 8.2, 'isPositive': true},
        {'id': 'order_received', 'name': 'Order Received', 'icon': 'local_shipping_outlined', 'value': 26000, 'percentageChange': 8.2, 'isPositive': true},
        {'id': 'order_delays', 'name': 'Order Delays', 'icon': 'schedule_outlined', 'value': 7000, 'percentageChange': 0.7, 'isPositive': false},
      ],
    },
    'lineChart': {
      'cardTitle': 'Revenue Trends',
      'cardSubtitle': 'Monitor financial growth over time',
      'thisYearLabel': '2025',
      'lastYearLabel': '2024',
      'percentageChange': '+12.5%',
      'isPositiveChange': true,
      'chartConfig': {'minX': 0, 'maxX': 11, 'minY': 0, 'maxY': 8},
      'thisYearData': [
        {'x': 0, 'y': 2.5}, {'x': 1, 'y': 3.2}, {'x': 2, 'y': 2.8}, {'x': 3, 'y': 4.1},
        {'x': 4, 'y': 5.5}, {'x': 5, 'y': 4.8}, {'x': 6, 'y': 6.2}, {'x': 7, 'y': 7.1},
        {'x': 8, 'y': 6.8}, {'x': 9, 'y': 7.5}, {'x': 10, 'y': 7.2}, {'x': 11, 'y': 8.0},
      ],
      'lastYearData': [
        {'x': 0, 'y': 2.0}, {'x': 1, 'y': 2.8}, {'x': 2, 'y': 2.5}, {'x': 3, 'y': 3.5},
        {'x': 4, 'y': 4.2}, {'x': 5, 'y': 3.8}, {'x': 6, 'y': 4.5}, {'x': 7, 'y': 5.2},
        {'x': 8, 'y': 4.8}, {'x': 9, 'y': 5.5}, {'x': 10, 'y': 5.8}, {'x': 11, 'y': 6.2},
      ],
      'labels': ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
    },
    'pieChart': {
      'cardTitle': 'Lead Sources',
      'cardSubtitle': 'Ratio of generated leads',
      'totalLeads': '2847',
      'pieChartData': [
        {'label': 'Direct', 'value': 45, 'color': 4278239141},
        {'label': 'Referral', 'value': 30, 'color': 4294198070},
        {'label': 'Social', 'value': 25, 'color': 4288586312},
      ],
    },
    'financialCard': {
      'title': 'Financial Overview',
      'items': [
        {'label': 'Total Revenue', 'value': '\$485,200', 'trend': '+12.5%', 'isPositive': true},
        {'label': 'Expenses', 'value': '\$125,000', 'trend': '-5.2%', 'isPositive': true},
        {'label': 'Net Profit', 'value': '\$360,200', 'trend': '+18.3%', 'isPositive': true},
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
            DashboardRecentData(data: dashboardWidgetData['recentActivity']),
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
