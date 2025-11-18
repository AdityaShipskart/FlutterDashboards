import 'package:flutter/material.dart';
import 'common/custom_data_table.dart';
import '../const/constant.dart';

// Example data for when no data is provided
const Map<String, dynamic> _exampleData = {
  'title': 'Leading Ports',
  'subtitle': 'Summary of all your leading ports',
  'columns': {'first': 'Port Name', 'second': 'Purchase Value'},
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

class DashboardLeadingPort extends StatefulWidget {
  final Map<String, dynamic> data;
  final double minWidth;
  final bool expandToAvailableWidth;

  const DashboardLeadingPort({
    super.key,
    Map<String, dynamic>? data,
    this.minWidth = 900,
    this.expandToAvailableWidth = true,
  }) : data = data ?? _exampleData;

  @override
  State<DashboardLeadingPort> createState() => _DashboardLeadingPortState();
}

class _DashboardLeadingPortState extends State<DashboardLeadingPort> {
  String? selectedSwitchOption;

  @override
  void initState() {
    super.initState();
    // Initialize with first switch option if available
    final switchOptions = widget.data['switch-options'] as List<dynamic>?;
    if (switchOptions != null && switchOptions.isNotEmpty) {
      selectedSwitchOption = switchOptions.first.toString();
    }
  }

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
          style: AppTextStyles.b14(isDark: isDark).copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.getTextPrimary(isDark),
          ),
        ),
        SizedBox(width: AppSpacing.ml),
        Icon(
          isPositive ? Icons.arrow_upward : Icons.arrow_downward,
          size: AppConstants.iconSizeSmall - 2,
          color: isPositive
              ? (isDark ? AppColors.successActiveDark : AppColors.success)
              : (isDark ? AppColors.errorActiveDark : AppColors.error),
        ),
        SizedBox(width: AppSpacing.xs),
        Text(
          '${percentageChange.toStringAsFixed(1)}%',
          style: AppTextStyles.b14(isDark: isDark).copyWith(
            fontWeight: FontWeight.w500,
            color: isPositive
                ? (isDark ? AppColors.successActiveDark : AppColors.success)
                : (isDark ? AppColors.errorActiveDark : AppColors.error),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.data['title'] ?? 'Leading Ports';
    final subTitle =
        widget.data['subtitle'] ?? 'Summary of all your leading ports';

    // Get data based on switch option or fallback to default data
    List<dynamic> rawData;
    final dataLevelSwitchOptions =
        widget.data['switch-options'] as List<dynamic>?;

    if (dataLevelSwitchOptions != null &&
        selectedSwitchOption != null &&
        widget.data.containsKey(selectedSwitchOption!)) {
      rawData = (widget.data[selectedSwitchOption!] ?? []) as List<dynamic>;
    } else {
      // Support both 'data' and 'ports' array keys as fallback
      rawData =
          (widget.data['data'] ?? widget.data['ports'] ?? []) as List<dynamic>;
    }

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

    // Get column configuration from data or use defaults
    final columnConfig = widget.data['columns'] as Map<String, dynamic>?;
    final firstColumnLabel = columnConfig?['first'] ?? 'Port Name';
    final secondColumnLabel = columnConfig?['second'] ?? 'Purchase Value';

    final columns = [
      TableColumn(
        key: 'portName',
        label: firstColumnLabel,
        builder: (value, isDark, isSummary) {
          return Row(
            children: [
              Text(
                value?.toString() ?? '',
                style: AppTextStyles.b14(isDark: isDark).copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.getTextPrimary(isDark),
                ),
              ),
            ],
          );
        },
      ),
      TableColumn(
        key: 'purchaseValue',
        label: secondColumnLabel,
        builder: _buildPercentageChange,
      ),
    ];

    return CustomDataTable(
      title: title,
      subtitle: subTitle,
      columns: columns,
      dataRows: dataRows,
      minWidth: widget.minWidth,
      expandToAvailableWidth: widget.expandToAvailableWidth,
      switchOptions: dataLevelSwitchOptions,
      selectedSwitchOption: selectedSwitchOption,
      onSwitchChanged:
          dataLevelSwitchOptions != null && dataLevelSwitchOptions.isNotEmpty
          ? (option) {
              setState(() {
                selectedSwitchOption = option;
              });
            }
          : null,
    );
  }
}
