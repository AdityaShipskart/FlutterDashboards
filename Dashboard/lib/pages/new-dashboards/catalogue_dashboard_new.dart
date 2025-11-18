import 'package:flutter/material.dart';
// import 'package:get/utils.dart';
import '../../widgets/dashboard_grid.dart';
import '../../widgets/dashboard_card_container.dart';
import '../../widgets/dashboard_line_chart.dart';
import '../../widgets/dashboard_pie_chart.dart';
import '../../widgets/dashboard_comparison.dart';
import '../../widgets/dashboard_bar_chart.dart';
import '../../widgets/dashboard_leading_port.dart';
import '../../widgets/dashboard_quick_wins.dart';
import '../../widgets/dashboard_table.dart';

const List<Map<String, dynamic>> _catalogueCards = [
  {
    'iconKey': 'orders',
    'value': '247',
    'label': 'Total Products',
    'growth': '+12',
    'color': Color(0xFF6366F1),
    'iconBgColor': Color(0xFFEEF2FF),
  },
  {
    'iconKey': 'revenue',
    'value': '18,462',
    'label': 'Total Categories',
    'growth': '+842',
    'color': Color(0xFFEC4899),
    'iconBgColor': Color(0xFFFDE0F0),
  },
  {
    'iconKey': 'profit',
    'value': '14.2K',
    'label': 'Total Brands',
    'growth': '+18.6%',
    'color': Color(0xFF10B981),
    'iconBgColor': Color(0xFFD1FAE5),
  },
  {
    'iconKey': 'users',
    'value': '92.4%',
    'label': 'Manufacturers',
    'growth': '+3.8%',
    'color': Color(0xFF0EA5E9),
    'iconBgColor': Color(0xFFE0F2FE),
  },
  {
    'iconKey': 'users',
    'value': '92.4%',
    'label': 'Ports',
    'growth': '+3.8%',
    'color': Color(0xFF0EA5E9),
    'iconBgColor': Color(0xFFE0F2FE),
  },

  {
    'iconKey': 'users',
    'value': '92.4%',
    'label': 'Countries',
    'growth': '+3.8%',
    'color': Color(0xFF0EA5E9),
    'iconBgColor': Color(0xFFE0F2FE),
  },
];

// const Map<String, dynamic> _catalogueProductBreakdown = {
//   'salesHighlights': {
//     'title': 'Products by Category',
//     'totalValue': 18462,
//     'currency': '',
//     'percentageChange': 4.6,
//     'isPositive': true,
//     'products': [
//       {'name': 'Marine Equipment', 'percentage': 32, 'color': 0xFF6366F1},
//       {'name': 'Electronics', 'percentage': 26, 'color': 0xFFEC4899},
//       {'name': 'Safety & PPE', 'percentage': 22, 'color': 0xFF10B981},
//       {'name': 'Other', 'percentage': 20, 'color': 0xFF0EA5E9},
//     ],
//     'channels': [
//       {
//         'icon': 'anchor_outlined',
//         'name': 'Marine Equipment',
//         'value': 5908,
//         'percentageChange': 5.2,
//         'isPositive': true,
//       },
//       {
//         'icon': 'devices_outlined',
//         'name': 'Electronics',
//         'value': 4800,
//         'percentageChange': 4.8,
//         'isPositive': true,
//       },
//       {
//         'icon': 'shield_outlined',
//         'name': 'Safety & PPE',
//         'value': 4062,
//         'percentageChange': 3.6,
//         'isPositive': true,
//       },
//       {
//         'icon': 'inventory_outlined',
//         'name': 'Other Categories',
//         'value': 3692,
//         'percentageChange': 4.1,
//         'isPositive': true,
//       },
//     ],
//   },
// };

final Map<String, dynamic> _catalogueGrowthChart = {
  'cardTitle': 'Catalogue Growth',
  'cardSubtitle': 'New products vs custom products',
  'thisYearLabel': 'New Products',
  'lastYearLabel': 'Custom Products',
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
  'cardTitle': 'Categories',
  'cardSubtitle': 'Categories wise products',
  'totalLeads': '14.2K',
  'pieChartData': [
    {
      'label': 'IMPA',
      'value': 42.0,
      'color': '0xFF2563EB',
    }, // Professional blue for standards
    {
      'label': 'Deck',
      'value': 31.0,
      'color': '0xFF059669',
    }, // Deep green for nautical/deck
    {
      'label': 'Provision',
      'value': 18.0,
      'color': '0xFFEA580C',
    }, // Vibrant orange for supplies
    {
      'label': 'Lubes',
      'value': 9.0,
      'color': '0xFF0891B2',
    }, // Ocean blue for lubricants
    {
      'label': 'Chemicals',
      'value': 9.0,
      'color': '0xFFF59E0B',
    }, // Warning amber for chemicals
    {
      'label': 'Services',
      'value': 9.0,
      'color': '0xFF7C3AED',
    }, // Royal purple for services
    {
      'label': 'Spares',
      'value': 9.0,
      'color': '0xFFDC2626',
    }, // Alert red for spare parts
    {
      'label': 'Paints',
      'value': 9.0,
      'color': '0xFF0D9488',
    }, // Teal for coatings
  ],
  'legendData': [
    {'label': 'IMPA', 'color': '0xFF2563EB'},
    {'label': 'Deck', 'color': '0xFF059669'},
    {'label': 'Provision', 'color': '0xFFEA580C'},
    {'label': 'Lubes', 'color': '0xFF0891B2'},
    {'label': 'Chemicals', 'color': '0xFFF59E0B'},
    {'label': 'Services', 'color': '0xFF7C3AED'},
    {'label': 'Spares', 'color': '0xFFDC2626'},
    {'label': 'Paints', 'color': '0xFF0D9488'},
  ],
};

const Map<String, dynamic> _statusPieData = {
  'cardTitle': 'Catalogue Status',
  'cardSubtitle': 'Products wise status',
  'totalLeads': '100',
  'pieChartData': [
    {
      'label': 'New requests',
      'value': 42.0,
      'color': '0xFF3B82F6',
    }, // Fresh blue for new requests
    {
      'label': 'Approved',
      'value': 31.0,
      'color': '0xFF10B981',
    }, // Success green for approved
    {
      'label': 'Rejected',
      'value': 18.0,
      'color': '0xFFEF4444',
    }, // Error red for rejected
    {
      'label': 'Pending',
      'value': 9.0,
      'color': '0xFFF59E0B',
    }, // Warning orange for pending
  ],
  'legendData': [
    {'label': 'New requests', 'color': '0xFF3B82F6'},
    {'label': 'Approved', 'color': '0xFF10B981'},
    {'label': 'Rejected', 'color': '0xFFEF4444'},
    {'label': 'Pending', 'color': '0xFFF59E0B'},
  ],
};

// const Map<String, dynamic> _catalogueUtilizationCard = {
//   'cardTitle': 'Catalogue Utilization',
//   'cardSubtitle': 'Products with orders (last 30 days)',
//   'mainValue': '92.4%',
//   'percentageChange': '+3.8%',
//   'isPositiveChange': true,
//   'changeLabel': 'vs previous month',
//   'barData': [
//     {'x': 0, 'y': 72},
//     {'x': 1, 'y': 76},
//     {'x': 2, 'y': 78},
//     {'x': 3, 'y': 81},
//     {'x': 4, 'y': 83},
//     {'x': 5, 'y': 85},
//     {'x': 6, 'y': 87},
//     {'x': 7, 'y': 89},
//     {'x': 8, 'y': 91},
//     {'x': 9, 'y': 92},
//   ],
//   'labels': [
//     'Week 1',
//     'Week 2',
//     'Week 3',
//     'Week 4',
//     'Week 5',
//     'Week 6',
//     'Week 7',
//     'Week 8',
//     'Week 9',
//     'Week 10',
//   ],
//   'chartConfig': {'minX': 0, 'maxX': 9, 'minY': 65, 'maxY': 100},
// };

// const Map<String, dynamic> _categoryPerformanceCombo = {
//   'cardTitle': 'Category Performance',
//   'cardSubtitle': 'Active vs low-performing categories',
//   'minY': 0.0,
//   'maxY': 160.0,
//   'gridInterval': 30.0,
//   'yAxisLabels': [
//     {'value': 0, 'label': '0'},
//     {'value': 30, 'label': '30'},
//     {'value': 60, 'label': '60'},
//     {'value': 90, 'label': '90'},
//     {'value': 120, 'label': '120'},
//     {'value': 150, 'label': '150'},
//   ],
//   'chartData': [
//     {'month': 'Jan', 'wins': 128.0, 'losses': 18.0, 'winRate': 87.7},
//     {'month': 'Feb', 'wins': 132.0, 'losses': 16.0, 'winRate': 89.2},
//     {'month': 'Mar', 'wins': 138.0, 'losses': 14.0, 'winRate': 90.8},
//     {'month': 'Apr', 'wins': 142.0, 'losses': 12.0, 'winRate': 92.2},
//     {'month': 'May', 'wins': 146.0, 'losses': 10.0, 'winRate': 93.6},
//     {'month': 'Jun', 'wins': 148.0, 'losses': 8.0, 'winRate': 94.9},
//   ],
// };

const Map<String, dynamic> _customRequirementsComparison = {
  'tabs': [
    {
      'label': 'Approval TAT',
      'subtitle': 'requester vs approval time',
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
  'cardTitle': 'Quality Assurance Issues',
  'cardSubtitle': 'Outstanding catalogue blockers by severity',
  'maxY': 180.0,
  'minY': 0.0,
  'yAxisInterval': 30.0,
  'barWidth': 12.0,
  'barsSpace': 6.0,
  'chartData': [
    {
      'label': 'Missing Images',
      'values': [
        {'value': 36.0, 'color': 0xFFFCD34D},
        {'value': 92.0, 'color': 0xFFF97316},
        {'value': 148.0, 'color': 0xFFEF4444},
      ],
      'percentile25': 36.0,
      'percentile50': 92.0,
      'percentile75': 148.0,
    },
    {
      'label': 'Missing Port Mapping',
      'values': [
        {'value': 28.0, 'color': 0xFFFCD34D},
        {'value': 84.0, 'color': 0xFFF97316},
        {'value': 136.0, 'color': 0xFFEF4444},
      ],
      'percentile25': 28.0,
      'percentile50': 84.0,
      'percentile75': 136.0,
    },
    {
      'label': 'Incomplete Specs',
      'values': [
        {'value': 24.0, 'color': 0xFFFCD34D},
        {'value': 72.0, 'color': 0xFFF97316},
        {'value': 118.0, 'color': 0xFFEF4444},
      ],
      'percentile25': 24.0,
      'percentile50': 72.0,
      'percentile75': 118.0,
    },
    {
      'label': 'Expired Certifications',
      'values': [
        {'value': 20.0, 'color': 0xFFFCD34D},
        {'value': 58.0, 'color': 0xFFF97316},
        {'value': 102.0, 'color': 0xFFEF4444},
      ],
      'percentile25': 20.0,
      'percentile50': 58.0,
      'percentile75': 102.0,
    },
    {
      'label': 'Missing Safety Sheets',
      'values': [
        {'value': 14.0, 'color': 0xFFFCD34D},
        {'value': 42.0, 'color': 0xFFF97316},
        {'value': 78.0, 'color': 0xFFEF4444},
      ],
      'percentile25': 14.0,
      'percentile50': 42.0,
      'percentile75': 78.0,
    },
  ],
  'legendData': [
    {'label': 'Minor', 'color': '0xFFFCD34D'},
    {'label': 'Major', 'color': '0xFFF97316'},
    {'label': 'Critical', 'color': '0xFFEF4444'},
  ],
};

const List<Map<String, dynamic>> _catalogueInsights = [
  {
    'title': 'Top Performing Categories',
    'subtitle': 'Highest order volume',
    'columns': {'first': 'Category', 'second': 'Order Volume'},
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
    'title': 'Top Products',
    'subtitle': 'Month-over-month growth',
    'columns': {'first': 'Products', 'second': 'Growth Rate'},
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
      {
        'portName': 'Navigation Systems',
        'purchaseValue': '1,247',
        'percentageChange': 52.3,
        'trend': 'up',
      },
      {
        'portName': 'Safety Harnesses',
        'purchaseValue': '689',
        'percentageChange': 41.8,
        'trend': 'up',
      },
    ],
  },
  {
    'title': 'Needs Attention',
    'subtitle': 'Low utilization categories',
    'columns': {'first': 'Category', 'second': 'Decline Rate'},
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
  {
    'title': 'Recent Activity',
    'subtitle': 'Latest Catalogue Updates',
    'switch-options': ['Newly Added', 'Pending', 'Custom'],
    'columns': {'first': 'Product Name', 'second': 'Order Value'},
    'Newly Added': [
      {
        'portName': 'Smart Fuel Monitor',
        'purchaseValue': '\$1,420',
        'percentageChange': 32.1,
        'trend': 'up',
        'priority': 'HIGH PRIORITY',
        'daysLeft': 1,
        'status': 'Recently Added',
      },
      {
        'portName': 'Eco-Friendly Cleaner',
        'purchaseValue': '\$986',
        'percentageChange': 28.4,
        'trend': 'up',
        'priority': 'MEDIUM PRIORITY',
        'daysLeft': 2,
        'status': 'Awaiting Approval',
      },
    ],
    'Pending': [
      {
        'portName': 'Navigation System Upgrade',
        'purchaseValue': '\$3,124',
        'percentageChange': 15.8,
        'trend': 'up',
        'priority': 'HIGH PRIORITY',
        'daysLeft': 3,
        'status': 'Under Review',
      },
      {
        'portName': 'Marine Radio Kit',
        'purchaseValue': '\$1,876',
        'percentageChange': 8.2,
        'trend': 'up',
        'priority': 'MEDIUM PRIORITY',
        'daysLeft': 5,
        'status': 'Documentation Pending',
      },
    ],
    'Custom': [
      {
        'portName': 'Custom Navigation Integration',
        'purchaseValue': '\$4,280',
        'percentageChange': 38.9,
        'trend': 'up',
        'priority': 'HIGH PRIORITY',
        'daysLeft': 2,
        'status': 'Specification Required',
      },
      {
        'portName': 'Modified Safety System',
        'purchaseValue': '\$3,640',
        'percentageChange': 42.3,
        'trend': 'up',
        'priority': 'MEDIUM PRIORITY',
        'daysLeft': 4,
        'status': 'Design Review',
      },
    ],
  },
];

const Map<String, dynamic> _catalogueTableData = {
  'header': {
    'title': 'Product Quality',
    'subtitle': 'Incomplete product information',
    'options': ['All', 'Missing info', 'Incomplete Categories', 'Not mapped'],
  },
  'All': [
    {
      'rank': 1,
      'productId': 'PRD-8472',
      'productName': 'Marine Engine Oil',
      'category': 'Lubricants',
      'issueType': 'Missing info',
      'completeness': 52,
      'missingFields': ['Technical specs', 'Safety data', 'Usage guide'],
      'lastUpdated': '2025-10-28',
      'status': 'Needs Review',
    },
    {
      'rank': 2,
      'productId': 'PRD-8461',
      'productName': 'Navigation System Pro',
      'category': 'Electronics',
      'issueType': 'Not mapped',
      'completeness': 64,
      'missingFields': ['Category mapping', 'Related products'],
      'lastUpdated': '2025-11-02',
      'status': 'In Progress',
    },
    {
      'rank': 3,
      'productId': 'PRD-8448',
      'productName': 'Safety Harness Kit',
      'category': 'Safety',
      'issueType': 'Incomplete Categories',
      'completeness': 71,
      'missingFields': ['Subcategory', 'Product attributes'],
      'lastUpdated': '2025-11-05',
      'status': 'Needs Review',
    },
    {
      'rank': 4,
      'productId': 'PRD-8432',
      'productName': 'Deck Paint Premium',
      'category': 'Coatings',
      'issueType': 'Missing info',
      'completeness': 58,
      'missingFields': ['Images', 'Dimensions', 'Certifications'],
      'lastUpdated': '2025-10-15',
      'status': 'Urgent',
    },
    {
      'rank': 5,
      'productId': 'PRD-8419',
      'productName': 'Hydraulic Fluid Premium',
      'category': 'Lubricants',
      'issueType': 'Not mapped',
      'completeness': 45,
      'missingFields': ['Product hierarchy', 'Cross-references'],
      'lastUpdated': '2025-10-22',
      'status': 'Needs Review',
    },
    {
      'rank': 6,
      'productId': 'PRD-8398',
      'productName': 'LED Deck Light Set',
      'category': 'Lighting',
      'issueType': 'Incomplete Categories',
      'completeness': 68,
      'missingFields': ['Tags', 'Attributes'],
      'lastUpdated': '2025-11-01',
      'status': 'In Progress',
    },
  ],
  'Missing info': [
    {
      'rank': 1,
      'productId': 'PRD-8472',
      'productName': 'Marine Engine Oil',
      'category': 'Lubricants',
      'issueType': 'Missing info',
      'completeness': 52,
      'missingFields': ['Technical specs', 'Safety data', 'Usage guide'],
      'lastUpdated': '2025-10-28',
      'status': 'Needs Review',
    },
    {
      'rank': 2,
      'productId': 'PRD-8432',
      'productName': 'Deck Paint Premium',
      'category': 'Coatings',
      'issueType': 'Missing info',
      'completeness': 58,
      'missingFields': ['Images', 'Dimensions', 'Certifications'],
      'lastUpdated': '2025-10-15',
      'status': 'Urgent',
    },
    {
      'rank': 3,
      'productId': 'PRD-8401',
      'productName': 'Anchor Chain 10mm',
      'category': 'Marine Hardware',
      'issueType': 'Missing info',
      'completeness': 48,
      'missingFields': ['Product description', 'Specifications', 'Images'],
      'lastUpdated': '2025-10-18',
      'status': 'Urgent',
    },
    {
      'rank': 4,
      'productId': 'PRD-8385',
      'productName': 'Bilge Pump 1200GPH',
      'category': 'Pumps',
      'issueType': 'Missing info',
      'completeness': 55,
      'missingFields': ['Installation guide', 'Warranty info', 'Compatibility'],
      'lastUpdated': '2025-10-25',
      'status': 'Needs Review',
    },
  ],
  'Incomplete Categories': [
    {
      'rank': 1,
      'productId': 'PRD-8448',
      'productName': 'Safety Harness Kit',
      'category': 'Safety',
      'issueType': 'Incomplete Categories',
      'completeness': 71,
      'missingFields': ['Subcategory', 'Product attributes'],
      'lastUpdated': '2025-11-05',
      'status': 'Needs Review',
    },
    {
      'rank': 2,
      'productId': 'PRD-8398',
      'productName': 'LED Deck Light Set',
      'category': 'Lighting',
      'issueType': 'Incomplete Categories',
      'completeness': 68,
      'missingFields': ['Tags', 'Attributes'],
      'lastUpdated': '2025-11-01',
      'status': 'In Progress',
    },
    {
      'rank': 3,
      'productId': 'PRD-8376',
      'productName': 'Fender Inflatable Large',
      'category': 'Accessories',
      'issueType': 'Incomplete Categories',
      'completeness': 62,
      'missingFields': ['Product type', 'Classification', 'Subcategory'],
      'lastUpdated': '2025-10-30',
      'status': 'Needs Review',
    },
    {
      'rank': 4,
      'productId': 'PRD-8354',
      'productName': 'Marine Radio VHF',
      'category': 'Electronics',
      'issueType': 'Incomplete Categories',
      'completeness': 75,
      'missingFields': ['Product attributes', 'Filters'],
      'lastUpdated': '2025-11-08',
      'status': 'In Progress',
    },
  ],
  'Not mapped': [
    {
      'rank': 1,
      'productId': 'PRD-8461',
      'productName': 'Navigation System Pro',
      'category': 'Electronics',
      'issueType': 'Not mapped',
      'completeness': 64,
      'missingFields': ['Category mapping', 'Related products'],
      'lastUpdated': '2025-11-02',
      'status': 'In Progress',
    },
    {
      'rank': 2,
      'productId': 'PRD-8419',
      'productName': 'Hydraulic Fluid Premium',
      'category': 'Lubricants',
      'issueType': 'Not mapped',
      'completeness': 45,
      'missingFields': ['Product hierarchy', 'Cross-references'],
      'lastUpdated': '2025-10-22',
      'status': 'Needs Review',
    },
    {
      'rank': 3,
      'productId': 'PRD-8392',
      'productName': 'Stainless Steel Cleat',
      'category': 'Hardware',
      'issueType': 'Not mapped',
      'completeness': 51,
      'missingFields': [
        'Category path',
        'Product relationships',
        'Cross-sell items',
      ],
      'lastUpdated': '2025-10-27',
      'status': 'Needs Review',
    },
    {
      'rank': 4,
      'productId': 'PRD-8367',
      'productName': 'Fuel Tank Sensor',
      'category': 'Sensors',
      'issueType': 'Not mapped',
      'completeness': 58,
      'missingFields': ['Taxonomy mapping', 'Compatible products'],
      'lastUpdated': '2025-11-03',
      'status': 'In Progress',
    },
  ],
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
    // final isDark = Theme.of(context).brightness == Brightness.dark;

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
            // DashboardGridCol(
            //   xs: 12,
            //   md: 4,
            //   child: DashboardRecentData(data: _catalogueProductBreakdown),
            // ),
            DashboardGridCol(
              xs: 12,
              md: 6,
              lg: 4,
              child: DashboardQuickWins(data: _catalogueInsights[3]),
            ),

            // Catalogue Growth Line Chart
            DashboardGridCol(
              xs: 12,
              md: 8,
              child: RevenueGeneratedCard(chartData: _catalogueGrowthChart),
            ),

            // Client Type Utilization Pie Chart
            DashboardGridCol(
              xs: 12,
              md: 4,
              child: DashboardPieChart(data: _clientTypePieData),
            ),

            // Catalogue Utilization Card
            // DashboardGridCol(
            //   xs: 12,
            //   md: 4,
            //   child: DashboardFinancialCard(data: _catalogueUtilizationCard),
            // ),

            // Status Overview Pie Chart
            DashboardGridCol(
              xs: 12,
              md: 4,
              child: DashboardPieChart(data: _statusPieData),
            ),
            // Orders by Category Bar Chart
            DashboardGridCol(
              xs: 12,
              md: 8,
              child: DashboardBarChart(data: _ordersByCategoryBar),
            ),

            // Multi-Tab Table (Products, New Items, Stock, Discontinued, etc.)
            DashboardGridCol(
              xs: 12,
              child: DashboardTable(data: _catalogueTableData),
            ),

            // Custom Requirements & Search Analytics
            DashboardGridCol(
              xs: 12,
              md: 6,
              child: MultiAnalyticsOveriview(
                data: _customRequirementsComparison,
              ),
            ),
            // Catalogue Insights Cards
            DashboardGridCol(
              xs: 12,
              md: 5,
              lg: 3,
              child: DashboardLeadingPort(data: _catalogueInsights[0]),
            ),
            DashboardGridCol(
              xs: 12,
              md: 5,
              lg: 3,
              child: DashboardLeadingPort(data: _catalogueInsights[1]),
            ),
            // DashboardGridCol(
            //   xs: 12,
            //   md: 5,
            //   lg: 3,
            //   child: DashboardLeadingPort(data: _catalogueInsights[2]),
            // ),

            // Category Performance
            // DashboardGridCol(
            //   xs: 12,
            //   md: 6,
            //   child: DashboardcombobarChart(data: _categoryPerformanceCombo),
            // ),
          ],
        ),
      ),
    );
  }
}
