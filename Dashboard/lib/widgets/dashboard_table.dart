import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'common/custom_data_table.dart';

// Local standalone constants to avoid external dependencies
class AppColors {
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textSecondaryDark = Color(0xFFB5B7C8);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color lightBorder = Color(0xFFE0E0E0);
  static const Color darkBorder = Color(0xFF363843);
  static const Color grey600Dark = Color(0xFF808290);
  static const Color grey600Light = Color(0xFF8E9198);
}

class AppConstants {
  static const double radiusLarge = 12.0;
}

class AppSpacing {
  static const double xxl = 32.0;
  static const double md = 16.0;
}

class DashboardTable extends StatefulWidget {
  final String? jsonFilePath;
  final Map<String, dynamic>? data;

  const DashboardTable({super.key, this.jsonFilePath, this.data});

  @override
  State<DashboardTable> createState() => _DashboardTableState();
}

class _DashboardTableState extends State<DashboardTable> {
  bool _isLoading = true;
  Map<String, dynamic>? _data;
  String? _errorMessage;
  String _selectedTableType = '';

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
      // Use provided data if available, otherwise load from JSON file
      final data =
          widget.data ??
          (widget.jsonFilePath != null
                  ? json.decode(
                      await rootBundle.loadString(widget.jsonFilePath!),
                    )
                  : <String, dynamic>{})
              as Map<String, dynamic>;

      if (mounted) {
        setState(() {
          _data = data;
          // Set default selected type to first option if available
          if (data.containsKey('header') &&
              data['header'] is Map<String, dynamic> &&
              data['header']['options'] is List &&
              (data['header']['options'] as List).isNotEmpty) {
            _selectedTableType = (data['header']['options'] as List)[0]
                .toString();
          }
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
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isDark ? const Color(0xFF363843) : const Color(0xFFE0E0E0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and subtitle
          Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tableData['title'] as String,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF212121),
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
                        ? const Color(0xFFB5B7C8)
                        : const Color(0xFF757575),
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
            padding: const EdgeInsets.all(32.0),
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
    // Get tabs from JSON options
    final List<String> tabs = [];
    if (_data != null &&
        _data!.containsKey('header') &&
        _data!['header'] is Map<String, dynamic> &&
        _data!['header']['options'] is List) {
      tabs.addAll(
        (_data!['header']['options'] as List).map((e) => e.toString()).toList(),
      );
    }

    // If no tabs found, return empty widget
    if (tabs.isEmpty) {
      return const SizedBox();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.map((tab) {
            final isSelected = tab == _selectedTableType;
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedTableType = tab;
                    });
                  },
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF1379F0)
                          : (isDark
                                ? const Color(0xFF363843)
                                : const Color(0xFFF4F4F4)),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF1379F0)
                            : (isDark
                                  ? const Color(0xFF363843)
                                  : const Color(0xFFE0E0E0)),
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
                                  ? const Color(0xFFB5B7C8)
                                  : const Color(0xFF757575)),
                        letterSpacing: 0,
                      ),
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

    // Get header information
    if (_data!.containsKey('header') &&
        _data!['header'] is Map<String, dynamic>) {
      final headerData = _data!['header'] as Map<String, dynamic>;
      title = headerData['title'] as String? ?? 'Data Table';
      subtitle = headerData['subtitle'] as String? ?? '';
    }

    // Get data for the selected option
    if (_data!.containsKey(tableType)) {
      final data = _data![tableType];
      if (data is List) {
        dataRows = data.map((item) => item as Map<String, dynamic>).toList();

        // Build columns based on the first row structure
        if (dataRows.isNotEmpty) {
          columns = _buildDynamicColumns(dataRows[0]);
        }
      }
    }

    return {
      'title': title,
      'subtitle': subtitle,
      'dataRows': dataRows,
      'columns': columns,
    };
  }

  // Build columns dynamically from data structure
  List<TableColumn> _buildDynamicColumns(Map<String, dynamic> sampleRow) {
    final columns = <TableColumn>[];

    sampleRow.forEach((key, value) {
      if (key == 'rank') {
        columns.add(TableColumn(key: 'rank', label: '#'));
      } else if (key == 'productId') {
        columns.add(
          TableColumn(
            key: 'productId',
            label: 'Product ID',
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
        );
      } else if (key == 'productName') {
        columns.add(
          TableColumn(
            key: 'productName',
            label: 'Product Name',
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
        );
      } else if (key == 'category') {
        columns.add(TableColumn(key: 'category', label: 'Category'));
      } else if (key == 'issueType') {
        columns.add(TableColumn(key: 'issueType', label: 'Issue Type'));
      } else if (key == 'completeness') {
        columns.add(
          TableColumn(
            key: 'completeness',
            label: 'Completeness',
            builder: (value, isDark, isSummary) {
              if (isSummary) return const SizedBox();
              final percent = value is int ? value : 0;
              return Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: percent / 100,
                        backgroundColor: isDark
                            ? const Color(0xFF363843)
                            : const Color(0xFFE0E0E0),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          percent < 50
                              ? const Color(0xFFEF4444)
                              : percent < 75
                              ? const Color(0xFFF59E0B)
                              : const Color(0xFF10B981),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$percent%',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      } else if (key == 'missingFields') {
        columns.add(
          TableColumn(
            key: 'missingFields',
            label: 'Missing Fields',
            builder: (value, isDark, isSummary) {
              if (isSummary) return const SizedBox();
              final fields = value is List ? value : [];
              return Wrap(
                spacing: 4,
                runSpacing: 4,
                children:
                    fields.take(2).map((field) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF363843)
                              : const Color(0xFFF4F4F4),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          field.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                          ),
                        ),
                      );
                    }).toList()..addAll(
                      fields.length > 2
                          ? [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                child: Text(
                                  '+${fields.length - 2}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: isDark
                                        ? AppColors.textSecondaryDark
                                        : AppColors.textSecondaryLight,
                                  ),
                                ),
                              ),
                            ]
                          : [],
                    ),
              );
            },
          ),
        );
      } else if (key == 'lastUpdated') {
        columns.add(TableColumn(key: 'lastUpdated', label: 'Last Updated'));
      } else if (key == 'status') {
        columns.add(
          TableColumn(
            key: 'status',
            label: 'Status',
            builder: (value, isDark, isSummary) {
              if (isSummary) return const SizedBox();
              final status = value.toString();
              Color bgColor;
              Color textColor;

              switch (status) {
                case 'Urgent':
                  bgColor = const Color(0xFFEF4444).withValues(alpha: 0.1);
                  textColor = const Color(0xFFEF4444);
                  break;
                case 'Needs Review':
                  bgColor = const Color(0xFFF59E0B).withValues(alpha: 0.1);
                  textColor = const Color(0xFFF59E0B);
                  break;
                case 'In Progress':
                  bgColor = const Color(0xFF3B82F6).withValues(alpha: 0.1);
                  textColor = const Color(0xFF3B82F6);
                  break;
                default:
                  bgColor = const Color(0xFF10B981).withValues(alpha: 0.1);
                  textColor = const Color(0xFF10B981);
              }

              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              );
            },
          ),
        );
      }
    });

    return columns;
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
}
