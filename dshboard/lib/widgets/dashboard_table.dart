import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../const/constant.dart';
import 'common/custom_data_table.dart';
import 'common/percentage_chip.dart';

class DashboardTable extends StatefulWidget {
  final String? jsonFilePath;
  final Map<String, dynamic>? chartData;

  const DashboardTable({super.key, this.jsonFilePath, this.chartData});

  @override
  State<DashboardTable> createState() => _DashboardTableState();
}

class _DashboardTableState extends State<DashboardTable> {
  bool _isLoading = true;
  Map<String, dynamic>? _data;
  String? _errorMessage;
  String _selectedTableType = 'Active RFQs';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      Map<String, dynamic> data;

      if (widget.chartData != null) {
        // Use the provided chartData
        data = widget.chartData!;
      } else if (widget.jsonFilePath != null) {
        final String jsonString = await rootBundle.loadString(
          widget.jsonFilePath!,
        );
        data = json.decode(jsonString) as Map<String, dynamic>;
      } else {
        throw Exception('Either jsonFilePath or chartData must be provided');
      }

      if (mounted) {
        setState(() {
          _data = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to load data: $e';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_isLoading) {
      return _buildLoading();
    }

    if (_errorMessage != null) {
      return _buildError(isDark);
    }

    if (_data == null) {
      return const SizedBox();
    }

    // Get data for the selected table type
    final tableData = _getTableData(_selectedTableType);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and subtitle
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.xl,
              AppSpacing.xl,
              AppSpacing.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tableData['title'] as String,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tableData['subtitle'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),

          // Tab switches
          _buildTabSwitches(isDark),

          // Table
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: CustomDataTable(
              title: '',
              subtitle: '',
              columns: tableData['columns'] as List<TableColumn>,
              dataRows: tableData['dataRows'] as List<Map<String, dynamic>>,
              onRowAction: (row) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSwitches(bool isDark) {
    final tabs = [
      'Active RFQs',
      'Pending Quotes',
      'Active Orders',
      'Completed Deliveries',
      'Customer Metrics',
      'Product Performance',
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.map((tab) {
            final isSelected = tab == _selectedTableType;
            return Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedTableType = tab;
                  });
                },
                borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (isDark ? AppColors.primary : AppColors.primary)
                        : (isDark
                              ? AppColors.grey800Dark
                              : AppColors.grey100Light),
                    borderRadius: BorderRadius.circular(
                      AppConstants.radiusMedium,
                    ),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : (isDark
                                ? AppColors.darkBorder
                                : AppColors.lightBorder),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tab,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: isSelected
                          ? Colors.white
                          : (isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight),
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Map<String, dynamic> _getTableData(String tableType) {
    String title = '';
    String subtitle = '';
    List<Map<String, dynamic>> dataRows = [];
    List<TableColumn> columns = [];

    // Use switch statement based on selected table type
    switch (tableType) {
      case 'Active RFQs':
        if (_data!.containsKey('header') && _data!.containsKey('rfqs')) {
          final headerData = _data!['header'] as Map<String, dynamic>;
          title = headerData['title'] as String? ?? 'Active RFQs';
          subtitle = headerData['subtitle'] as String? ?? '';
          dataRows = (_data!['rfqs'] as List)
              .map((item) => item as Map<String, dynamic>)
              .toList();
          columns = _buildRFQColumns();
        }
        break;

      case 'Pending Quotes':
        if (_data!.containsKey('pendingQuotes')) {
          final section = _data!['pendingQuotes'] as Map<String, dynamic>;
          final headerData = section['header'] as Map<String, dynamic>;
          title = headerData['title'] as String? ?? 'Pending Quotes';
          subtitle = headerData['subtitle'] as String? ?? '';
          dataRows = (section['quotes'] as List)
              .map((item) => item as Map<String, dynamic>)
              .toList();
          columns = _buildQuoteColumns();
        }
        break;

      case 'Active Orders':
        if (_data!.containsKey('activeOrders')) {
          final section = _data!['activeOrders'] as Map<String, dynamic>;
          final headerData = section['header'] as Map<String, dynamic>;
          title = headerData['title'] as String? ?? 'Active Orders';
          subtitle = headerData['subtitle'] as String? ?? '';
          dataRows = (section['orders'] as List)
              .map((item) => item as Map<String, dynamic>)
              .toList();
          columns = _buildOrderColumns();
        }
        break;

      case 'Completed Deliveries':
        if (_data!.containsKey('completedDeliveries')) {
          final section = _data!['completedDeliveries'] as Map<String, dynamic>;
          final headerData = section['header'] as Map<String, dynamic>;
          title = headerData['title'] as String? ?? 'Completed Deliveries';
          subtitle = headerData['subtitle'] as String? ?? '';
          dataRows = (section['deliveries'] as List)
              .map((item) => item as Map<String, dynamic>)
              .toList();
          columns = _buildDeliveryColumns();
        }
        break;

      case 'Customer Metrics':
        if (_data!.containsKey('customerMetrics')) {
          final section = _data!['customerMetrics'] as Map<String, dynamic>;
          final headerData = section['header'] as Map<String, dynamic>;
          title = headerData['title'] as String? ?? 'Customer Metrics';
          subtitle = headerData['subtitle'] as String? ?? '';
          dataRows = (section['customers'] as List)
              .map((item) => item as Map<String, dynamic>)
              .toList();
          columns = _buildCustomerColumns();
        }
        break;

      case 'Product Performance':
        if (_data!.containsKey('productPerformance')) {
          final section = _data!['productPerformance'] as Map<String, dynamic>;
          final headerData = section['header'] as Map<String, dynamic>;
          title = headerData['title'] as String? ?? 'Product Performance';
          subtitle = headerData['subtitle'] as String? ?? '';
          dataRows = (section['products'] as List)
              .map((item) => item as Map<String, dynamic>)
              .toList();
          columns = _buildProductColumns();
        }
        break;

      default:
        if (_data!.containsKey('header') && _data!.containsKey('rfqs')) {
          final headerData = _data!['header'] as Map<String, dynamic>;
          title = headerData['title'] as String? ?? 'Active RFQs';
          subtitle = headerData['subtitle'] as String? ?? '';
          dataRows = (_data!['rfqs'] as List)
              .map((item) => item as Map<String, dynamic>)
              .toList();
          columns = _buildRFQColumns();
        }
    }

    return {
      'title': title,
      'subtitle': subtitle,
      'dataRows': dataRows,
      'columns': columns,
    };
  }

  // RFQ Columns
  List<TableColumn> _buildRFQColumns() {
    return [
      TableColumn(key: 'rank', label: '#'),
      TableColumn(
        key: 'rfqId',
        label: 'RFQ ID',
        builder: (value, isDark, isSummary) {
          if (isSummary) return const SizedBox();
          return Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'title',
        label: 'Title',
        builder: (value, isDark, isSummary) {
          if (isSummary) return const SizedBox();
          return Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'supplier',
        label: 'Supplier',
        builder: (value, isDark, isSummary) {
          if (isSummary) return const SizedBox();
          return Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'estimatedValue',
        label: 'Estimated Value',
        builder: (value, isDark, isSummary) {
          return Text(
            '\$${_formatNumber(value as int)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSummary ? FontWeight.w700 : FontWeight.w600,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'percentageChange',
        label: 'Change',
        builder: (value, isDark, isSummary) =>
            PercentageChip(percentage: value as double, isDark: isDark),
      ),
      TableColumn(
        key: 'responsesReceived',
        label: 'Responses',
        builder: (value, isDark, isSummary) {
          return Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSummary ? FontWeight.w700 : FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'daysRemaining',
        label: 'Days Left',
        builder: (value, isDark, isSummary) {
          return Text(
            '$value days',
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSummary ? FontWeight.w700 : FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      const TableColumn(key: 'action', label: ''),
    ];
  }

  // Quote Columns
  List<TableColumn> _buildQuoteColumns() {
    return [
      TableColumn(key: 'rank', label: '#'),
      TableColumn(
        key: 'quoteId',
        label: 'Quote ID',
        builder: (value, isDark, isSummary) {
          if (isSummary) return const SizedBox();
          return Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'customer',
        label: 'Customer',
        builder: (value, isDark, isSummary) {
          if (isSummary) return const SizedBox();
          return Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'quoteValue',
        label: 'Quote Value',
        builder: (value, isDark, isSummary) {
          return Text(
            '\$${_formatNumber(value as int)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSummary ? FontWeight.w700 : FontWeight.w600,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'percentageChange',
        label: 'Change',
        builder: (value, isDark, isSummary) =>
            PercentageChip(percentage: value as double, isDark: isDark),
      ),
      TableColumn(
        key: 'daysInReview',
        label: 'In Review',
        builder: (value, isDark, isSummary) {
          return Text(
            '$value days',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'expiresInDays',
        label: 'Expires In',
        builder: (value, isDark, isSummary) {
          return Text(
            '$value days',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'status',
        label: 'Status',
        builder: (value, isDark, isSummary) {
          if (isSummary) return const SizedBox();
          return Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      const TableColumn(key: 'action', label: ''),
    ];
  }

  // Order Columns
  List<TableColumn> _buildOrderColumns() {
    return [
      TableColumn(key: 'rank', label: '#'),
      TableColumn(
        key: 'orderId',
        label: 'Order ID',
        builder: (value, isDark, isSummary) {
          if (isSummary) return const SizedBox();
          return Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'customer',
        label: 'Customer',
        builder: (value, isDark, isSummary) {
          if (isSummary) return const SizedBox();
          return Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'orderValue',
        label: 'Order Value',
        builder: (value, isDark, isSummary) {
          return Text(
            '\$${_formatNumber(value as int)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSummary ? FontWeight.w700 : FontWeight.w600,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'percentageChange',
        label: 'Change',
        builder: (value, isDark, isSummary) =>
            PercentageChip(percentage: value as double, isDark: isDark),
      ),
      TableColumn(
        key: 'progressPercentage',
        label: 'Progress',
        builder: (value, isDark, isSummary) {
          return Text(
            '$value%',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'deliveryStatus',
        label: 'Status',
        builder: (value, isDark, isSummary) {
          if (isSummary) return const SizedBox();
          return Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'expectedDelivery',
        label: 'Expected Delivery',
        builder: (value, isDark, isSummary) {
          if (isSummary) return const SizedBox();
          return Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      const TableColumn(key: 'action', label: ''),
    ];
  }

  // Delivery Columns
  List<TableColumn> _buildDeliveryColumns() {
    return [
      TableColumn(key: 'rank', label: '#'),
      TableColumn(
        key: 'deliveryId',
        label: 'Delivery ID',
        builder: (value, isDark, isSummary) {
          if (isSummary) return const SizedBox();
          return Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'customer',
        label: 'Customer',
        builder: (value, isDark, isSummary) {
          if (isSummary) return const SizedBox();
          return Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'deliveryValue',
        label: 'Delivery Value',
        builder: (value, isDark, isSummary) {
          return Text(
            '\$${_formatNumber(value as int)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSummary ? FontWeight.w700 : FontWeight.w600,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'percentageChange',
        label: 'Change',
        builder: (value, isDark, isSummary) =>
            PercentageChip(percentage: value as double, isDark: isDark),
      ),
      TableColumn(
        key: 'deliveryDate',
        label: 'Delivery Date',
        builder: (value, isDark, isSummary) {
          if (isSummary) return const SizedBox();
          return Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'rating',
        label: 'Rating',
        builder: (value, isDark, isSummary) {
          return Text(
            '${value.toString()} ⭐',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'onTime',
        label: 'On Time',
        builder: (value, isDark, isSummary) {
          if (isSummary) return const SizedBox();
          final onTime = value as bool;
          return Text(
            onTime ? 'Yes' : 'No',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: onTime ? Colors.green : Colors.orange,
              letterSpacing: 0,
            ),
          );
        },
      ),
      const TableColumn(key: 'action', label: ''),
    ];
  }

  // Customer Columns
  List<TableColumn> _buildCustomerColumns() {
    return [
      TableColumn(key: 'rank', label: '#'),
      TableColumn(
        key: 'customerName',
        label: 'Customer',
        builder: (value, isDark, isSummary) {
          if (isSummary) return const SizedBox();
          return Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'region',
        label: 'Region',
        builder: (value, isDark, isSummary) {
          if (isSummary) return const SizedBox();
          return Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'totalOrders',
        label: 'Orders',
        builder: (value, isDark, isSummary) {
          return Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSummary ? FontWeight.w700 : FontWeight.w600,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'percentageChange',
        label: 'Change',
        builder: (value, isDark, isSummary) =>
            PercentageChip(percentage: value as double, isDark: isDark),
      ),
      TableColumn(
        key: 'totalValue',
        label: 'Total Value',
        builder: (value, isDark, isSummary) {
          return Text(
            '\$${_formatNumber(value as int)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSummary ? FontWeight.w700 : FontWeight.w600,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'averageOrderValue',
        label: 'Avg Order',
        builder: (value, isDark, isSummary) {
          return Text(
            '\$${_formatNumber(value as int)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'satisfactionScore',
        label: 'Rating',
        builder: (value, isDark, isSummary) {
          return Text(
            '${value.toString()} ⭐',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      const TableColumn(key: 'action', label: ''),
    ];
  }

  // Product Columns
  List<TableColumn> _buildProductColumns() {
    return [
      TableColumn(key: 'rank', label: '#'),
      TableColumn(
        key: 'productName',
        label: 'Product',
        builder: (value, isDark, isSummary) {
          if (isSummary) return const SizedBox();
          return Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'category',
        label: 'Category',
        builder: (value, isDark, isSummary) {
          if (isSummary) return const SizedBox();
          return Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'unitsSold',
        label: 'Units Sold',
        builder: (value, isDark, isSummary) {
          return Text(
            _formatNumber(value as int),
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSummary ? FontWeight.w700 : FontWeight.w600,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'percentageChange',
        label: 'Change',
        builder: (value, isDark, isSummary) =>
            PercentageChip(percentage: value as double, isDark: isDark),
      ),
      TableColumn(
        key: 'revenue',
        label: 'Revenue',
        builder: (value, isDark, isSummary) {
          return Text(
            '\$${_formatNumber(value as int)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSummary ? FontWeight.w700 : FontWeight.w600,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'averagePrice',
        label: 'Avg Price',
        builder: (value, isDark, isSummary) {
          return Text(
            '\$${_formatNumber(value as int)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              letterSpacing: 0,
            ),
          );
        },
      ),
      TableColumn(
        key: 'stockStatus',
        label: 'Stock',
        builder: (value, isDark, isSummary) {
          if (isSummary) return const SizedBox();
          final status = value.toString();
          Color statusColor = Colors.green;
          if (status == 'Low Stock') {
            statusColor = Colors.orange;
          } else if (status == 'Out of Stock') {
            statusColor = Colors.red;
          }
          return Text(
            status,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: statusColor,
              letterSpacing: 0,
            ),
          );
        },
      ),
      const TableColumn(key: 'action', label: ''),
    ];
  }

  Widget _buildLoading() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        border: Border.all(color: AppColors.lightBorder),
      ),
      child: const Padding(
        padding: EdgeInsets.all(AppSpacing.xxl),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildError(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: isDark ? AppColors.grey600Dark : AppColors.grey600Light,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                _errorMessage ?? 'Failed to load data',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              ElevatedButton(onPressed: _loadData, child: const Text('Retry')),
            ],
          ),
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
