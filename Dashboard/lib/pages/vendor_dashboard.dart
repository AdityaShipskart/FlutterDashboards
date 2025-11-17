import 'package:flutter/material.dart';
import '../widgets/dashboard_grid.dart';
import '../widgets/dashboard_card_container.dart';
import '../widgets/dashboard_recent_data.dart';
import '../widgets/dashboard_line_chart.dart';
import '../widgets/dashboard_pie_chart.dart';
import '../widgets/dashboard_financial_card.dart';
import '../widgets/dashboard_combobar_chart.dart';
import '../widgets/dashboard_comparison.dart';
import '../widgets/dashboard_bar_chart.dart';
import '../widgets/dashboard_leading_port.dart';

// Vendor-specific mock data to keep widgets relevant to this page
const List<Map<String, dynamic>> _vendorCards = [
  {
    'iconKey': 'revenue',
    'value': '41.28M',
    'label': 'Procurement Spend',
    'growth': '+6.2%',
    'color': Color(0xFF2563EB),
    'iconBgColor': Color(0xFFE0F2FE),
  },
  {
    'iconKey': 'users',
    'value': '312',
    'label': 'Active Vendors',
    'growth': '+3.4%',
    'color': Color(0xFF10B981),
    'iconBgColor': Color(0xFFD1FAE5),
  },
  {
    'iconKey': 'orders',
    'value': '87%',
    'label': 'On-time Deliveries',
    'growth': '+4.1%',
    'color': Color(0xFFF59E0B),
    'iconBgColor': Color(0xFFFEF3C7),
  },
  {
    'iconKey': 'profit',
    'value': '478K',
    'label': 'Savings Captured',
    'growth': '+11.0%',
    'color': Color(0xFF8B5CF6),
    'iconBgColor': Color(0xFFEDE9FE),
  },
];

const Map<String, dynamic> _vendorRecentData = {
  'salesHighlights': {
    'title': 'Confirmed RFQs',
    'totalValue': 87420,
    'currency': '4',
    'percentageChange': 9.4,
    'isPositive': true,
    'products': [
      {'name': 'Steel Coils', 'percentage': 34, 'color': 0xFF2563EB},
      {'name': 'Machinery', 'percentage': 28, 'color': 0xFF10B981},
      {'name': 'Instrumentation', 'percentage': 22, 'color': 0xFFF59E0B},
      {'name': 'Others', 'percentage': 16, 'color': 0xFFEF4444},
    ],
    'channels': [
      {
        'icon': 'store_outlined',
        'name': 'Strategic',
        'value': 32150,
        'percentageChange': 6.2,
        'isPositive': true,
      },
      {
        'icon': 'business_center_outlined',
        'name': 'Bid Portal',
        'value': 28940,
        'percentageChange': 12.1,
        'isPositive': true,
      },
      {
        'icon': 'support_agent_outlined',
        'name': 'Partner Desk',
        'value': 14680,
        'percentageChange': -2.4,
        'isPositive': false,
      },
      {
        'icon': 'shopping_cart_outlined',
        'name': 'Spot Buys',
        'value': 11650,
        'percentageChange': 4.6,
        'isPositive': true,
      },
    ],
  },
};

final Map<String, dynamic> _vendorRevenueChart = {
  ...RevenueGeneratedCard.exampleData,
  'cardTitle': 'Supplier Payments Trend',
  'cardSubtitle': 'Settled vs planned invoices (USD millions)',
  'thisYearLabel': 'Paid',
  'lastYearLabel': 'Scheduled',
  'percentageChange': '+8.4%',
  'thisYearData': RevenueGeneratedCard.exampleData['thisYearData']
      .map((point) => {'x': point['x'], 'y': (point['y'] as num) + 0.4})
      .toList(),
  'lastYearData': RevenueGeneratedCard.exampleData['lastYearData']
      .map((point) => {'x': point['x'], 'y': (point['y'] as num) - 0.2})
      .toList(),
};

const Map<String, dynamic> _vendorLeadSources = {
  'cardTitle': 'Supplier Mix',
  'cardSubtitle': 'Spend split by vendor tier',
  'totalLeads': '312 vendors',
  'pieChartData': [
    {'label': 'Tier 1', 'value': 48.0, 'color': '0xFF2563EB'},
    {'label': 'Tier 2', 'value': 27.0, 'color': '0xFF10B981'},
    {'label': 'Tier 3', 'value': 15.0, 'color': '0xFFF59E0B'},
    {'label': 'New', 'value': 10.0, 'color': '0xFF8B5CF6'},
  ],
  'legendData': [
    {'label': 'Tier 1', 'color': '0xFF2563EB'},
    {'label': 'Tier 2', 'color': '0xFF10B981'},
    {'label': 'Tier 3', 'color': '0xFFF59E0B'},
    {'label': 'New', 'color': '0xFF8B5CF6'},
  ],
};

const Map<String, dynamic> _vendorFinancialCard = {
  'cardTitle': 'Avg. PO Value',
  'cardSubtitle': 'Rolling 10-day view',
  'mainValue': '63.8K',
  'percentageChange': '+2.13%',
  'isPositiveChange': true,
  'changeLabel': 'vs prior window',
  'barData': [
    {'x': 0, 'y': 52},
    {'x': 1, 'y': 68},
    {'x': 2, 'y': 61},
    {'x': 3, 'y': 74},
    {'x': 4, 'y': 58},
    {'x': 5, 'y': 79},
    {'x': 6, 'y': 63},
    {'x': 7, 'y': 88},
    {'x': 8, 'y': 71},
    {'x': 9, 'y': 83},
  ],
  'labels': [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
    'Mon',
    'Tue',
    'Wed',
  ],
  'chartConfig': {'minX': 0, 'maxX': 9, 'minY': 40, 'maxY': 100},
};

const Map<String, dynamic> _vendorComboChart = {
  'cardTitle': 'Quote Win Rate',
  'cardSubtitle': 'Accepted vs declined proposals',
  'minY': 0.0,
  'maxY': 100.0,
  'gridInterval': 20.0,
  'yAxisLabels': [
    {'value': 0, 'label': '0%'},
    {'value': 20, 'label': '20%'},
    {'value': 40, 'label': '40%'},
    {'value': 60, 'label': '60%'},
    {'value': 80, 'label': '80%'},
    {'value': 100, 'label': '100%'},
  ],
  'chartData': [
    {'month': 'Jan', 'wins': 38.0, 'losses': 14.0, 'winRate': 73.0},
    {'month': 'Feb', 'wins': 42.0, 'losses': 17.0, 'winRate': 71.0},
    {'month': 'Mar', 'wins': 55.0, 'losses': 13.0, 'winRate': 80.0},
    {'month': 'Apr', 'wins': 61.0, 'losses': 11.0, 'winRate': 85.0},
    {'month': 'May', 'wins': 58.0, 'losses': 12.0, 'winRate': 83.0},
    {'month': 'Jun', 'wins': 65.0, 'losses': 9.0, 'winRate': 88.0},
  ],
};

const Map<String, dynamic> _vendorComparisonTabs = {
  'tabs': [
    {
      'label': 'Fulfilment Quality',
      'subtitle': 'Accepted vs rejected shipments',
      'onTimeOrder': [22000, 36000, 42000, 56000, 61000, 64000],
      'delayedOrder': [18000, 29000, 33000, 40000, 42000, 46000],
      'maxY': 70000,
    },
    {
      'label': 'Invoice Accuracy',
      'subtitle': 'Clean vs disputed invoices',
      'onTimeOrder': [14000, 18000, 21000, 26000, 31000, 33000],
      'delayedOrder': [4000, 6000, 7000, 9000, 8000, 7000],
      'maxY': 40000,
    },
  ],
};

const Map<String, dynamic> _vendorBarChart = {
  'cardTitle': 'Category Spend Bands',
  'cardSubtitle': 'Median PO amounts per commodity',
  'maxY': 450000.0,
  'minY': 0.0,
  'yAxisInterval': 90000.0,
  'barWidth': 8.0,
  'barsSpace': 4.0,
  'chartData': [
    {
      'label': 'Metals',
      'values': [
        {'value': 120000.0, 'color': 0xFFE0E0E0},
        {'value': 220000.0, 'color': 0xFF10B981},
        {'value': 330000.0, 'color': 0xFF2563EB},
      ],
      'percentile25': 120000.0,
      'percentile50': 220000.0,
      'percentile75': 330000.0,
    },
    {
      'label': 'Logistics',
      'values': [
        {'value': 90000.0, 'color': 0xFFE0E0E0},
        {'value': 190000.0, 'color': 0xFF10B981},
        {'value': 280000.0, 'color': 0xFF2563EB},
      ],
      'percentile25': 90000.0,
      'percentile50': 190000.0,
      'percentile75': 280000.0,
    },
    {
      'label': 'Services',
      'values': [
        {'value': 70000.0, 'color': 0xFFE0E0E0},
        {'value': 150000.0, 'color': 0xFF10B981},
        {'value': 230000.0, 'color': 0xFF2563EB},
      ],
      'percentile25': 70000.0,
      'percentile50': 150000.0,
      'percentile75': 230000.0,
    },
  ],
  'legendData': [
    {'label': '25th', 'color': '0xFFE0E0E0'},
    {'label': '50th', 'color': '0xFF10B981'},
    {'label': '75th', 'color': '0xFF2563EB'},
  ],
};

const List<Map<String, dynamic>> _vendorPortSections = [
  {
    'title': 'Strategic Suppliers',
    'subtitle': 'Tier 1 partners',
    'ports': [
      {
        'portName': 'Alpha Metals',
        'purchaseValue': '156M',
        'percentageChange': 9.2,
        'trend': 'up',
      },
      {
        'portName': 'Global Plastics',
        'purchaseValue': '118M',
        'percentageChange': 3.7,
        'trend': 'up',
      },
    ],
  },
  {
    'title': 'Emerging Vendors',
    'subtitle': 'Growth opportunities',
    'ports': [
      {
        'portName': 'Smart Components',
        'purchaseValue': '44M',
        'percentageChange': 15.4,
        'trend': 'up',
      },
      {
        'portName': 'Nexa Industrial',
        'purchaseValue': '39M',
        'percentageChange': 11.1,
        'trend': 'up',
      },
    ],
  },
  {
    'title': 'Risk Watch',
    'subtitle': 'Suppliers needing attention',
    'ports': [
      {
        'portName': 'Portside Logistics',
        'purchaseValue': '31M',
        'percentageChange': -6.4,
        'trend': 'down',
      },
      {
        'portName': 'Atlantic Fabrication',
        'purchaseValue': '27M',
        'percentageChange': -3.1,
        'trend': 'down',
      },
    ],
  },
];

/// Vendor Dashboard Page - Minimal implementation with hardcoded data
class VendorDashboard extends StatelessWidget {
  const VendorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        title: Text(
          'Vendor Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: ResponsiveGridRow(
          children: [
            DashboardGridCol(
              xs: 12,
              md: 8,
              child: DashboardCardContainer(cards: _vendorCards),
            ),
            DashboardGridCol(
              xs: 12,
              md: 4,
              child: DashboardRecentData(data: _vendorRecentData),
            ),
            DashboardGridCol(
              xs: 12,
              md: 5,
              child: RevenueGeneratedCard(chartData: _vendorRevenueChart),
            ),
            DashboardGridCol(
              xs: 12,
              md: 3,
              child: DashboardPieChart(data: _vendorLeadSources),
            ),
            DashboardGridCol(
              xs: 12,
              md: 4,
              child: DashboardFinancialCard(data: _vendorFinancialCard),
            ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              child: DashboardcombobarChart(data: _vendorComboChart),
            ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              child: MultiAnalyticsOveriview(data: _vendorComparisonTabs),
            ),
            DashboardGridCol(
              xs: 12,
              child: DashboardBarChart(data: _vendorBarChart),
            ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              lg: 4,
              child: DashboardLeadingPort(data: _vendorPortSections[0]),
            ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              lg: 4,
              child: DashboardLeadingPort(data: _vendorPortSections[1]),
            ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              lg: 4,
              child: DashboardLeadingPort(data: _vendorPortSections[2]),
            ),
          ],
        ),
      ),
    );
  }
}
