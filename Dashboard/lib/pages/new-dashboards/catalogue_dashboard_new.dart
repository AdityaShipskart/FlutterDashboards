import 'package:flutter/material.dart';
// import 'package:get/utils.dart';
import '../../widgets/dashboard_grid.dart';
import '../../widgets/dashboard_card_container.dart';
import '../../widgets/dashboard_recent_data.dart';
import '../../widgets/dashboard_line_chart.dart';
import '../../widgets/dashboard_pie_chart.dart';
import '../../widgets/dashboard_financial_card.dart';
import '../../widgets/dashboard_combobar_chart.dart';
import '../../widgets/dashboard_comparison.dart';
import '../../widgets/dashboard_bar_chart.dart';
import '../../widgets/dashboard_leading_port.dart';
import '../../widgets/dashboard_table.dart';

/// Catalogue Dashboard (Enhanced)
///
/// Comprehensive dashboard for catalogue management:
/// - Total categories and product counts
/// - Products by category breakdown
/// - Order volume tracking
/// - New vs discontinued products
/// - Performance analytics
/// - Utilization by client type
/// - Custom requirements tracking
/// - Category health metrics
/// - Search and discovery analytics
const List<Map<String, dynamic>> _catalogueCards = [
  {
    'iconKey': 'orders',
    'value': '247',
    'label': 'Active Categories',
    'growth': '+12',
    'color': Color(0xFF6366F1),
    'iconBgColor': Color(0xFFEEF2FF),
  },
  {
    'iconKey': 'revenue',
    'value': '18,462',
    'label': 'Total Products',
    'growth': '+842',
    'color': Color(0xFFEC4899),
    'iconBgColor': Color(0xFFFDE0F0),
  },
  {
    'iconKey': 'profit',
    'value': '14.2K',
    'label': 'Monthly Orders',
    'growth': '+18.6%',
    'color': Color(0xFF10B981),
    'iconBgColor': Color(0xFFD1FAE5),
  },
  {
    'iconKey': 'users',
    'value': '92.4%',
    'label': 'Catalogue Utilization',
    'growth': '+3.8%',
    'color': Color(0xFF0EA5E9),
    'iconBgColor': Color(0xFFE0F2FE),
  },
];

const Map<String, dynamic> _catalogueProductBreakdown = {
  'salesHighlights': {
    'title': 'Products by Category',
    'totalValue': 18462,
    'currency': '',
    'percentageChange': 4.6,
    'isPositive': true,
    'products': [
      {'name': 'Marine Equipment', 'percentage': 32, 'color': 0xFF6366F1},
      {'name': 'Electronics', 'percentage': 26, 'color': 0xFFEC4899},
      {'name': 'Safety & PPE', 'percentage': 22, 'color': 0xFF10B981},
      {'name': 'Other', 'percentage': 20, 'color': 0xFF0EA5E9},
    ],
    'channels': [
      {
        'icon': 'anchor_outlined',
        'name': 'Marine Equipment',
        'value': 5908,
        'percentageChange': 5.2,
        'isPositive': true,
      },
      {
        'icon': 'devices_outlined',
        'name': 'Electronics',
        'value': 4800,
        'percentageChange': 4.8,
        'isPositive': true,
      },
      {
        'icon': 'shield_outlined',
        'name': 'Safety & PPE',
        'value': 4062,
        'percentageChange': 3.6,
        'isPositive': true,
      },
      {
        'icon': 'inventory_outlined',
        'name': 'Other Categories',
        'value': 3692,
        'percentageChange': 4.1,
        'isPositive': true,
      },
    ],
  },
};

final Map<String, dynamic> _catalogueGrowthChart = {
  'cardTitle': 'Catalogue Growth',
  'cardSubtitle': 'New products vs discontinued',
  'thisYearLabel': 'New Products',
  'lastYearLabel': 'Discontinued',
  'percentageChange': '+4.6%',
  'isPositiveChange': true,
  'availablePeriods': ['Jan-Jun', 'Jul-Dec', 'Full Year'],
  'selectedPeriod': 'Full Year',
  'chartConfig': {'minX': 0, 'maxX': 11, 'minY': 0, 'maxY': 10},
  'thisYearData': [
    {'x': 0, 'y': 6.2},
    {'x': 1, 'y': 6.8},
    {'x': 2, 'y': 7.2},
    {'x': 3, 'y': 7.6},
    {'x': 4, 'y': 8.0},
    {'x': 5, 'y': 8.4},
    {'x': 6, 'y': 7.8},
    {'x': 7, 'y': 8.2},
    {'x': 8, 'y': 8.6},
    {'x': 9, 'y': 8.8},
    {'x': 10, 'y': 9.0},
    {'x': 11, 'y': 9.2},
  ],
  'lastYearData': [
    {'x': 0, 'y': 0.8},
    {'x': 1, 'y': 0.6},
    {'x': 2, 'y': 0.7},
    {'x': 3, 'y': 0.5},
    {'x': 4, 'y': 0.6},
    {'x': 5, 'y': 0.4},
    {'x': 6, 'y': 0.8},
    {'x': 7, 'y': 0.6},
    {'x': 8, 'y': 0.5},
    {'x': 9, 'y': 0.7},
    {'x': 10, 'y': 0.5},
    {'x': 11, 'y': 0.6},
  ],
  'labels': [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ],
};

const Map<String, dynamic> _clientTypePieData = {
  'cardTitle': 'Utilization by Client Type',
  'cardSubtitle': 'Orders by customer segment',
  'totalLeads': '14.2K',
  'pieChartData': [
    {'label': 'SMC', 'value': 42.0, 'color': '0xFF6366F1'},
    {'label': 'Vendor', 'value': 31.0, 'color': '0xFFEC4899'},
    {'label': 'Partner', 'value': 18.0, 'color': '0xFF10B981'},
    {'label': 'Retail', 'value': 9.0, 'color': '0xFF0EA5E9'},
  ],
  'legendData': [
    {'label': 'SMC', 'color': '0xFF6366F1'},
    {'label': 'Vendor', 'color': '0xFFEC4899'},
    {'label': 'Partner', 'color': '0xFF10B981'},
    {'label': 'Retail', 'color': '0xFF0EA5E9'},
  ],
};

const Map<String, dynamic> _catalogueUtilizationCard = {
  'cardTitle': 'Catalogue Utilization',
  'cardSubtitle': 'Products with orders (last 30 days)',
  'mainValue': '92.4%',
  'percentageChange': '+3.8%',
  'isPositiveChange': true,
  'changeLabel': 'vs previous month',
  'barData': [
    {'x': 0, 'y': 72},
    {'x': 1, 'y': 76},
    {'x': 2, 'y': 78},
    {'x': 3, 'y': 81},
    {'x': 4, 'y': 83},
    {'x': 5, 'y': 85},
    {'x': 6, 'y': 87},
    {'x': 7, 'y': 89},
    {'x': 8, 'y': 91},
    {'x': 9, 'y': 92},
  ],
  'labels': [
    'Week 1',
    'Week 2',
    'Week 3',
    'Week 4',
    'Week 5',
    'Week 6',
    'Week 7',
    'Week 8',
    'Week 9',
    'Week 10',
  ],
  'chartConfig': {'minX': 0, 'maxX': 9, 'minY': 65, 'maxY': 100},
};

const Map<String, dynamic> _categoryPerformanceCombo = {
  'cardTitle': 'Category Performance',
  'cardSubtitle': 'Active vs low-performing categories',
  'minY': 0.0,
  'maxY': 160.0,
  'gridInterval': 30.0,
  'yAxisLabels': [
    {'value': 0, 'label': '0'},
    {'value': 30, 'label': '30'},
    {'value': 60, 'label': '60'},
    {'value': 90, 'label': '90'},
    {'value': 120, 'label': '120'},
    {'value': 150, 'label': '150'},
  ],
  'chartData': [
    {'month': 'Jan', 'wins': 128.0, 'losses': 18.0, 'winRate': 87.7},
    {'month': 'Feb', 'wins': 132.0, 'losses': 16.0, 'winRate': 89.2},
    {'month': 'Mar', 'wins': 138.0, 'losses': 14.0, 'winRate': 90.8},
    {'month': 'Apr', 'wins': 142.0, 'losses': 12.0, 'winRate': 92.2},
    {'month': 'May', 'wins': 146.0, 'losses': 10.0, 'winRate': 93.6},
    {'month': 'Jun', 'wins': 148.0, 'losses': 8.0, 'winRate': 94.9},
  ],
};

const Map<String, dynamic> _customRequirementsComparison = {
  'tabs': [
    {
      'label': 'Standard vs Custom',
      'subtitle': 'Product configuration requests',
      'onTimeOrder': [11200, 11800, 12400, 12800, 13200, 13600],
      'delayedOrder': [1800, 1900, 2100, 2200, 2400, 2600],
      'maxY': 14000,
    },
    {
      'label': 'Search Analytics',
      'subtitle': 'Successful vs failed searches',
      'onTimeOrder': [28400, 29600, 30800, 31800, 32600, 33400],
      'delayedOrder': [2200, 2400, 2600, 2700, 2800, 2900],
      'maxY': 35000,
    },
  ],
};

const Map<String, dynamic> _ordersByCategoryBar = {
  'cardTitle': 'Orders by Category',
  'cardSubtitle': 'Distribution across top categories',
  'maxY': 2400.0,
  'minY': 0.0,
  'yAxisInterval': 400.0,
  'barWidth': 10.0,
  'barsSpace': 5.0,
  'chartData': [
    {
      'label': 'Marine',
      'values': [
        {'value': 680.0, 'color': 0xFFE0E0E0},
        {'value': 1420.0, 'color': 0xFF10B981},
        {'value': 2140.0, 'color': 0xFF6366F1},
      ],
      'percentile25': 680.0,
      'percentile50': 1420.0,
      'percentile75': 2140.0,
    },
    {
      'label': 'Electronics',
      'values': [
        {'value': 520.0, 'color': 0xFFE0E0E0},
        {'value': 1180.0, 'color': 0xFF10B981},
        {'value': 1860.0, 'color': 0xFF6366F1},
      ],
      'percentile25': 520.0,
      'percentile50': 1180.0,
      'percentile75': 1860.0,
    },
    {
      'label': 'Safety',
      'values': [
        {'value': 460.0, 'color': 0xFFE0E0E0},
        {'value': 980.0, 'color': 0xFF10B981},
        {'value': 1540.0, 'color': 0xFF6366F1},
      ],
      'percentile25': 460.0,
      'percentile50': 980.0,
      'percentile75': 1540.0,
    },
    {
      'label': 'Tools',
      'values': [
        {'value': 380.0, 'color': 0xFFE0E0E0},
        {'value': 820.0, 'color': 0xFF10B981},
        {'value': 1320.0, 'color': 0xFF6366F1},
      ],
      'percentile25': 380.0,
      'percentile50': 820.0,
      'percentile75': 1320.0,
    },
  ],
  'legendData': [
    {'label': 'Low', 'color': '0xFFE0E0E0'},
    {'label': 'Medium', 'color': '0xFF10B981'},
    {'label': 'High', 'color': '0xFF6366F1'},
  ],
};

const List<Map<String, dynamic>> _catalogueInsights = [
  {
    'title': 'Top Performing Categories',
    'subtitle': 'Highest order volume',
    'ports': [
      {
        'portName': 'Marine Equipment',
        'purchaseValue': '2,847',
        'percentageChange': 22.4,
        'trend': 'up',
      },
      {
        'portName': 'Safety Equipment',
        'purchaseValue': '2,268',
        'percentageChange': 18.6,
        'trend': 'up',
      },
    ],
  },
  {
    'title': 'Fastest Growing',
    'subtitle': 'Month-over-month growth',
    'ports': [
      {
        'portName': 'Smart Sensors',
        'purchaseValue': '842',
        'percentageChange': 48.7,
        'trend': 'up',
      },
      {
        'portName': 'Eco Products',
        'purchaseValue': '726',
        'percentageChange': 38.2,
        'trend': 'up',
      },
    ],
  },
  {
    'title': 'Needs Attention',
    'subtitle': 'Low utilization categories',
    'ports': [
      {
        'portName': 'Legacy Parts',
        'purchaseValue': '142',
        'percentageChange': -12.8,
        'trend': 'down',
      },
      {
        'portName': 'Discontinued',
        'purchaseValue': '86',
        'percentageChange': -24.6,
        'trend': 'down',
      },
    ],
  },
];

const Map<String, dynamic> _catalogueTableData = {
  'header': {
    'title': 'Top Products by Orders',
    'subtitle': 'Most ordered products this month',
  },
  'rfqs': [
    {
      'rank': 1,
      'rfqId': 'PRD-8472',
      'title': 'Marine Engine Oil',
      'supplier': 'Lubricants',
      'estimatedValue': 428,
      'percentageChange': 24.8,
      'responsesReceived': 142,
      'daysRemaining': 98,
    },
    {
      'rank': 2,
      'rfqId': 'PRD-8461',
      'title': 'Navigation System Pro',
      'supplier': 'Electronics',
      'estimatedValue': 386,
      'percentageChange': 21.4,
      'responsesReceived': 86,
      'daysRemaining': 76,
    },
    {
      'rank': 3,
      'rfqId': 'PRD-8448',
      'title': 'Safety Harness Kit',
      'supplier': 'Safety',
      'estimatedValue': 342,
      'percentageChange': 18.6,
      'responsesReceived': 124,
      'daysRemaining': 84,
    },
    {
      'rank': 4,
      'rfqId': 'PRD-8432',
      'title': 'Deck Paint Premium',
      'supplier': 'Coatings',
      'estimatedValue': 298,
      'percentageChange': 16.2,
      'responsesReceived': 168,
      'daysRemaining': 92,
    },
  ],
  'pendingQuotes': {
    'header': {
      'title': 'New Products (MTD)',
      'subtitle': 'Recently added to catalogue',
    },
    'quotes': [
      {
        'rank': 1,
        'quoteId': 'NEW-7284',
        'customer': 'Smart Fuel Monitor',
        'quoteValue': 0,
        'percentageChange': 0.0,
        'daysInReview': 3,
        'expiresInDays': 0,
        'status': 'Active',
      },
      {
        'rank': 2,
        'quoteId': 'NEW-7268',
        'customer': 'Eco-Friendly Cleaner',
        'quoteValue': 0,
        'percentageChange': 0.0,
        'daysInReview': 5,
        'expiresInDays': 0,
        'status': 'Active',
      },
    ],
  },
  'activeOrders': {
    'header': {
      'title': 'Low Stock Products',
      'subtitle': 'Items needing restocking',
    },
    'orders': [
      {
        'rank': 1,
        'orderId': 'STK-6842',
        'customer': 'Navigation System Pro',
        'orderValue': 12,
        'percentageChange': -68.0,
        'progressPercentage': 12,
        'deliveryStatus': 'Low Stock',
        'expectedDelivery': 'Restock needed',
      },
      {
        'rank': 2,
        'orderId': 'STK-6821',
        'customer': 'Safety Harness Kit',
        'orderValue': 18,
        'percentageChange': -58.0,
        'progressPercentage': 18,
        'deliveryStatus': 'Low Stock',
        'expectedDelivery': 'Restock needed',
      },
    ],
  },
  'completedDeliveries': {
    'header': {
      'title': 'Discontinued Products',
      'subtitle': 'Recently removed from catalogue',
    },
    'deliveries': [
      {
        'rank': 1,
        'deliveryId': 'DSC-1824',
        'customer': 'Legacy Engine Part X42',
        'deliveryValue': 0,
        'percentageChange': -100.0,
        'deliveryDate': '2025-01-15',
        'rating': 0.0,
        'onTime': false,
      },
      {
        'rank': 2,
        'deliveryId': 'DSC-1796',
        'customer': 'Old Navigation Unit V3',
        'deliveryValue': 0,
        'percentageChange': -100.0,
        'deliveryDate': '2025-01-08',
        'rating': 0.0,
        'onTime': false,
      },
    ],
  },
  'customerMetrics': {
    'header': {
      'title': 'Category Health',
      'subtitle': 'Performance by category',
    },
    'customers': [
      {
        'rank': 1,
        'customerName': 'Marine Equipment',
        'region': 'Core',
        'totalOrders': 2847,
        'percentageChange': 22.4,
        'totalValue': 5908,
        'averageOrderValue': 2,
        'satisfactionScore': 4.8,
      },
      {
        'rank': 2,
        'customerName': 'Electronics',
        'region': 'Technology',
        'totalOrders': 2268,
        'percentageChange': 18.6,
        'totalValue': 4800,
        'averageOrderValue': 2,
        'satisfactionScore': 4.7,
      },
    ],
  },
  'productPerformance': {
    'header': {
      'title': 'Custom Requirements',
      'subtitle': 'Top custom product requests',
    },
    'products': [
      {
        'rank': 1,
        'productName': 'Custom Navigation Integration',
        'category': 'Electronics',
        'unitsSold': 142,
        'percentageChange': 32.4,
        'revenue': 428000,
        'averagePrice': 3014,
        'stockStatus': 'Custom',
      },
      {
        'rank': 2,
        'productName': 'Modified Safety System',
        'category': 'Safety',
        'unitsSold': 98,
        'percentageChange': 28.6,
        'revenue': 294000,
        'averagePrice': 3000,
        'stockStatus': 'Custom',
      },
    ],
  },
};

/// Catalogue Dashboard (Enhanced) - Production Ready
///
/// Features:
/// - Comprehensive catalogue metrics
/// - Product growth tracking (new vs discontinued)
/// - Category performance analysis
/// - Client utilization breakdown
/// - Custom requirements tracking
/// - Search analytics
/// - Stock level monitoring
/// - Top product rankings
/// - Category health metrics
/// - Low-performing category identification
class CatalogueDashboard extends StatelessWidget {
  const CatalogueDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        // color: context.theme.colorScheme.background,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: ResponsiveGridRow(
          children: [
            // KPI Cards
            DashboardGridCol(
              xs: 12,
              md: 8,
              child: DashboardCardContainer(cards: _catalogueCards),
            ),

            // Product Breakdown
            DashboardGridCol(
              xs: 12,
              md: 4,
              child: DashboardRecentData(data: _catalogueProductBreakdown),
            ),

            // Catalogue Growth Line Chart
            DashboardGridCol(
              xs: 12,
              md: 5,
              child: RevenueGeneratedCard(chartData: _catalogueGrowthChart),
            ),

            // Client Type Utilization Pie Chart
            DashboardGridCol(
              xs: 12,
              md: 3,
              child: DashboardPieChart(data: _clientTypePieData),
            ),

            // Catalogue Utilization Card
            DashboardGridCol(
              xs: 12,
              md: 4,
              child: DashboardFinancialCard(data: _catalogueUtilizationCard),
            ),

            // Category Performance
            DashboardGridCol(
              xs: 12,
              md: 6,
              child: DashboardcombobarChart(data: _categoryPerformanceCombo),
            ),

            // Custom Requirements & Search Analytics
            DashboardGridCol(
              xs: 12,
              md: 6,
              child: MultiAnalyticsOveriview(
                data: _customRequirementsComparison,
              ),
            ),

            // Orders by Category Bar Chart
            DashboardGridCol(
              xs: 12,
              child: DashboardBarChart(data: _ordersByCategoryBar),
            ),

            // Catalogue Insights Cards
            DashboardGridCol(
              xs: 12,
              md: 6,
              lg: 4,
              child: DashboardLeadingPort(data: _catalogueInsights[0]),
            ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              lg: 4,
              child: DashboardLeadingPort(data: _catalogueInsights[1]),
            ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              lg: 4,
              child: DashboardLeadingPort(data: _catalogueInsights[2]),
            ),

            // Multi-Tab Table (Products, New Items, Stock, Discontinued, etc.)
            DashboardGridCol(
              xs: 12,
              child: DashboardTable(data: _catalogueTableData),
            ),
          ],
        ),
      ),
    );
  }
}
