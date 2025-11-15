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

// Catalogue insights sample data
const List<Map<String, dynamic>> _catalogueCards = [
  {
    'iconKey': 'revenue',
    'value': '680K',
    'label': 'Catalogue GMV',
    'growth': '+7.9%',
    'color': Color(0xFF7C3AED),
    'iconBgColor': Color(0xFFF3E8FF),
  },
  {
    'iconKey': 'users',
    'value': '18.4K',
    'label': 'Monthly Buyers',
    'growth': '+11.4%',
    'color': Color(0xFFEC4899),
    'iconBgColor': Color(0xFFFDE0F0),
  },
  {
    'iconKey': 'orders',
    'value': '9.2K',
    'label': 'Active Listings',
    'growth': '+3.6%',
    'color': Color(0xFFF97316),
    'iconBgColor': Color(0xFFFFEAD5),
  },
  {
    'iconKey': 'profit',
    'value': '4.8',
    'label': 'Avg Rating',
    'growth': '+0.2',
    'color': Color(0xFF0EA5E9),
    'iconBgColor': Color(0xFFE0F2FE),
  },
];

const Map<String, dynamic> _catalogueRecentData = {
  'salesHighlights': {
    'title': 'Top Performing Categories',
    'totalValue': 152430,
    'currency': '',
    'percentageChange': 12.1,
    'isPositive': true,
    'products': [
      {'name': 'Electrical', 'percentage': 36, 'color': 0xFF7C3AED},
      {'name': 'Safety', 'percentage': 29, 'color': 0xFFEC4899},
      {'name': 'Marine', 'percentage': 19, 'color': 0xFFF97316},
      {'name': 'Office', 'percentage': 16, 'color': 0xFF0EA5E9},
    ],
    'channels': [
      {
        'icon': 'shopping_cart_outlined',
        'name': 'Online Store',
        'value': 64280,
        'percentageChange': 15.4,
        'isPositive': true,
      },
      {
        'icon': 'storefront_outlined',
        'name': 'In-branch',
        'value': 42160,
        'percentageChange': 6.1,
        'isPositive': true,
      },
      {
        'icon': 'support_agent_outlined',
        'name': 'Inside Sales',
        'value': 29830,
        'percentageChange': 8.2,
        'isPositive': true,
      },
      {
        'icon': 'business_center_outlined',
        'name': 'Enterprise',
        'value': 16160,
        'percentageChange': -2.3,
        'isPositive': false,
      },
    ],
  },
};

final Map<String, dynamic> _catalogueRevenueChart = {
  ...RevenueGeneratedCard.exampleData,
  'cardTitle': 'Catalogue Revenue',
  'cardSubtitle': 'Digital vs assisted conversion',
  'thisYearLabel': 'Digital',
  'lastYearLabel': 'Assisted',
  'percentageChange': '+12.9%',
  'thisYearData': RevenueGeneratedCard.exampleData['thisYearData']
      .map((point) => {'x': point['x'], 'y': (point['y'] as num) + 0.6})
      .toList(),
  'lastYearData': RevenueGeneratedCard.exampleData['lastYearData']
      .map((point) => {'x': point['x'], 'y': (point['y'] as num) - 0.1})
      .toList(),
};

const Map<String, dynamic> _cataloguePieData = {
  'cardTitle': 'Channel Mix',
  'cardSubtitle': 'Contribution to GMV',
  'totalLeads': '680K',
  'pieChartData': [
    {'label': 'Marketplace', 'value': 41.0, 'color': '0xFF7C3AED'},
    {'label': 'Direct', 'value': 33.0, 'color': '0xFFEC4899'},
    {'label': 'Partner', 'value': 18.0, 'color': '0xFFF97316'},
    {'label': 'Retail', 'value': 8.0, 'color': '0xFF0EA5E9'},
  ],
  'legendData': [
    {'label': 'Marketplace', 'color': '0xFF7C3AED'},
    {'label': 'Direct', 'color': '0xFFEC4899'},
    {'label': 'Partner', 'color': '0xFFF97316'},
    {'label': 'Retail', 'color': '0xFF0EA5E9'},
  ],
};

const Map<String, dynamic> _catalogueFinancialCard = {
  'cardTitle': 'Avg. Basket Size',
  'cardSubtitle': 'Trailing 10 days',
  'mainValue': '12.6K',
  'percentageChange': '+1.5%',
  'isPositiveChange': true,
  'changeLabel': 'vs previous period',
  'barData': [
    {'x': 0, 'y': 44},
    {'x': 1, 'y': 51},
    {'x': 2, 'y': 55},
    {'x': 3, 'y': 60},
    {'x': 4, 'y': 58},
    {'x': 5, 'y': 63},
    {'x': 6, 'y': 67},
    {'x': 7, 'y': 70},
    {'x': 8, 'y': 65},
    {'x': 9, 'y': 72},
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
  'chartConfig': {'minX': 0, 'maxX': 9, 'minY': 40, 'maxY': 80},
};

const Map<String, dynamic> _catalogueComboData = {
  'cardTitle': 'Conversion Funnel',
  'cardSubtitle': 'Quote to cart progression',
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
    {'month': 'Jan', 'wins': 48.0, 'losses': 12.0, 'winRate': 80.0},
    {'month': 'Feb', 'wins': 44.0, 'losses': 14.0, 'winRate': 76.0},
    {'month': 'Mar', 'wins': 58.0, 'losses': 11.0, 'winRate': 84.0},
    {'month': 'Apr', 'wins': 62.0, 'losses': 9.0, 'winRate': 87.0},
    {'month': 'May', 'wins': 66.0, 'losses': 8.0, 'winRate': 89.0},
    {'month': 'Jun', 'wins': 61.0, 'losses': 10.0, 'winRate': 86.0},
  ],
};

const Map<String, dynamic> _catalogueComparisonTabs = {
  'tabs': [
    {
      'label': 'Assortment Health',
      'subtitle': 'Stocked vs out-of-stock SKUs',
      'onTimeOrder': [32000, 36000, 39000, 42000, 45000, 47000],
      'delayedOrder': [4000, 5200, 6100, 6800, 7200, 7600],
      'maxY': 52000,
    },
    {
      'label': 'Customer SLAs',
      'subtitle': 'Same-day vs delayed dispatches',
      'onTimeOrder': [18000, 21000, 23000, 25000, 27000, 30000],
      'delayedOrder': [2600, 3100, 3300, 3800, 4200, 4600],
      'maxY': 32000,
    },
  ],
};

const Map<String, dynamic> _catalogueBarChart = {
  'cardTitle': 'Category Price Bands',
  'cardSubtitle': '25th/50th/75th percentile order sizes',
  'maxY': 380000.0,
  'minY': 0.0,
  'yAxisInterval': 75000.0,
  'barWidth': 8.0,
  'barsSpace': 4.0,
  'chartData': [
    {
      'label': 'Electrical',
      'values': [
        {'value': 90000.0, 'color': 0xFFE0E0E0},
        {'value': 180000.0, 'color': 0xFFEC4899},
        {'value': 260000.0, 'color': 0xFF7C3AED},
      ],
      'percentile25': 90000.0,
      'percentile50': 180000.0,
      'percentile75': 260000.0,
    },
    {
      'label': 'Safety',
      'values': [
        {'value': 60000.0, 'color': 0xFFE0E0E0},
        {'value': 140000.0, 'color': 0xFFEC4899},
        {'value': 220000.0, 'color': 0xFF7C3AED},
      ],
      'percentile25': 60000.0,
      'percentile50': 140000.0,
      'percentile75': 220000.0,
    },
    {
      'label': 'Marine',
      'values': [
        {'value': 110000.0, 'color': 0xFFE0E0E0},
        {'value': 200000.0, 'color': 0xFFEC4899},
        {'value': 310000.0, 'color': 0xFF7C3AED},
      ],
      'percentile25': 110000.0,
      'percentile50': 200000.0,
      'percentile75': 310000.0,
    },
  ],
  'legendData': [
    {'label': '25th', 'color': '0xFFE0E0E0'},
    {'label': '50th', 'color': '0xFFEC4899'},
    {'label': '75th', 'color': '0xFF7C3AED'},
  ],
};

const List<Map<String, dynamic>> _catalogueVendors = [
  {
    'title': 'Top Brands',
    'subtitle': 'GMV contribution',
    'ports': [
      {
        'portName': 'Aurora Tools',
        'purchaseValue': '156K',
        'percentageChange': 8.7,
        'trend': 'up',
      },
      {
        'portName': 'Harbor Safety',
        'purchaseValue': '141K',
        'percentageChange': 6.1,
        'trend': 'up',
      },
    ],
  },
  {
    'title': 'Fast Movers',
    'subtitle': 'Inventory turns',
    'ports': [
      {
        'portName': 'Volt Electrical',
        'purchaseValue': '21 turns',
        'percentageChange': 3.8,
        'trend': 'up',
      },
      {
        'portName': 'Shield PPE',
        'purchaseValue': '17 turns',
        'percentageChange': 1.9,
        'trend': 'up',
      },
    ],
  },
  {
    'title': 'Watchlist',
    'subtitle': 'Declining assortment',
    'ports': [
      {
        'portName': 'MarineX',
        'purchaseValue': '61K',
        'percentageChange': -4.3,
        'trend': 'down',
      },
      {
        'portName': 'Northwind',
        'purchaseValue': '57K',
        'percentageChange': -2.1,
        'trend': 'down',
      },
    ],
  },
];

/// Catalogue Dashboard Page - Minimal implementation with hardcoded data
class CatalogueDashboard extends StatelessWidget {
  const CatalogueDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        title: Text(
          'Catalogue Dashboard',
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
              child: DashboardCardContainer(cards: _catalogueCards),
            ),
            DashboardGridCol(
              xs: 12,
              md: 4,
              child: DashboardRecentData(data: _catalogueRecentData),
            ),
            DashboardGridCol(
              xs: 12,
              md: 5,
              child: RevenueGeneratedCard(chartData: _catalogueRevenueChart),
            ),
            DashboardGridCol(
              xs: 12,
              md: 3,
              child: DashboardPieChart(data: _cataloguePieData),
            ),
            DashboardGridCol(
              xs: 12,
              md: 4,
              child: DashboardFinancialCard(data: _catalogueFinancialCard),
            ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              child: DashboardcombobarChart(data: _catalogueComboData),
            ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              child: MultiAnalyticsOveriview(data: _catalogueComparisonTabs),
            ),
            DashboardGridCol(
              xs: 12,
              child: DashboardBarChart(data: _catalogueBarChart),
            ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              lg: 4,
              child: DashboardLeadingPort(data: _catalogueVendors[0]),
            ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              lg: 4,
              child: DashboardLeadingPort(data: _catalogueVendors[1]),
            ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              lg: 4,
              child: DashboardLeadingPort(data: _catalogueVendors[2]),
            ),
          ],
        ),
      ),
    );
  }
}
