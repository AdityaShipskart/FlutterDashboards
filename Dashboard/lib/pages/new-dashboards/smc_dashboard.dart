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
import '../../widgets/dashboard_quick_wins.dart';
// import '../../widgets/dashboard_table.dart';

/// SMC (Ship Management Company) Dashboard
///
/// Comprehensive dashboard for SMC operations:
/// - Fleet and vessel management
/// - Crew statistics and manning
/// - Budget utilization and spend analysis
/// - Procurement tracking by category
/// - Vendor performance
/// - Pending requisitions
/// - Purchase order analysis
/// - Cost optimization insights
const List<Map<String, dynamic>> _smcCards = [
  {
    'iconKey': 'notifications',
    'value': '42',
    'label': 'Active Vessels',
    'growth': '+3',
    'color': Color(0xFF1379F0),
    'iconBgColor': Color(0xFFE0F2FE),
  },
  {
    'iconKey': 'users',
    'value': '1,247',
    'label': 'Total Crew Members',
    'growth': '+5.2%',
    'color': Color(0xFF7C3AED),
    'iconBgColor': Color(0xFFF3E8FF),
  },
  {
    'iconKey': 'revenue',
    'value': '100',
    'label': 'Active Requisitions',
    'growth': '-2.3%',
    'color': Color(0xFF10B981),
    'iconBgColor': Color(0xFFD1FAE5),
  },
  {
    'iconKey': 'revenue',
    'value': '100',
    'label': 'Pending RFQs',
    'growth': '-2.3%',
    'color': Color(0xFF10B981),
    'iconBgColor': Color(0xFFD1FAE5),
  },
  {
    'iconKey': 'orders',
    'value': '284',
    'label': 'Purchase Order',
    'growth': '+4.1%',
    'color': Color(0xFFF97316),
    'iconBgColor': Color(0xFFFFEAD5),
  },
  {
    'iconKey': 'orders',
    'value': '284',
    'label': 'GRN',
    'growth': '+4.1%',
    'color': Color(0xFFF97316),
    'iconBgColor': Color(0xFFFFEAD5),
  },
];

const Map<String, dynamic> _smcProcurementBreakdown = {
  'salesHighlights': {
    'title': 'Procurement by Category',
    'totalValue': 8600000,
    'currency': '\$',
    'percentageChange': -2.3,
    'isPositive': false,
    'products': [
      {'name': 'Spare Parts', 'percentage': 38, 'color': 0xFF1379F0},
      {'name': 'Fuel & Lube', 'percentage': 28, 'color': 0xFF7C3AED},
      {'name': 'Provisions', 'percentage': 18, 'color': 0xFF10B981},
      {'name': 'Services', 'percentage': 16, 'color': 0xFFF97316},
    ],
    'channels': [
      {
        'icon': 'build_outlined',
        'name': 'Spare Parts',
        'value': 3268000,
        'percentageChange': -1.8,
        'isPositive': false,
      },
      {
        'icon': 'local_gas_station_outlined',
        'name': 'Fuel & Lubricants',
        'value': 2408000,
        'percentageChange': -3.2,
        'isPositive': false,
      },
      {
        'icon': 'shopping_basket_outlined',
        'name': 'Provisions',
        'value': 1548000,
        'percentageChange': -1.4,
        'isPositive': false,
      },
      {
        'icon': 'engineering_outlined',
        'name': 'Technical Services',
        'value': 1376000,
        'percentageChange': -2.9,
        'isPositive': false,
      },
    ],
  },
};

final Map<String, dynamic> _smcSpendTrendChart = {
  'cardTitle': 'Spend Analysis',
  'cardSubtitle': 'Actual vs budgeted procurement spend',
  'thisYearLabel': 'Actual Spend',
  'lastYearLabel': 'Budget',
  'percentageChange': '-2.3%',
  'isPositiveChange': false,
  'availablePeriods': ['Jan-Jun', 'Jul-Dec', 'Full Year'],
  'selectedPeriod': 'Full Year',
  'chartConfig': {'minX': 0, 'maxX': 11, 'minY': 4, 'maxY': 12},
  // 'thisYearData': [
  //   {'x': 0, 'y': 10.8},
  //   {'x': 1, 'y': 4.2},
  //   {'x': 2, 'y': 7.6},
  //   {'x': 3, 'y': 6.4},
  //   {'x': 4, 'y': 4.1},
  //   {'x': 5, 'y': 9.9},
  //   {'x': 6, 'y': 4.3},
  //   {'x': 7, 'y': 2.7},
  //   {'x': 8, 'y': 6.6},
  //   {'x': 9, 'y': 8.5},
  //   {'x': 10, 'y': 9.8},
  //   {'x': 11, 'y': 6.6},
  // ],
  // 'lastYearData': [
  //   {'x': 0, 'y': 3.8},
  //   {'x': 1, 'y': 4.8},
  //   {'x': 2, 'y': 4.8},
  //   {'x': 3, 'y': 6.8},
  //   {'x': 4, 'y': 3.8},
  //   {'x': 5, 'y': 1.8},
  //   {'x': 6, 'y': 4.8},
  //   {'x': 7, 'y': 8.8},
  //   {'x': 8, 'y': 4.8},
  //   {'x': 9, 'y': 6.8},
  //   {'x': 10, 'y': 3.8},
  //   {'x': 11, 'y': 10.8},
  // ],
  'thisYearData': [
    {'x': 0, 'y': 4.5}, // Jan - Post-holiday, lower spend
    {'x': 1, 'y': 5.3}, // Feb - Ramping up
    {'x': 2, 'y': 5.8}, // Mar - Q1 close push
    {'x': 3, 'y': 6.2}, // Apr - New quarter start
    {'x': 4, 'y': 5.6}, // May - Moderate spending
    {'x': 5, 'y': 6.4}, // Jun - Q2 close, higher spend
    {'x': 6, 'y': 4.9}, // Jul - Mid-year slowdown
    {'x': 7, 'y': 5.1}, // Aug - Summer lull
    {'x': 8, 'y': 6.8}, // Sep - Q3 close surge
    {'x': 9, 'y': 7.0}, // Oct - Ramping to year-end
    {'x': 10, 'y': 7.6}, // Nov - Pre-holiday peak
    {'x': 11, 'y': 10.2}, // Dec - Year-end rush, budget flush
  ],
  'lastYearData': [
    {'x': 0, 'y': 5.0}, // Jan - Planned budget
    {'x': 1, 'y': 5.0}, // Feb - Consistent planning
    {'x': 2, 'y': 5.5}, // Mar - Q1 target increase
    {'x': 3, 'y': 5.8}, // Apr - Q2 start
    {'x': 4, 'y': 5.8}, // May - Maintained
    {'x': 5, 'y': 6.0}, // Jun - Q2 close target
    {'x': 6, 'y': 5.2}, // Jul - Reduced summer budget
    {'x': 7, 'y': 5.2}, // Aug - Summer continuation
    {'x': 8, 'y': 6.5}, // Sep - Q3 target
    {'x': 9, 'y': 6.8}, // Oct - Increased allocation
    {'x': 10, 'y': 7.2}, // Nov - Holiday season budget
    {'x': 11, 'y': 7.8}, // Dec - Year-end target
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

const Map<String, dynamic> _vesselTypePieData = {
  'cardTitle': 'Fleet Composition',
  'cardSubtitle': 'Vessels by type',
  'totalLeads': '42',
  'pieChartData': [
    {'label': 'Container', 'value': 35.0, 'color': '0xFF1379F0'},
    {'label': 'Tanker', 'value': 28.0, 'color': '0xFF7C3AED'},
    {'label': 'Bulk Carrier', 'value': 22.0, 'color': '0xFF10B981'},
    {'label': 'Other', 'value': 15.0, 'color': '0xFFF97316'},
  ],
  'legendData': [
    {'label': 'Container', 'color': '0xFF1379F0'},
    {'label': 'Tanker', 'color': '0xFF7C3AED'},
    {'label': 'Bulk Carrier', 'color': '0xFF10B981'},
    {'label': 'Other', 'color': '0xFFF97316'},
  ],
};

const Map<String, dynamic> _budgetUtilizationCard = {
  'cardTitle': 'Budget Utilization',
  'cardSubtitle': 'Last 10 days tracking',
  'mainValue': '87.4%',
  'percentageChange': '+4.1%',
  'isPositiveChange': true,
  'changeLabel': 'vs previous month',
  'barData': [
    {'x': 0, 'y': 68},
    {'x': 1, 'y': 72},
    {'x': 2, 'y': 74},
    {'x': 3, 'y': 76},
    {'x': 4, 'y': 78},
    {'x': 5, 'y': 80},
    {'x': 6, 'y': 82},
    {'x': 7, 'y': 84},
    {'x': 8, 'y': 86},
    {'x': 9, 'y': 87},
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
  'chartConfig': {'minX': 0, 'maxX': 9, 'minY': 60, 'maxY': 95},
};

const Map<String, dynamic> _procurementEfficiencyCombo = {
  'cardTitle': 'Procurement Efficiency',
  'cardSubtitle': 'On-time vs delayed deliveries',
  'minY': 0.0,
  'maxY': 600.0,
  'gridInterval': 100.0,
  'yAxisLabels': [
    {'value': 0, 'label': '0'},
    {'value': 100, 'label': '100'},
    {'value': 200, 'label': '200'},
    {'value': 300, 'label': '300'},
    {'value': 400, 'label': '400'},
    {'value': 500, 'label': '500'},
    {'value': 600, 'label': '600'},
  ],
  'chartData': [
    {'month': 'Jan', 'wins': 420.0, 'losses': 68.0, 'winRate': 86.1},
    {'month': 'Feb', 'wins': 445.0, 'losses': 62.0, 'winRate': 87.8},
    {'month': 'Mar', 'wins': 468.0, 'losses': 58.0, 'winRate': 89.0},
    {'month': 'Apr', 'wins': 492.0, 'losses': 52.0, 'winRate': 90.4},
    {'month': 'May', 'wins': 518.0, 'losses': 48.0, 'winRate': 91.5},
    {'month': 'Jun', 'wins': 536.0, 'losses': 44.0, 'winRate': 92.4},
  ],
};

const Map<String, dynamic> _vesselPerformanceComparison = {
  'tabs': [
    {
      'label': 'Cost per Vessel',
      'subtitle': 'Monthly procurement by vessel',
      'onTimeOrder': [180000, 195000, 210000, 225000, 235000, 248000],
      'delayedOrder': [42000, 48000, 52000, 58000, 62000, 68000],
      'maxY': 260000,
    },
    {
      'label': 'Compliance Rate',
      'subtitle': 'Safety and regulation adherence',
      'onTimeOrder': [38, 39, 40, 40, 41, 41],
      'delayedOrder': [4, 3, 2, 2, 1, 1],
      'maxY': 43,
    },
  ],
};

const Map<String, dynamic> _purchasesByCategoryBar = {
  'cardTitle': 'Spend by Vessel & Category',
  'cardSubtitle': 'Stacked vessel spend profile across key categories',
  'maxY': 1100000.0,
  'minY': 0.0,
  'yAxisInterval': 200000.0,
  'barWidth': 12.0,
  'barsSpace': 8.0,
  'yAxisLabels': [
    {'value': 0.0, 'label': '0K'},
    {'value': 200000.0, 'label': '200K'},
    {'value': 400000.0, 'label': '400K'},
    {'value': 600000.0, 'label': '600K'},
    {'value': 800000.0, 'label': '800K'},
    {'value': 1000000.0, 'label': '1M'},
  ],
  'chartData': [
    {
      'label': 'MV Coral Breeze',
      'values': [
        {'value': 315000.0, 'color': 0xFF1379F0},
        {'value': 600000.0, 'color': 0xFFF97316},
        {'value': 860000.0, 'color': 0xFF10B981},
        {'value': 900000.0, 'color': 0xFF7C3AED},
      ],
      'percentile25': 175000.0,
      'percentile75': 965000.0,
      'tooltip': [
        {'label': 'Provisions', 'value': '\$315K'},
        {'label': 'Deck', 'value': '\$600K'},
        {'label': 'Engine', 'value': '\$860K'},
        {'label': 'Bond Store', 'value': '\$900K'},
      ],
    },
    {
      'label': 'MV Arctic Dawn',
      'values': [
        {'value': 315000.0, 'color': 0xFF1379F0},
        {'value': 600000.0, 'color': 0xFFF97316},
        {'value': 860000.0, 'color': 0xFF10B981},
        {'value': 900000.0, 'color': 0xFF7C3AED},
      ],
      'percentile25': 145000.0,
      'percentile75': 935000.0,
      'tooltip': [
        {'label': 'Provisions', 'value': '\$315K'},
        {'label': 'Deck', 'value': '\$600K'},
        {'label': 'Engine', 'value': '\$860K'},
        {'label': 'Bond Store', 'value': '\$900K'},
      ],
    },
    {
      'label': 'MV Pacific Harmony',
      'values': [
        {'value': 315000.0, 'color': 0xFF1379F0},
        {'value': 600000.0, 'color': 0xFFF97316},
        {'value': 860000.0, 'color': 0xFF10B981},
        {'value': 900000.0, 'color': 0xFF7C3AED},
      ],
      'percentile25': 195000.0,
      'percentile75': 890000.0,
      'tooltip': [
        {'label': 'Provisions', 'value': '\$315K'},
        {'label': 'Deck', 'value': '\$600K'},
        {'label': 'Engine', 'value': '\$860K'},
        {'label': 'Bond Store', 'value': '\$900K'},
      ],
    },
    {
      'label': 'MV Golden Horizon',
      'values': [
        {'value': 335000.0, 'color': 0xFF1379F0},
        {'value': 275000.0, 'color': 0xFFF97316},
        {'value': 255000.0, 'color': 0xFF10B981},
        {'value': 160000.0, 'color': 0xFF7C3AED},
      ],
      'percentile25': 160000.0,
      'percentile75': 880000.0,
      'tooltip': [
        {'label': 'Provisions', 'value': '\$335K'},
        {'label': 'Deck', 'value': '\$275K'},
        {'label': 'Engine', 'value': '\$255K'},
        {'label': 'Bond Store', 'value': '\$160K'},
      ],
    },
    {
      'label': 'MV Silver Mist',
      'values': [
        {'value': 225000.0, 'color': 0xFF1379F0},
        {'value': 360000.0, 'color': 0xFFF97316},
        {'value': 280000.0, 'color': 0xFF10B981},
        {'value': 120000.0, 'color': 0xFF7C3AED},
      ],
      'percentile25': 120000.0,
      'percentile75': 865000.0,
      'tooltip': [
        {'label': 'Provisions', 'value': '\$225K'},
        {'label': 'Deck', 'value': '\$360K'},
        {'label': 'Engine', 'value': '\$280K'},
        {'label': 'Bond Store', 'value': '\$120K'},
      ],
    },
    {
      'label': 'MV Emerald Isle',
      'values': [
        {'value': 315000.0, 'color': 0xFF1379F0},
        {'value': 600000.0, 'color': 0xFFF97316},
        {'value': 860000.0, 'color': 0xFF10B981},
        {'value': 900000.0, 'color': 0xFF7C3AED},
      ],
      'percentile25': 105000.0,
      'percentile75': 975000.0,
      'tooltip': [
        {'label': 'Provisions', 'value': '\$315K'},
        {'label': 'Deck', 'value': '\$600K'},
        {'label': 'Engine', 'value': '\$860K'},
        {'label': 'Bond Store', 'value': '\$900K'},
      ],
    },
  ],
  // Legend now mirrors the stacked category colors per vessel
  'legendData': [
    {'label': 'Provisions', 'color': '0xFF1379F0'},
    {'label': 'Deck', 'color': '0xFFF97316'},
    {'label': 'Engine', 'color': '0xFF10B981'},
    {'label': 'Bond Store', 'color': '0xFF7C3AED'},
  ],
};

const List<Map<String, dynamic>> _smcPerformanceMetrics = [
  {
    'title': 'Top Vendors by Spend',
    'subtitle': 'Highest procurement value',
    'ports': [
      {
        'portName': 'Marine Tech Supply',
        'purchaseValue': '\$1.8M',
        'percentageChange': 8.4,
        'trend': 'up',
      },
      {
        'portName': 'Global Ship Parts',
        'purchaseValue': '\$1.6M',
        'percentageChange': 6.7,
        'trend': 'up',
      },
    ],
  },
  {
    'title': 'Top Spending Vessels',
    'subtitle': 'Highest procurement by vessel',
    'ports': [
      {
        'portName': 'MV Pacific Star',
        'purchaseValue': '\$468K',
        'percentageChange': 12.3,
        'trend': 'up',
      },
      {
        'portName': 'MV Atlantic Crown',
        'purchaseValue': '\$442K',
        'percentageChange': 9.8,
        'trend': 'up',
      },
    ],
  },
  {
    'title': 'Cost Saving Opportunities',
    'subtitle': 'Identified savings potential',
    'ports': [
      {
        'portName': 'Bulk Ordering',
        'purchaseValue': '\$284K',
        'percentageChange': 16.2,
        'trend': 'up',
      },
      {
        'portName': 'Contract Negotiation',
        'purchaseValue': '\$196K',
        'percentageChange': 11.4,
        'trend': 'up',
      },
    ],
  },
  {
    'title': 'Highlighted Products',
    'subtitle': 'take a quick actions',
    'switch-options': ['Pending Requisitions', 'Upcoming Deliveries'],
    'columns': {'first': 'Recent Status', 'second': 'Order Value'},
    'Pending Requisitions': [
      {
        'portName': 'Smart Fuel Monitor',
        'purchaseValue': '\$1,420',
        'percentageChange': 32.1,
        'trend': 'up',
        'priority': 'HIGH PRIORITY',
        'daysLeft': 2,
        'status': 'Awaiting Approval',
      },
      {
        'portName': 'Engine Spare Parts',
        'purchaseValue': '\$860',
        'percentageChange': 24.3,
        'trend': 'up',
        'priority': 'MEDIUM PRIORITY',
        'daysLeft': 5,
        'status': 'Under Review',
      },
    ],
    'Upcoming Deliveries': [
      {
        'portName': 'Navigation Equipment',
        'purchaseValue': '\$980',
        'percentageChange': 18.7,
        'trend': 'up',
        'priority': 'HIGH PRIORITY',
        'daysLeft': 1,
        'status': 'Scheduled',
      },
      {
        'portName': 'Safety Gear Set',
        'purchaseValue': '\$580',
        'percentageChange': 15.4,
        'trend': 'up',
        'priority': 'MEDIUM PRIORITY',
        'daysLeft': 3,
        'status': 'In Transit',
      },
    ],
  },
];

const Map<String, dynamic> _smcTableData = {
  'header': {
    'title': 'Pending Requisitions',
    'subtitle': 'Active purchase requests awaiting approval',
  },
  'rfqs': [
    {
      'rank': 1,
      'rfqId': 'REQ-8421',
      'title': 'Engine Spare Parts',
      'supplier': 'MV Pacific Star',
      'estimatedValue': 142000,
      'percentageChange': 0.0,
      'responsesReceived': 3,
      'daysRemaining': 5,
    },
    {
      'rank': 2,
      'rfqId': 'REQ-8398',
      'title': 'Navigation Equipment',
      'supplier': 'MV Atlantic Crown',
      'estimatedValue': 86000,
      'percentageChange': 0.0,
      'responsesReceived': 2,
      'daysRemaining': 7,
    },
    {
      'rank': 3,
      'rfqId': 'REQ-8372',
      'title': 'Safety Equipment',
      'supplier': 'MV Nordic Wave',
      'estimatedValue': 58000,
      'percentageChange': 0.0,
      'responsesReceived': 4,
      'daysRemaining': 3,
    },
    {
      'rank': 4,
      'rfqId': 'REQ-8361',
      'title': 'Electrical Supplies',
      'supplier': 'MV Southern Cross',
      'estimatedValue': 42000,
      'percentageChange': 0.0,
      'responsesReceived': 2,
      'daysRemaining': 6,
    },
    {
      'rank': 5,
      'rfqId': 'REQ-8348',
      'title': 'Deck Equipment',
      'supplier': 'MV Eastern Star',
      'estimatedValue': 38000,
      'percentageChange': 0.0,
      'responsesReceived': 3,
      'daysRemaining': 4,
    },
  ],
  'pendingQuotes': {
    'header': {
      'title': 'Quote Comparison',
      'subtitle': 'Comparing vendor quotes',
    },
    'quotes': [
      {
        'rank': 1,
        'quoteId': 'QT-7284',
        'customer': 'Marine Tech Supply',
        'quoteValue': 128000,
        'percentageChange': -8.2,
        'daysInReview': 2,
        'expiresInDays': 12,
        'status': 'Under Review',
      },
      {
        'rank': 2,
        'quoteId': 'QT-7261',
        'customer': 'Global Ship Parts',
        'quoteValue': 136000,
        'percentageChange': -2.4,
        'daysInReview': 3,
        'expiresInDays': 10,
        'status': 'Under Review',
      },
    ],
  },
  'activeOrders': {
    'header': {
      'title': 'Active Purchase Orders',
      'subtitle': 'In-transit and processing',
    },
    'orders': [
      {
        'rank': 1,
        'orderId': 'PO-6842',
        'customer': 'Marine Tech Supply',
        'orderValue': 284000,
        'percentageChange': 0.0,
        'progressPercentage': 65,
        'deliveryStatus': 'In Transit',
        'expectedDelivery': '2025-02-18',
      },
      {
        'rank': 2,
        'orderId': 'PO-6821',
        'customer': 'Global Ship Parts',
        'orderValue': 196000,
        'percentageChange': 0.0,
        'progressPercentage': 82,
        'deliveryStatus': 'Processing',
        'expectedDelivery': '2025-02-12',
      },
    ],
  },
  'completedDeliveries': {
    'header': {'title': 'Recent Deliveries', 'subtitle': 'Last 7 days'},
    'deliveries': [
      {
        'rank': 1,
        'deliveryId': 'DEL-5928',
        'customer': 'Marine Tech Supply',
        'deliveryValue': 142000,
        'percentageChange': 0.0,
        'deliveryDate': '2025-01-28',
        'rating': 4.8,
        'onTime': true,
      },
      {
        'rank': 2,
        'deliveryId': 'DEL-5912',
        'customer': 'Ocean Supplies Ltd',
        'deliveryValue': 98000,
        'percentageChange': 0.0,
        'deliveryDate': '2025-01-26',
        'rating': 4.6,
        'onTime': true,
      },
    ],
  },
  'customerMetrics': {
    'header': {
      'title': 'Vessel Performance',
      'subtitle': 'Fleet efficiency metrics',
    },
    'customers': [
      {
        'rank': 1,
        'customerName': 'MV Pacific Star',
        'region': 'Container',
        'totalOrders': 142,
        'percentageChange': 12.3,
        'totalValue': 468000,
        'averageOrderValue': 3296,
        'satisfactionScore': 4.7,
      },
      {
        'rank': 2,
        'customerName': 'MV Atlantic Crown',
        'region': 'Tanker',
        'totalOrders': 128,
        'percentageChange': 9.8,
        'totalValue': 442000,
        'averageOrderValue': 3453,
        'satisfactionScore': 4.6,
      },
    ],
  },
  'productPerformance': {
    'header': {
      'title': 'Category Performance',
      'subtitle': 'Top procurement categories',
    },
    'products': [
      {
        'rank': 1,
        'productName': 'Engine Spare Parts',
        'category': 'Machinery',
        'unitsSold': 842,
        'percentageChange': 8.4,
        'revenue': 3268000,
        'averagePrice': 3882,
        'stockStatus': 'In Stock',
      },
      {
        'rank': 2,
        'productName': 'Fuel & Lubricants',
        'category': 'Consumables',
        'unitsSold': 1247,
        'percentageChange': 6.7,
        'revenue': 2408000,
        'averagePrice': 1931,
        'stockStatus': 'In Stock',
      },
    ],
  },
};

/// SMC Dashboard - Production Ready
///
/// Features:
/// - Fleet and vessel statistics
/// - Crew management metrics
/// - Procurement spend analysis
/// - Budget tracking and utilization
/// - Vendor performance rankings
/// - Purchase requisitions tracking
/// - Cost optimization insights
/// - Delivery performance monitoring
/// - Category-wise spending breakdown
class SMCDashboard extends StatelessWidget {
  const SMCDashboard({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: DashboardCardContainer(cards: _smcCards),
            ),

            // Procurement Breakdown
            DashboardGridCol(
              xs: 12,
              md: 4,
              child: DashboardRecentData(data: _smcProcurementBreakdown),
            ),

            DashboardGridCol(
              xs: 12,
              md: 6,
              lg: 4,
              child: DashboardQuickWins(data: _smcPerformanceMetrics[3]),
            ),

            // Purchases by Category & Ship
            DashboardGridCol(
              xs: 12,
              md: 8,
              child: DashboardBarChart(data: _purchasesByCategoryBar),
            ),

            // Spend Trend Line Chart
            DashboardGridCol(
              xs: 12,
              md: 5,
              child: RevenueGeneratedCard(chartData: _smcSpendTrendChart),
            ),

            // Fleet Composition Pie Chart
            DashboardGridCol(
              xs: 12,
              md: 3,
              child: DashboardPieChart(data: _vesselTypePieData),
            ),

            // Budget Utilization Card
            DashboardGridCol(
              xs: 12,
              md: 4,
              child: DashboardFinancialCard(data: _budgetUtilizationCard),
            ),

            // Procurement Efficiency
            DashboardGridCol(
              xs: 12,
              md: 6,
              child: DashboardcombobarChart(data: _procurementEfficiencyCombo),
            ),

            // Vessel Performance Comparison
            DashboardGridCol(
              xs: 12,
              md: 6,
              child: MultiAnalyticsOveriview(
                data: _vesselPerformanceComparison,
              ),
            ),

            // Performance Metrics Cards
            DashboardGridCol(
              xs: 12,
              md: 6,
              lg: 4,
              child: DashboardLeadingPort(data: _smcPerformanceMetrics[0]),
            ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              lg: 4,
              child: DashboardLeadingPort(data: _smcPerformanceMetrics[1]),
            ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              lg: 4,
              child: DashboardLeadingPort(data: _smcPerformanceMetrics[2]),
            ),

            // Multi-Tab Table (Requisitions, Quotes, Orders, etc.)
            // DashboardGridCol(
            //   xs: 12,
            //   child: DashboardTable(data: _smcTableData),
            // ),
          ],
        ),
      ),
    );
  }
}
