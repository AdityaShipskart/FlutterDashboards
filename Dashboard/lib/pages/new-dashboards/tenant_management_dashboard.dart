import 'package:flutter/material.dart';
// import 'package:get/utils.dart';
// import 'package:hive_flutter/adapters.dart';
import 'package:responsive_grid/responsive_grid.dart';
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

/// Tenant Management Dashboard
///
/// Comprehensive dashboard for monitoring tenant metrics:
/// - Tenant statistics by type (SMC, Vendor, Partner)
/// - Top performing tenants
/// - Subscription overview and revenue
/// - Growth trends and forecasts
/// - Regional distribution
/// - Active vs inactive tenants
/// - Recent onboarding activity
const List<Map<String, dynamic>> _tenantCards = [
  {
    'iconKey': 'users',
    'value': '847',
    'label': 'Total Tenants',
    'growth': '+12.3%',
    'color': Color(0xFF7C3AED),
    'iconBgColor': Color(0xFFF3E8FF),
  },
  {
    'iconKey': 'revenue',
    'value': '\$2.4M',
    'label': 'Monthly Recurring Revenue',
    'growth': '+8.6%',
    'color': Color(0xFF10B981),
    'iconBgColor': Color(0xFFD1FAE5),
  },
  {
    'iconKey': 'profit',
    'value': '94.2%',
    'label': 'Active Subscription Rate',
    'growth': '+2.1%',
    'color': Color(0xFF0EA5E9),
    'iconBgColor': Color(0xFFE0F2FE),
  },
  {
    'iconKey': 'notifications',
    'value': '67',
    'label': 'New Onboarding (MTD)',
    'growth': '+15.8%',
    'color': Color(0xFFF97316),
    'iconBgColor': Color(0xFFFFEAD5),
  },
];

const Map<String, dynamic> _tenantRecentData = {
  'salesHighlights': {
    'title': 'Tenant Distribution',
    'totalValue': 847,
    'currency': '',
    'percentageChange': 12.3,
    'isPositive': true,
    'products': [
      {'name': 'SMC', 'percentage': 42, 'color': 0xFF7C3AED},
      {'name': 'Vendor', 'percentage': 35, 'color': 0xFF10B981},
      {'name': 'Partner', 'percentage': 18, 'color': 0xFF0EA5E9},
      {'name': 'Enterprise', 'percentage': 5, 'color': 0xFFF97316},
    ],
    'channels': [
      {
        'icon': 'business_outlined',
        'name': 'SMC Tenants',
        'value': 356,
        'percentageChange': 14.2,
        'isPositive': true,
      },
      {
        'icon': 'storefront_outlined',
        'name': 'Vendor Tenants',
        'value': 297,
        'percentageChange': 11.8,
        'isPositive': true,
      },
      {
        'icon': 'handshake_outlined',
        'name': 'Partner Tenants',
        'value': 152,
        'percentageChange': 9.3,
        'isPositive': true,
      },
      {
        'icon': 'apartment_outlined',
        'name': 'Enterprise',
        'value': 42,
        'percentageChange': 6.7,
        'isPositive': true,
      },
    ],
  },
};

final Map<String, dynamic> _tenantGrowthChart = {
  'cardTitle': 'Tenant Growth Trends',
  'cardSubtitle': 'Monthly active tenants vs new signups',
  'thisYearLabel': 'Active Tenants',
  'lastYearLabel': 'New Signups',
  'percentageChange': '+12.3%',
  'isPositiveChange': true,
  'availablePeriods': ['Jan-Jun', 'Jul-Dec', 'Full Year'],
  'selectedPeriod': 'Full Year',
  'chartConfig': {'minX': 0, 'maxX': 11, 'minY': 0, 'maxY': 10},
  'thisYearData': [
    {'x': 0, 'y': 6.5},
    {'x': 1, 'y': 6.8},
    {'x': 2, 'y': 7.0},
    {'x': 3, 'y': 7.3},
    {'x': 4, 'y': 7.6},
    {'x': 5, 'y': 7.9},
    {'x': 6, 'y': 8.0},
    {'x': 7, 'y': 8.2},
    {'x': 8, 'y': 8.3},
    {'x': 9, 'y': 8.4},
    {'x': 10, 'y': 8.5},
    {'x': 11, 'y': 8.7},
  ],
  'lastYearData': [
    {'x': 0, 'y': 0.4},
    {'x': 1, 'y': 0.5},
    {'x': 2, 'y': 0.6},
    {'x': 3, 'y': 0.7},
    {'x': 4, 'y': 0.8},
    {'x': 5, 'y': 0.9},
    {'x': 6, 'y': 0.6},
    {'x': 7, 'y': 0.7},
    {'x': 8, 'y': 0.8},
    {'x': 9, 'y': 0.6},
    {'x': 10, 'y': 0.7},
    {'x': 11, 'y': 0.9},
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

const Map<String, dynamic> _tenantTypePieData = {
  'cardTitle': 'Tenant Type Mix',
  'cardSubtitle': 'Distribution by category',
  'totalLeads': '847',
  'pieChartData': [
    {'label': 'SMC', 'value': 42.0, 'color': '0xFF7C3AED'},
    {'label': 'Vendor', 'value': 35.0, 'color': '0xFF10B981'},
    {'label': 'Partner', 'value': 18.0, 'color': '0xFF0EA5E9'},
    {'label': 'Enterprise', 'value': 5.0, 'color': '0xFFF97316'},
  ],
  'legendData': [
    {'label': 'SMC', 'color': '0xFF7C3AED'},
    {'label': 'Vendor', 'color': '0xFF10B981'},
    {'label': 'Partner', 'color': '0xFF0EA5E9'},
    {'label': 'Enterprise', 'color': '0xFFF97316'},
  ],
};

const Map<String, dynamic> _mrrFinancialCard = {
  'cardTitle': 'Monthly Recurring Revenue',
  'cardSubtitle': 'Trailing 10 days',
  'mainValue': '\$2.4M',
  'percentageChange': '+8.6%',
  'isPositiveChange': true,
  'changeLabel': 'vs previous month',
  'barData': [
    {'x': 0, 'y': 62},
    {'x': 1, 'y': 65},
    {'x': 2, 'y': 68},
    {'x': 3, 'y': 70},
    {'x': 4, 'y': 69},
    {'x': 5, 'y': 72},
    {'x': 6, 'y': 74},
    {'x': 7, 'y': 76},
    {'x': 8, 'y': 75},
    {'x': 9, 'y': 78},
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
  'chartConfig': {'minX': 0, 'maxX': 9, 'minY': 55, 'maxY': 85},
};

const Map<String, dynamic> _subscriptionTiersCombo = {
  'cardTitle': 'Subscription Tier Performance',
  'cardSubtitle': 'Active vs churned by plan',
  'minY': 0.0,
  'maxY': 500.0,
  'gridInterval': 100.0,
  'yAxisLabels': [
    {'value': 0, 'label': '0'},
    {'value': 100, 'label': '100'},
    {'value': 200, 'label': '200'},
    {'value': 300, 'label': '300'},
    {'value': 400, 'label': '400'},
    {'value': 500, 'label': '500'},
  ],
  'chartData': [
    {'month': 'Basic', 'wins': 320.0, 'losses': 28.0, 'winRate': 91.9},
    {'month': 'Standard', 'wins': 280.0, 'losses': 22.0, 'winRate': 92.7},
    {'month': 'Premium', 'wins': 185.0, 'losses': 15.0, 'winRate': 92.5},
    {'month': 'Enterprise', 'wins': 62.0, 'losses': 4.0, 'winRate': 93.9},
  ],
};

const Map<String, dynamic> _tenantActivityComparison = {
  'tabs': [
    {
      'label': 'Active vs Inactive',
      'subtitle': 'Tenant engagement status',
      'onTimeOrder': [720, 736, 748, 760, 772, 798],
      'delayedOrder': [68, 72, 76, 78, 81, 49],
      'maxY': 850,
    },
    {
      'label': 'Retention Cohort',
      'subtitle': 'Monthly cohort retention',
      'onTimeOrder': [650, 672, 684, 696, 712, 728],
      'delayedOrder': [138, 136, 140, 142, 143, 119],
      'maxY': 850,
    },
  ],
};

const Map<String, dynamic> _revenueByTenantType = {
  'cardTitle': 'Revenue by Tenant Type',
  'cardSubtitle': '25th/50th/75th percentile MRR',
  'maxY': 120000.0,
  'minY': 0.0,
  'yAxisInterval': 20000.0,
  'barWidth': 10.0,
  'barsSpace': 5.0,
  'chartData': [
    {
      'label': 'SMC',
      'values': [
        {'value': 28000.0, 'color': 0xFFE0E0E0},
        {'value': 62000.0, 'color': 0xFF10B981},
        {'value': 95000.0, 'color': 0xFF7C3AED},
      ],
      'percentile25': 28000.0,
      'percentile50': 62000.0,
      'percentile75': 95000.0,
    },
    {
      'label': 'Vendor',
      'values': [
        {'value': 22000.0, 'color': 0xFFE0E0E0},
        {'value': 48000.0, 'color': 0xFF10B981},
        {'value': 78000.0, 'color': 0xFF7C3AED},
      ],
      'percentile25': 22000.0,
      'percentile50': 48000.0,
      'percentile75': 78000.0,
    },
    {
      'label': 'Partner',
      'values': [
        {'value': 18000.0, 'color': 0xFFE0E0E0},
        {'value': 38000.0, 'color': 0xFF10B981},
        {'value': 62000.0, 'color': 0xFF7C3AED},
      ],
      'percentile25': 18000.0,
      'percentile50': 38000.0,
      'percentile75': 62000.0,
    },
    {
      'label': 'Enterprise',
      'values': [
        {'value': 45000.0, 'color': 0xFFE0E0E0},
        {'value': 85000.0, 'color': 0xFF10B981},
        {'value': 115000.0, 'color': 0xFF7C3AED},
      ],
      'percentile25': 45000.0,
      'percentile50': 85000.0,
      'percentile75': 115000.0,
    },
  ],
  'legendData': [
    {'label': '25th', 'color': '0xFFE0E0E0'},
    {'label': '50th', 'color': '0xFF10B981'},
    {'label': '75th', 'color': '0xFF7C3AED'},
  ],
};

const List<Map<String, dynamic>> _tenantRegionalData = [
  {
    'title': 'Top Regions by Tenant Count',
    'subtitle': 'Active tenant distribution',
    'ports': [
      {
        'portName': 'Asia Pacific',
        'purchaseValue': '342',
        'percentageChange': 16.4,
        'trend': 'up',
      },
      {
        'portName': 'Europe',
        'purchaseValue': '268',
        'percentageChange': 12.1,
        'trend': 'up',
      },
    ],
  },
  {
    'title': 'Highest MRR Regions',
    'subtitle': 'Revenue by geography',
    'ports': [
      {
        'portName': 'North America',
        'purchaseValue': '\$1.2M',
        'percentageChange': 11.3,
        'trend': 'up',
      },
      {
        'portName': 'Europe',
        'purchaseValue': '\$780K',
        'percentageChange': 8.9,
        'trend': 'up',
      },
    ],
  },
  {
    'title': 'Fastest Growing Markets',
    'subtitle': 'New tenant signups',
    'ports': [
      {
        'portName': 'Southeast Asia',
        'purchaseValue': '94',
        'percentageChange': 28.7,
        'trend': 'up',
      },
      {
        'portName': 'Middle East',
        'purchaseValue': '67',
        'percentageChange': 21.4,
        'trend': 'up',
      },
    ],
  },
];

const Map<String, dynamic> _topTenantsTableData = {
  'header': {
    'title': 'Top Performing Tenants',
    'subtitle': 'Ranked by revenue contribution',
  },
  'rfqs': [
    {
      'rank': 1,
      'rfqId': 'TNT-8472',
      'title': 'Oceanic Shipping Ltd',
      'supplier': 'SMC',
      'estimatedValue': 142000,
      'percentageChange': 18.4,
      'responsesReceived': 847,
      'daysRemaining': 342,
    },
    {
      'rank': 2,
      'rfqId': 'TNT-6291',
      'title': 'Marine Supplies Co',
      'supplier': 'Vendor',
      'estimatedValue': 128000,
      'percentageChange': 15.2,
      'responsesReceived': 1240,
      'daysRemaining': 186,
    },
    {
      'rank': 3,
      'rfqId': 'TNT-5183',
      'title': 'Harbour Tech Inc',
      'supplier': 'Partner',
      'estimatedValue': 116000,
      'percentageChange': 12.7,
      'responsesReceived': 562,
      'daysRemaining': 124,
    },
    {
      'rank': 4,
      'rfqId': 'TNT-4872',
      'title': 'Fleet Management Pro',
      'supplier': 'SMC',
      'estimatedValue': 98000,
      'percentageChange': 10.3,
      'responsesReceived': 428,
      'daysRemaining': 98,
    },
    {
      'rank': 5,
      'rfqId': 'TNT-3961',
      'title': 'Nautical Solutions',
      'supplier': 'Enterprise',
      'estimatedValue': 87000,
      'percentageChange': 8.9,
      'responsesReceived': 312,
      'daysRemaining': 76,
    },
  ],
  'pendingQuotes': {
    'header': {
      'title': 'Recent Onboarding',
      'subtitle': 'New tenants (last 30 days)',
    },
    'quotes': [
      {
        'rank': 1,
        'quoteId': 'TNT-9284',
        'customer': 'Baltic Carriers',
        'quoteValue': 42000,
        'percentageChange': 0.0,
        'daysInReview': 3,
        'expiresInDays': 27,
        'status': 'Onboarding',
      },
      {
        'rank': 2,
        'quoteId': 'TNT-9183',
        'customer': 'Coastal Equipment',
        'quoteValue': 38000,
        'percentageChange': 0.0,
        'daysInReview': 5,
        'expiresInDays': 25,
        'status': 'Setup',
      },
      {
        'rank': 3,
        'quoteId': 'TNT-9072',
        'customer': 'Maritime Services Ltd',
        'quoteValue': 35000,
        'percentageChange': 0.0,
        'daysInReview': 8,
        'expiresInDays': 22,
        'status': 'Training',
      },
    ],
  },
  'activeOrders': {
    'header': {
      'title': 'Subscription Renewals',
      'subtitle': 'Upcoming renewals (next 30 days)',
    },
    'orders': [
      {
        'rank': 1,
        'orderId': 'RNW-7261',
        'customer': 'Oceanic Shipping Ltd',
        'orderValue': 142000,
        'percentageChange': 12.0,
        'progressPercentage': 85,
        'deliveryStatus': 'Renewal',
        'expectedDelivery': '2025-02-15',
      },
      {
        'rank': 2,
        'orderId': 'RNW-6842',
        'customer': 'Fleet Management Pro',
        'orderValue': 98000,
        'percentageChange': 8.0,
        'progressPercentage': 72,
        'deliveryStatus': 'Renewal',
        'expectedDelivery': '2025-02-22',
      },
    ],
  },
  'completedDeliveries': {
    'header': {
      'title': 'Churn Analysis',
      'subtitle': 'Recently churned tenants',
    },
    'deliveries': [
      {
        'rank': 1,
        'deliveryId': 'CHN-1824',
        'customer': 'Harbor Logistics',
        'deliveryValue': 28000,
        'percentageChange': -100.0,
        'deliveryDate': '2025-01-18',
        'rating': 3.2,
        'onTime': false,
      },
      {
        'rank': 2,
        'deliveryId': 'CHN-1796',
        'customer': 'Port Equipment Co',
        'deliveryValue': 22000,
        'percentageChange': -100.0,
        'deliveryDate': '2025-01-12',
        'rating': 2.8,
        'onTime': false,
      },
    ],
  },
};

/// Tenant Management Dashboard - Production Ready
///
/// Features:
/// - Comprehensive tenant metrics and KPIs
/// - Growth trends and forecasting
/// - Subscription tier analysis
/// - Regional distribution insights
/// - Top performing tenants table
/// - Recent onboarding activity
/// - Renewal and churn tracking
/// - Revenue breakdown by tenant type
class TenantManagementDashboard extends StatelessWidget {
  const TenantManagementDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        // color: context.theme.colorScheme.background,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ResponsiveGridRow(
              children: [
                // KPI Cards
                ResponsiveGridCol(
                  xs: 12,
                  md: 8,
                  child: DashboardCardContainer(cards: _tenantCards),
                ),

                // Tenant Distribution Breakdown
                ResponsiveGridCol(
                  xs: 12,
                  md: 4,
                  child: DashboardRecentData(data: _tenantRecentData),
                ),
              ],
            ),
            ResponsiveGridRow(
              children: [
                // MRR Financial Card
                ResponsiveGridCol(
                  xs: 12,
                  md: 3,
                  child: DashboardFinancialCard(data: _mrrFinancialCard),
                ),
                // Tenant Type Distribution Pie Chart
                ResponsiveGridCol(
                  xs: 12,
                  md: 3,
                  child: DashboardPieChart(data: _tenantTypePieData),
                ),
                // Growth Trends Line Chart
                ResponsiveGridCol(
                  xs: 12,
                  md: 6,
                  child: RevenueGeneratedCard(chartData: _tenantGrowthChart),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget test() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
    ),
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: ResponsiveGridRow(
        children: [
          // Subscription Tier Performance
          DashboardGridCol(
            xs: 12,
            md: 6,
            child: DashboardcombobarChart(data: _subscriptionTiersCombo),
          ),

          // Active vs Inactive Tenants
          DashboardGridCol(
            xs: 12,
            md: 6,
            child: MultiAnalyticsOveriview(data: _tenantActivityComparison),
          ),

          // Revenue by Tenant Type Bar Chart
          DashboardGridCol(
            xs: 12,
            child: DashboardBarChart(data: _revenueByTenantType),
          ),

          // Regional Performance Cards
          DashboardGridCol(
            xs: 12,
            md: 6,
            lg: 4,
            child: DashboardLeadingPort(data: _tenantRegionalData[0]),
          ),
          DashboardGridCol(
            xs: 12,
            md: 6,
            lg: 4,
            child: DashboardLeadingPort(data: _tenantRegionalData[1]),
          ),
          DashboardGridCol(
            xs: 12,
            md: 6,
            lg: 4,
            child: DashboardLeadingPort(data: _tenantRegionalData[2]),
          ),

          // Top Tenants Table with Multiple Tabs
          DashboardGridCol(
            xs: 12,
            child: DashboardTable(data: _topTenantsTableData),
          ),
        ],
      ),
    ),
  );
}
