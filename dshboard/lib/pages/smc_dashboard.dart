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

// Ship Management dashboard sample data
const List<Map<String, dynamic>> _smcCards = [
  {
    'iconKey': 'revenue',
    'value': '94%',
    'label': 'Fleet Availability',
    'growth': '+2.1%',
    'color': Color(0xFF0EA5E9),
    'iconBgColor': Color(0xFFE0F2FE),
  },
  {
    'iconKey': 'users',
    'value': '42',
    'label': 'Active Voyages',
    'growth': '+5.0%',
    'color': Color(0xFF22C55E),
    'iconBgColor': Color(0xFFD1FAE5),
  },
  {
    'iconKey': 'orders',
    'value': '3.8%',
    'label': 'Fuel Overrun',
    'growth': '-0.6%',
    'color': Color(0xFFF97316),
    'iconBgColor': Color(0xFFFFEDD5),
  },
  {
    'iconKey': 'profit',
    'value': '61',
    'label': 'Incident-free Days',
    'growth': '+61 days',
    'color': Color(0xFF6366F1),
    'iconBgColor': Color(0xFFE0E7FF),
  },
];

const Map<String, dynamic> _smcOperationsData = {
  'salesHighlights': {
    'title': 'Voyage Performance',
    'totalValue': 12600,
    'currency': null,
    'percentageChange': 5.8,
    'isPositive': true,
    'products': [
      {'name': 'Bulk', 'percentage': 38, 'color': 0xFF0EA5E9},
      {'name': 'Container', 'percentage': 33, 'color': 0xFF22C55E},
      {'name': 'Tanker', 'percentage': 21, 'color': 0xFFF97316},
      {'name': 'Support', 'percentage': 8, 'color': 0xFF6366F1},
    ],
    'channels': [
      {
        'icon': 'local_shipping_outlined',
        'name': 'Atlantic',
        'value': 4600,
        'percentageChange': 7.1,
        'isPositive': true,
      },
      {
        'icon': 'schedule_outlined',
        'name': 'Pacific',
        'value': 3980,
        'percentageChange': 4.3,
        'isPositive': true,
      },
      {
        'icon': 'description_outlined',
        'name': 'Indian',
        'value': 2380,
        'percentageChange': -1.4,
        'isPositive': false,
      },
      {
        'icon': 'support_agent_outlined',
        'name': 'Coastal',
        'value': 1640,
        'percentageChange': 3.5,
        'isPositive': true,
      },
    ],
  },
};

final Map<String, dynamic> _smcRevenueChart = {
  ...RevenueGeneratedCard.exampleData,
  'cardTitle': 'Operating Cost vs Budget',
  'cardSubtitle': 'Per fleet (USD millions)',
  'thisYearLabel': 'Actuals',
  'lastYearLabel': 'Budget',
  'percentageChange': '-1.8%',
  'isPositiveChange': false,
  'thisYearData': RevenueGeneratedCard.exampleData['thisYearData']
      .map((point) => {'x': point['x'], 'y': (point['y'] as num) - 0.3})
      .toList(),
  'lastYearData': RevenueGeneratedCard.exampleData['lastYearData']
      .map((point) => {'x': point['x'], 'y': (point['y'] as num) + 0.3})
      .toList(),
};

const Map<String, dynamic> _smcPieData = {
  'cardTitle': 'Fleet Utilization',
  'cardSubtitle': 'Running vs docked vessels',
  'totalLeads': '58 vessels',
  'pieChartData': [
    {'label': 'At Sea', 'value': 62.0, 'color': '0xFF0EA5E9'},
    {'label': 'Port Ops', 'value': 21.0, 'color': '0xFF22C55E'},
    {'label': 'Maintenance', 'value': 11.0, 'color': '0xFFF97316'},
    {'label': 'Layup', 'value': 6.0, 'color': '0xFF6366F1'},
  ],
  'legendData': [
    {'label': 'At Sea', 'color': '0xFF0EA5E9'},
    {'label': 'Port Ops', 'color': '0xFF22C55E'},
    {'label': 'Maintenance', 'color': '0xFFF97316'},
    {'label': 'Layup', 'color': '0xFF6366F1'},
  ],
};

const Map<String, dynamic> _smcFinancialCard = {
  'cardTitle': 'Avg. Daily OPEX',
  'cardSubtitle': 'Per vessel over last 10 days',
  'mainValue': '75.4K',
  'percentageChange': '+0.7%',
  'isPositiveChange': true,
  'changeLabel': 'vs running avg',
  'barData': [
    {'x': 0, 'y': 70},
    {'x': 1, 'y': 66},
    {'x': 2, 'y': 74},
    {'x': 3, 'y': 72},
    {'x': 4, 'y': 78},
    {'x': 5, 'y': 81},
    {'x': 6, 'y': 69},
    {'x': 7, 'y': 76},
    {'x': 8, 'y': 73},
    {'x': 9, 'y': 79},
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
  'chartConfig': {'minX': 0, 'maxX': 9, 'minY': 50, 'maxY': 90},
};

const Map<String, dynamic> _smcComboChart = {
  'cardTitle': 'Maintenance Completion',
  'cardSubtitle': 'Scheduled vs carried tasks',
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
    {'month': 'Jan', 'wins': 32.0, 'losses': 18.0, 'winRate': 64.0},
    {'month': 'Feb', 'wins': 36.0, 'losses': 17.0, 'winRate': 68.0},
    {'month': 'Mar', 'wins': 48.0, 'losses': 12.0, 'winRate': 80.0},
    {'month': 'Apr', 'wins': 51.0, 'losses': 11.0, 'winRate': 82.0},
    {'month': 'May', 'wins': 57.0, 'losses': 9.0, 'winRate': 86.0},
    {'month': 'Jun', 'wins': 53.0, 'losses': 10.0, 'winRate': 84.0},
  ],
};

const Map<String, dynamic> _smcComparisonTabs = {
  'tabs': [
    {
      'label': 'Crew Compliance',
      'subtitle': 'Training vs due renewals',
      'onTimeOrder': [18000, 22000, 25000, 30000, 32000, 34000],
      'delayedOrder': [6000, 7000, 8000, 9000, 11000, 12000],
      'maxY': 40000,
    },
    {
      'label': 'Safety Routines',
      'subtitle': 'Completed vs pending drills',
      'onTimeOrder': [8000, 11000, 14000, 15000, 16000, 17000],
      'delayedOrder': [2000, 2500, 2700, 3100, 3300, 3500],
      'maxY': 20000,
    },
  ],
};

const Map<String, dynamic> _smcBarChart = {
  'cardTitle': 'Port Call Duration',
  'cardSubtitle': 'Median hours per region',
  'maxY': 120.0,
  'minY': 0.0,
  'yAxisInterval': 20.0,
  'barWidth': 10.0,
  'barsSpace': 5.0,
  'chartData': [
    {
      'label': 'Asia',
      'values': [
        {'value': 40.0, 'color': 0xFFE0E0E0},
        {'value': 68.0, 'color': 0xFF22C55E},
        {'value': 92.0, 'color': 0xFF0EA5E9},
      ],
      'percentile25': 40.0,
      'percentile50': 68.0,
      'percentile75': 92.0,
    },
    {
      'label': 'Europe',
      'values': [
        {'value': 38.0, 'color': 0xFFE0E0E0},
        {'value': 60.0, 'color': 0xFF22C55E},
        {'value': 80.0, 'color': 0xFF0EA5E9},
      ],
      'percentile25': 38.0,
      'percentile50': 60.0,
      'percentile75': 80.0,
    },
    {
      'label': 'Americas',
      'values': [
        {'value': 44.0, 'color': 0xFFE0E0E0},
        {'value': 73.0, 'color': 0xFF22C55E},
        {'value': 96.0, 'color': 0xFF0EA5E9},
      ],
      'percentile25': 44.0,
      'percentile50': 73.0,
      'percentile75': 96.0,
    },
  ],
  'legendData': [
    {'label': '25th', 'color': '0xFFE0E0E0'},
    {'label': '50th', 'color': '0xFF22C55E'},
    {'label': '75th', 'color': '0xFF0EA5E9'},
  ],
};

const List<Map<String, dynamic>> _smcSegments = [
  {
    'title': 'Top Routes',
    'subtitle': 'Average revenue per voyage',
    'ports': [
      {
        'portName': 'Singapore - LA',
        'purchaseValue': '95K / day',
        'percentageChange': 4.2,
        'trend': 'up',
      },
      {
        'portName': 'Rotterdam - NY',
        'purchaseValue': '87K / day',
        'percentageChange': 2.5,
        'trend': 'up',
      },
    ],
  },
  {
    'title': 'Maintenance Yards',
    'subtitle': 'Spend & trend',
    'ports': [
      {
        'portName': 'Busan',
        'purchaseValue': '11.4M',
        'percentageChange': -3.2,
        'trend': 'down',
      },
      {
        'portName': 'Genoa',
        'purchaseValue': '8.1M',
        'percentageChange': 1.4,
        'trend': 'up',
      },
    ],
  },
  {
    'title': 'Fuel Suppliers',
    'subtitle': 'Bunker contracts',
    'ports': [
      {
        'portName': 'Fujairah',
        'purchaseValue': '23.7M',
        'percentageChange': 5.1,
        'trend': 'up',
      },
      {
        'portName': 'Houston',
        'purchaseValue': '19.3M',
        'percentageChange': -2.8,
        'trend': 'down',
      },
    ],
  },
];

/// SMC Dashboard Page - Minimal implementation with hardcoded data
class SMCDashboard extends StatelessWidget {
  const SMCDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        title: Text(
          'Ship Management Dashboard',
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
              child: DashboardCardContainer(cards: _smcCards),
            ),
            DashboardGridCol(
              xs: 12,
              md: 4,
              child: DashboardRecentData(data: _smcOperationsData),
            ),
            DashboardGridCol(
              xs: 12,
              md: 5,
              child: RevenueGeneratedCard(chartData: _smcRevenueChart),
            ),
            DashboardGridCol(
              xs: 12,
              md: 3,
              child: DashboardPieChart(data: _smcPieData),
            ),
            DashboardGridCol(
              xs: 12,
              md: 4,
              child: DashboardFinancialCard(data: _smcFinancialCard),
            ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              child: DashboardcombobarChart(data: _smcComboChart),
            ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              child: MultiAnalyticsOveriview(data: _smcComparisonTabs),
            ),
            DashboardGridCol(
              xs: 12,
              child: DashboardBarChart(data: _smcBarChart),
            ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              lg: 4,
              child: DashboardLeadingPort(data: _smcSegments[0]),
            ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              lg: 4,
              child: DashboardLeadingPort(data: _smcSegments[1]),
            ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              lg: 4,
              child: DashboardLeadingPort(data: _smcSegments[2]),
            ),
          ],
        ),
      ),
    );
  }
}
