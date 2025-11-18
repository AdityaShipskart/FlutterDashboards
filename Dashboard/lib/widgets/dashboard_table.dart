import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'common/custom_data_table.dart';
import '../const/constant.dart';

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
        color: AppColors.getCard(isDark),
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        border: Border.all(color: AppColors.getGreyScale(200, isDark)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and subtitle
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.xxl,
              AppSpacing.xl,
              AppSpacing.xl,
              AppSpacing.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tableData['title'] as String,
                  style: AppTextStyles.b16(isDark: isDark).copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                  ),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  tableData['subtitle'] as String,
                  style: AppTextStyles.b14(isDark: isDark).copyWith(
                    color: AppColors.getTextSecondary(isDark),
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
            padding: EdgeInsets.all(AppSpacing.md),
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
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.map((tab) {
            final isSelected = tab == _selectedTableType;
            return Padding(
              padding: EdgeInsets.only(right: AppSpacing.sm),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedTableType = tab;
                    });
                  },
                  borderRadius: BorderRadius.circular(
                    AppConstants.radiusMedium,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.getGreyScale(100, isDark),
                      borderRadius: BorderRadius.circular(
                        AppConstants.radiusMedium,
                      ),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.getGreyScale(200, isDark),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      tab,
                      style:
                          AppTextStyles.b13(
                            isDark: isSelected ? true : isDark,
                          ).copyWith(
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : AppColors.getTextSecondary(isDark),
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
                style: AppTextStyles.b14(
                  isDark: isDark,
                ).copyWith(fontWeight: FontWeight.w600, letterSpacing: 0),
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
                style: AppTextStyles.b14Medium(
                  isDark: isDark,
                ).copyWith(letterSpacing: 0),
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
                      borderRadius: BorderRadius.circular(
                        AppConstants.radiusSmall,
                      ),
                      child: LinearProgressIndicator(
                        value: percent / 100,
                        backgroundColor: AppColors.getGreyScale(200, isDark),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          percent < 50
                              ? AppColors.error
                              : percent < 75
                              ? AppColors.warning
                              : AppColors.success,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Text(
                    '$percent%',
                    style: AppTextStyles.b13Medium(
                      isDark: isDark,
                    ).copyWith(color: AppColors.getTextSecondary(isDark)),
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
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children:
                    fields.take(2).map((field) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.getGreyScale(100, isDark),
                          borderRadius: BorderRadius.circular(
                            AppConstants.radiusSmall,
                          ),
                        ),
                        child: Text(
                          field.toString(),
                          style: AppTextStyles.b12(isDark: isDark).copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.getTextSecondary(isDark),
                          ),
                        ),
                      );
                    }).toList()..addAll(
                      fields.length > 2
                          ? [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSpacing.sm,
                                  vertical: AppSpacing.xs,
                                ),
                                child: Text(
                                  '+${fields.length - 2}',
                                  style: AppTextStyles.b12(isDark: isDark)
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.getTextSecondary(
                                          isDark,
                                        ),
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
                  bgColor = AppColors.error.withValues(alpha: 0.1);
                  textColor = AppColors.error;
                  break;
                case 'Needs Review':
                  bgColor = AppColors.warning.withValues(alpha: 0.1);
                  textColor = AppColors.warning;
                  break;
                case 'In Progress':
                  bgColor = AppColors.info.withValues(alpha: 0.1);
                  textColor = AppColors.info;
                  break;
                default:
                  bgColor = AppColors.success.withValues(alpha: 0.1);
                  textColor = AppColors.success;
              }

              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.ml,
                  vertical: AppSpacing.sd,
                ),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(
                    AppConstants.radiusSmall + 2,
                  ),
                ),
                child: Text(
                  status,
                  style: AppTextStyles.b13(
                    isDark: isDark,
                  ).copyWith(fontWeight: FontWeight.w600, color: textColor),
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
        border: Border.all(color: AppColors.grey200Light),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xxl),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildError(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.getCard(isDark),
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        border: Border.all(color: AppColors.getGreyScale(200, isDark)),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xxl),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: AppConstants.iconSizeXLarge,
                color: AppColors.getTextSecondary(isDark),
              ),
              SizedBox(height: AppSpacing.md),
              Text(
                _errorMessage ?? 'Failed to load data',
                style: AppTextStyles.b14(
                  isDark: isDark,
                ).copyWith(color: AppColors.getTextSecondary(isDark)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.md),
              ElevatedButton(onPressed: _loadData, child: const Text('Retry')),
            ],
          ),
        ),
      ),
    );
  }
}
