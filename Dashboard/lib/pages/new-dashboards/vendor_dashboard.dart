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

/// Vendor Dashboard
///
/// Comprehensive dashboard for vendor operations:
/// - Product catalog metrics
/// - Active RFQs and quotes
/// - Order fulfillment tracking
/// - Revenue and sales trends
/// - Top customers (buyers/SMCs)
/// - Category performance
/// - Delivery analytics
/// - Client relationship metrics
const List<Map<String, dynamic>> _vendorCards = [
  {
    'iconKey': 'orders',
    'value': '3,847',
    'label': 'Active Product Listings',
    'growth': '+142',
    'color': Color(0xFFEC4899),
    'iconBgColor': Color(0xFFFDE0F0),
  },
  {
    'iconKey': 'users',
    'value': '268',
    'label': 'Active Clients',
    'growth': '+18.3%',
    'color': Color(0xFF7C3AED),
    'iconBgColor': Color(0xFFF3E8FF),
  },
  {
    'iconKey': 'revenue',
    'value': '\$4.8M',
    'label': 'Monthly Revenue',
    'growth': '+12.6%',
    'color': Color(0xFF10B981),
    'iconBgColor': Color(0xFFD1FAE5),
  },
  {
    'iconKey': 'profit',
    'value': '94.8%',
    'label': 'On-Time Delivery Rate',
    'growth': '+2.4%',
    'color': Color(0xFF0EA5E9),
    'iconBgColor': Color(0xFFE0F2FE),
  },
];

const Map<String, dynamic> _vendorSalesBreakdown = {
  'salesHighlights': {
    'title': 'Sales by Category',
    'totalValue': 4800000,
    'currency': '\$',
    'percentageChange': 12.6,
    'isPositive': true,
    'products': [
      {'name': 'Marine Parts', 'percentage': 36, 'color': 0xFFEC4899},
      {'name': 'Electronics', 'percentage': 28, 'color': 0xFF7C3AED},
      {'name': 'Safety Gear', 'percentage': 22, 'color': 0xFF10B981},
      {'name': 'Other', 'percentage': 14, 'color': 0xFF0EA5E9},
    ],
    'channels': [
      {
        'icon': 'build_outlined',
        'name': 'Marine Parts',
        'value': 1728000,
        'percentageChange': 14.8,
        'isPositive': true,
      },
      {
        'icon': 'devices_outlined',
        'name': 'Electronics',
        'value': 1344000,
        'percentageChange': 11.2,
        'isPositive': true,
      },
      {
        'icon': 'shield_outlined',
        'name': 'Safety Equipment',
        'value': 1056000,
        'percentageChange': 13.4,
        'isPositive': true,
      },
      {
        'icon': 'inventory_outlined',
        'name': 'Other Products',
        'value': 672000,
        'percentageChange': 9.6,
        'isPositive': true,
      },
    ],
  },
};

final Map<String, dynamic> _vendorRevenueChart = {
  'cardTitle': 'Revenue Trends',
  'cardSubtitle': 'Monthly revenue vs target',
  'thisYearLabel': 'Actual Revenue',
  'lastYearLabel': 'Target',
  'percentageChange': '+12.6%',
  'isPositiveChange': true,
  'availablePeriods': ['Jan-Jun', 'Jul-Dec', 'Full Year'],
  'selectedPeriod': 'Full Year',
  'chartConfig': {'minX': 0, 'maxX': 11, 'minY': 2, 'maxY': 8},
  'thisYearData': [
    {'x': 0, 'y': 3.8},
    {'x': 1, 'y': 4.1},
    {'x': 2, 'y': 4.3},
    {'x': 3, 'y': 4.5},
    {'x': 4, 'y': 4.7},
    {'x': 5, 'y': 4.9},
    {'x': 6, 'y': 4.6},
    {'x': 7, 'y': 4.8},
    {'x': 8, 'y': 4.8},
    {'x': 9, 'y': 5.0},
    {'x': 10, 'y': 5.2},
    {'x': 11, 'y': 5.4},
  ],
  'lastYearData': [
    {'x': 0, 'y': 4.2},
    {'x': 1, 'y': 4.2},
    {'x': 2, 'y': 4.2},
    {'x': 3, 'y': 4.2},
    {'x': 4, 'y': 4.2},
    {'x': 5, 'y': 4.2},
    {'x': 6, 'y': 4.2},
    {'x': 7, 'y': 4.2},
    {'x': 8, 'y': 4.2},
    {'x': 9, 'y': 4.2},
    {'x': 10, 'y': 4.2},
    {'x': 11, 'y': 4.2},
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
  'cardTitle': 'Client Distribution',
  'cardSubtitle': 'Revenue by client type',
  'totalLeads': '268',
  'pieChartData': [
    {'label': 'SMC', 'value': 48.0, 'color': '0xFFEC4899'},
    {'label': 'Direct', 'value': 32.0, 'color': '0xFF7C3AED'},
    {'label': 'Partner', 'value': 15.0, 'color': '0xFF10B981'},
    {'label': 'Retail', 'value': 5.0, 'color': '0xFF0EA5E9'},
  ],
  'legendData': [
    {'label': 'SMC', 'color': '0xFFEC4899'},
    {'label': 'Direct', 'color': '0xFF7C3AED'},
    {'label': 'Partner', 'color': '0xFF10B981'},
    {'label': 'Retail', 'color': '0xFF0EA5E9'},
  ],
};

const Map<String, dynamic> _avgOrderValueCard = {
  'cardTitle': 'Average Order Value',
  'cardSubtitle': 'Trailing 10 days',
  'mainValue': '\$18.6K',
  'percentageChange': '+6.8%',
  'isPositiveChange': true,
  'changeLabel': 'vs previous period',
  'barData': [
    {'x': 0, 'y': 54},
    {'x': 1, 'y': 58},
    {'x': 2, 'y': 61},
    {'x': 3, 'y': 64},
    {'x': 4, 'y': 62},
    {'x': 5, 'y': 66},
    {'x': 6, 'y': 68},
    {'x': 7, 'y': 71},
    {'x': 8, 'y': 69},
    {'x': 9, 'y': 73},
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
  'chartConfig': {'minX': 0, 'maxX': 9, 'minY': 50, 'maxY': 80},
};

const Map<String, dynamic> _orderFulfillmentCombo = {
  'cardTitle': 'Order Fulfillment',
  'cardSubtitle': 'Completed vs pending orders',
  'minY': 0.0,
  'maxY': 400.0,
  'gridInterval': 80.0,
  'yAxisLabels': [
    {'value': 0, 'label': '0'},
    {'value': 80, 'label': '80'},
    {'value': 160, 'label': '160'},
    {'value': 240, 'label': '240'},
    {'value': 320, 'label': '320'},
    {'value': 400, 'label': '400'},
  ],
  'chartData': [
    {'month': 'Jan', 'wins': 284.0, 'losses': 42.0, 'winRate': 87.1},
    {'month': 'Feb', 'wins': 306.0, 'losses': 38.0, 'winRate': 89.0},
    {'month': 'Mar', 'wins': 328.0, 'losses': 34.0, 'winRate': 90.6},
    {'month': 'Apr', 'wins': 342.0, 'losses': 32.0, 'winRate': 91.4},
    {'month': 'May', 'wins': 358.0, 'losses': 28.0, 'winRate': 92.7},
    {'month': 'Jun', 'wins': 372.0, 'losses': 24.0, 'winRate': 93.9},
  ],
};

const Map<String, dynamic> _deliveryPerformanceComparison = {
  'tabs': [
    {
      'label': 'Delivery Performance',
      'subtitle': 'On-time vs delayed deliveries',
      'onTimeOrder': [268, 284, 296, 312, 328, 342],
      'delayedOrder': [18, 16, 14, 12, 10, 8],
      'maxY': 360,
    },
    {
      'label': 'Quote Conversion',
      'subtitle': 'RFQ to order conversion rate',
      'onTimeOrder': [142, 156, 168, 178, 192, 206],
      'delayedOrder': [68, 64, 58, 54, 48, 42],
      'maxY': 220,
    },
  ],
};

const Map<String, dynamic> _categoryRevenueBar = {
  'cardTitle': 'Revenue by Category',
  'cardSubtitle': '25th/50th/75th percentile order values',
  'maxY': 280000.0,
  'minY': 0.0,
  'yAxisInterval': 50000.0,
  'barWidth': 10.0,
  'barsSpace': 5.0,
  'chartData': [
    {
      'label': 'Marine Parts',
      'values': [
        {'value': 62000.0, 'color': 0xFFE0E0E0},
        {'value': 128000.0, 'color': 0xFF10B981},
        {'value': 198000.0, 'color': 0xFFEC4899},
      ],
      'percentile25': 62000.0,
      'percentile50': 128000.0,
      'percentile75': 198000.0,
    },
    {
      'label': 'Electronics',
      'values': [
        {'value': 48000.0, 'color': 0xFFE0E0E0},
        {'value': 98000.0, 'color': 0xFF10B981},
        {'value': 156000.0, 'color': 0xFFEC4899},
      ],
      'percentile25': 48000.0,
      'percentile50': 98000.0,
      'percentile75': 156000.0,
    },
    {
      'label': 'Safety Gear',
      'values': [
        {'value': 38000.0, 'color': 0xFFE0E0E0},
        {'value': 78000.0, 'color': 0xFF10B981},
        {'value': 126000.0, 'color': 0xFFEC4899},
      ],
      'percentile25': 38000.0,
      'percentile50': 78000.0,
      'percentile75': 126000.0,
    },
    {
      'label': 'Consumables',
      'values': [
        {'value': 28000.0, 'color': 0xFFE0E0E0},
        {'value': 58000.0, 'color': 0xFF10B981},
        {'value': 92000.0, 'color': 0xFFEC4899},
      ],
      'percentile25': 28000.0,
      'percentile50': 58000.0,
      'percentile75': 92000.0,
    },
  ],
  'legendData': [
    {'label': '25th', 'color': '0xFFE0E0E0'},
    {'label': '50th', 'color': '0xFF10B981'},
    {'label': '75th', 'color': '0xFFEC4899'},
  ],
};

const List<Map<String, dynamic>> _vendorPerformanceMetrics = [
  {
    'title': 'Top Buyers (SMC)',
    'subtitle': 'Highest revenue SMC clients',
    'ports': [
      {
        'portName': 'Oceanic Shipping Ltd',
        'purchaseValue': '\$684K',
        'percentageChange': 16.8,
        'trend': 'up',
      },
      {
        'portName': 'Fleet Management Pro',
        'purchaseValue': '\$542K',
        'percentageChange': 14.2,
        'trend': 'up',
      },
    ],
  },
  {
    'title': 'Top Products',
    'subtitle': 'Best selling items',
    'ports': [
      {
        'portName': 'Engine Parts Kit',
        'purchaseValue': '\$428K',
        'percentageChange': 18.4,
        'trend': 'up',
      },
      {
        'portName': 'Navigation System',
        'purchaseValue': '\$386K',
        'percentageChange': 15.7,
        'trend': 'up',
      },
    ],
  },
  {
    'title': 'Growth Opportunities',
    'subtitle': 'Emerging product categories',
    'ports': [
      {
        'portName': 'Eco-Friendly Parts',
        'purchaseValue': '\$142K',
        'percentageChange': 34.6,
        'trend': 'up',
      },
      {
        'portName': 'Smart Monitoring',
        'purchaseValue': '\$128K',
        'percentageChange': 28.9,
        'trend': 'up',
      },
    ],
  },
];

const Map<String, dynamic> _vendorTableData = {
  'header': {
    'title': 'Pending RFQs',
    'subtitle': 'Active requests for quotations',
  },
  'rfqs': [
    {
      'rank': 1,
      'rfqId': 'RFQ-8472',
      'title': 'Engine Spare Parts',
      'supplier': 'Oceanic Shipping Ltd',
      'estimatedValue': 142000,
      'percentageChange': 0.0,
      'responsesReceived': 1,
      'daysRemaining': 5,
    },
    {
      'rank': 2,
      'rfqId': 'RFQ-8461',
      'title': 'Navigation Equipment',
      'supplier': 'Fleet Management Pro',
      'estimatedValue': 98000,
      'percentageChange': 0.0,
      'responsesReceived': 1,
      'daysRemaining': 7,
    },
    {
      'rank': 3,
      'rfqId': 'RFQ-8448',
      'title': 'Safety Equipment',
      'supplier': 'Maritime Services Ltd',
      'estimatedValue': 76000,
      'percentageChange': 0.0,
      'responsesReceived': 1,
      'daysRemaining': 3,
    },
    {
      'rank': 4,
      'rfqId': 'RFQ-8432',
      'title': 'Deck Equipment',
      'supplier': 'Harbor Tech Inc',
      'estimatedValue': 58000,
      'percentageChange': 0.0,
      'responsesReceived': 1,
      'daysRemaining': 6,
    },
  ],
  'pendingQuotes': {
    'header': {
      'title': 'Submitted Quotes',
      'subtitle': 'Awaiting customer decision',
    },
    'quotes': [
      {
        'rank': 1,
        'quoteId': 'QT-7284',
        'customer': 'Oceanic Shipping Ltd',
        'quoteValue': 128000,
        'percentageChange': 0.0,
        'daysInReview': 3,
        'expiresInDays': 12,
        'status': 'Under Review',
      },
      {
        'rank': 2,
        'quoteId': 'QT-7268',
        'customer': 'Fleet Management Pro',
        'quoteValue': 92000,
        'percentageChange': 0.0,
        'daysInReview': 5,
        'expiresInDays': 10,
        'status': 'Under Review',
      },
    ],
  },
  'activeOrders': {
    'header': {
      'title': 'Active Orders',
      'subtitle': 'Processing and in-transit',
    },
    'orders': [
      {
        'rank': 1,
        'orderId': 'ORD-6842',
        'customer': 'Oceanic Shipping Ltd',
        'orderValue': 284000,
        'percentageChange': 0.0,
        'progressPercentage': 78,
        'deliveryStatus': 'In Transit',
        'expectedDelivery': '2025-02-15',
      },
      {
        'rank': 2,
        'orderId': 'ORD-6821',
        'customer': 'Fleet Management Pro',
        'orderValue': 196000,
        'percentageChange': 0.0,
        'progressPercentage': 85,
        'deliveryStatus': 'Processing',
        'expectedDelivery': '2025-02-10',
      },
    ],
  },
  'completedDeliveries': {
    'header': {'title': 'Recent Deliveries', 'subtitle': 'Last 7 days'},
    'deliveries': [
      {
        'rank': 1,
        'deliveryId': 'DEL-5928',
        'customer': 'Oceanic Shipping Ltd',
        'deliveryValue': 168000,
        'percentageChange': 0.0,
        'deliveryDate': '2025-01-28',
        'rating': 4.9,
        'onTime': true,
      },
      {
        'rank': 2,
        'deliveryId': 'DEL-5912',
        'customer': 'Maritime Services Ltd',
        'deliveryValue': 142000,
        'percentageChange': 0.0,
        'deliveryDate': '2025-01-26',
        'rating': 4.7,
        'onTime': true,
      },
    ],
  },
  'customerMetrics': {
    'header': {'title': 'Top Customers', 'subtitle': 'Highest value clients'},
    'customers': [
      {
        'rank': 1,
        'customerName': 'Oceanic Shipping Ltd',
        'region': 'Asia Pacific',
        'totalOrders': 142,
        'percentageChange': 16.8,
        'totalValue': 684000,
        'averageOrderValue': 4817,
        'satisfactionScore': 4.9,
      },
      {
        'rank': 2,
        'customerName': 'Fleet Management Pro',
        'region': 'Europe',
        'totalOrders': 128,
        'percentageChange': 14.2,
        'totalValue': 542000,
        'averageOrderValue': 4234,
        'satisfactionScore': 4.7,
      },
    ],
  },
  'productPerformance': {
    'header': {
      'title': 'Product Performance',
      'subtitle': 'Top selling products',
    },
    'products': [
      {
        'rank': 1,
        'productName': 'Engine Parts Kit',
        'category': 'Marine Parts',
        'unitsSold': 842,
        'percentageChange': 18.4,
        'revenue': 428000,
        'averagePrice': 508,
        'stockStatus': 'In Stock',
      },
      {
        'rank': 2,
        'productName': 'Navigation System Pro',
        'category': 'Electronics',
        'unitsSold': 268,
        'percentageChange': 15.7,
        'revenue': 386000,
        'averagePrice': 1440,
        'stockStatus': 'In Stock',
      },
    ],
  },
};

/// Vendor Dashboard - Production Ready
///
/// Features:
/// - Product catalog and listing metrics
/// - Active client tracking
/// - Revenue and sales analytics
/// - Order fulfillment monitoring
/// - RFQ and quote management
/// - Top customers and products
/// - Category performance analysis
/// - Delivery tracking and ratings
/// - Growth opportunity identification
class VendorDashboard extends StatelessWidget {
  const VendorDashboard({super.key});

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
              child: DashboardCardContainer(cards: _vendorCards),
            ),

            // Sales Breakdown
            DashboardGridCol(
              xs: 12,
              md: 4,
              child: DashboardRecentData(data: _vendorSalesBreakdown),
            ),

            // Revenue Trend Line Chart
            DashboardGridCol(
              xs: 12,
              md: 5,
              child: RevenueGeneratedCard(chartData: _vendorRevenueChart),
            ),

            // Client Distribution Pie Chart
            DashboardGridCol(
              xs: 12,
              md: 3,
              child: DashboardPieChart(data: _clientTypePieData),
            ),

            // Average Order Value Card
            DashboardGridCol(
              xs: 12,
              md: 4,
              child: DashboardFinancialCard(data: _avgOrderValueCard),
            ),

            // Order Fulfillment
            DashboardGridCol(
              xs: 12,
              md: 6,
              child: DashboardcombobarChart(data: _orderFulfillmentCombo),
            ),

            // Delivery Performance Comparison
            DashboardGridCol(
              xs: 12,
              md: 6,
              child: MultiAnalyticsOveriview(
                data: _deliveryPerformanceComparison,
              ),
            ),

            // Revenue by Category Bar Chart
            DashboardGridCol(
              xs: 12,
              child: DashboardBarChart(data: _categoryRevenueBar),
            ),

            // Performance Metrics Cards
            DashboardGridCol(
              xs: 12,
              md: 6,
              lg: 4,
              child: DashboardLeadingPort(data: _vendorPerformanceMetrics[0]),
            ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              lg: 4,
              child: DashboardLeadingPort(data: _vendorPerformanceMetrics[1]),
            ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              lg: 4,
              child: DashboardLeadingPort(data: _vendorPerformanceMetrics[2]),
            ),

            // Multi-Tab Table (RFQs, Quotes, Orders, Deliveries, etc.)
            DashboardGridCol(
              xs: 12,
              child: DashboardTable(data: _vendorTableData),
            ),
          ],
        ),
      ),
    );
  }
}
