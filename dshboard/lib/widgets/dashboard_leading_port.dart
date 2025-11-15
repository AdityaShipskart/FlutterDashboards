import 'package:flutter/material.dart';
import 'common/custom_data_table.dart';

class DashboardLeadingPort extends StatelessWidget {
  final Map<String, dynamic> data;
  final double minWidth;
  final bool expandToAvailableWidth;

  const DashboardLeadingPort({
    super.key,
    Map<String, dynamic>? data,
    this.minWidth = 900,
    this.expandToAvailableWidth = true,
  }) : data = data ?? _exampleData;

  // Example data for when no data is provided
  static const Map<String, dynamic> _exampleData = {
    'title': 'Leading Ports',
    'subtitle': 'Summary of all your leading ports',
    'ports': [
      {
        'portName': 'Shanghai',
        'purchaseValue': '\$50,234,000',
        'percentageChange': 12.5,
        'trend': 'up',
      },
      {
        'portName': 'Singapore',
        'purchaseValue': '\$45,123,000',
        'percentageChange': 8.3,
        'trend': 'up',
      },
      {
        'portName': 'Rotterdam',
        'purchaseValue': '\$38,456,000',
        'percentageChange': -2.1,
        'trend': 'down',
      },
      {
        'portName': 'Los Angeles',
        'purchaseValue': '\$35,789,000',
        'percentageChange': 5.7,
        'trend': 'up',
      },
    ],
  };

  // Inline color constants - no external dependencies
  static const Color _textPrimaryDark = Color(0xFFF9FAFB);
  static const Color _textPrimaryLight = Color(0xFF111827);

  Widget _buildPercentageChange(dynamic value, bool isDark, bool isSummary) {
    if (value == null) return const SizedBox.shrink();

    final percentageChange = value['percentageChange'] as num;
    final trend = value['trend'] as String;
    final isPositive = trend == 'up';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value['purchaseValue'] ?? '',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? _textPrimaryDark : _textPrimaryLight,
          ),
        ),
        const SizedBox(width: 12),
        Icon(
          isPositive ? Icons.arrow_upward : Icons.arrow_downward,
          size: 14,
          color: isPositive ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 4),
        Text(
          '${percentageChange.toStringAsFixed(1)}%',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isPositive ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = data['title'] ?? 'Leading Ports';
    final subTitle = data['subtitle'] ?? 'Summary of all your leading ports';
    // Support both 'data' and 'ports' array keys
    final rawData = (data['data'] ?? data['ports'] ?? []) as List<dynamic>;

    final dataRows = rawData
        .map(
          (item) => {
            'portName': item['portName'] ?? item['name'],
            'purchaseValue': {
              'purchaseValue': item['purchaseValue'] ?? item['value'],
              'percentageChange':
                  item['percentageChange'] ?? item['percentage'],
              'trend': item['trend'],
            },
          },
        )
        .toList();

    final columns = [
      TableColumn(
        key: 'portName',
        label: 'Port Name',
        builder: (value, isDark, isSummary) {
          return Row(
            children: [
              Text(
                value?.toString() ?? '',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark ? _textPrimaryDark : _textPrimaryLight,
                ),
              ),
            ],
          );
        },
      ),
      TableColumn(
        key: 'purchaseValue',
        label: 'Purchase Value',
        builder: _buildPercentageChange,
      ),
    ];

    return CustomDataTable(
      title: title,
      subtitle: subTitle,
      columns: columns,
      dataRows: dataRows,
      minWidth: minWidth,
      expandToAvailableWidth: expandToAvailableWidth,
    );
  }
}
