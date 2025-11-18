import 'package:flutter/material.dart';
import '../../const/constant.dart';

/// Standalone CustomDataTable widget - displays data in a responsive table format
///
/// Example usage:
/// ```dart
/// CustomDataTable(
///   title: 'Sales Report',
///   subtitle: 'Monthly overview',
///   columns: [
///     TableColumn(key: 'name', label: 'Product'),
///     TableColumn(key: 'sales', label: 'Sales'),
///   ],
///   dataRows: [
///     {'name': 'Product A', 'sales': '1000'},
///     {'name': 'Product B', 'sales': '1500'},
///   ],
/// )
/// ```
///
/// Example data structure:
/// columns: [TableColumn(key: 'name', label: 'Product'), ...]
/// dataRows: [{'name': 'Product A', 'sales': '1000'}, ...]
class CustomDataTable extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final List<TableColumn> columns;
  final List<Map<String, dynamic>> dataRows;
  final Function(Map<String, dynamic>)? onRowAction;
  final double minWidth;
  final bool expandToAvailableWidth;
  final List<dynamic>? switchOptions;
  final String? selectedSwitchOption;
  final Function(String)? onSwitchChanged;

  const CustomDataTable({
    super.key,
    this.title = 'Data Table', // Default example title
    this.subtitle = 'Summary of records', // Default example subtitle
    this.columns = const [], // Default empty, but will use example if empty
    this.dataRows = const [], // Default empty, but will use example if empty
    this.onRowAction,
    this.minWidth = 900,
    this.expandToAvailableWidth = true,
    this.switchOptions,
    this.selectedSwitchOption,
    this.onSwitchChanged,
  });

  // Example data for when no data is provided
  static final List<TableColumn> _exampleColumns = [
    TableColumn(key: 'name', label: 'Name'),
    TableColumn(key: 'value', label: 'Value'),
    TableColumn(key: 'status', label: 'Status'),
  ];

  static final List<Map<String, dynamic>> _exampleDataRows = [
    {'name': 'Item 1', 'value': '\$1,200', 'status': 'Active'},
    {'name': 'Item 2', 'value': '\$2,400', 'status': 'Pending'},
    {'name': 'Item 3', 'value': '\$1,800', 'status': 'Active'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Use example data if none provided
    final effectiveColumns = columns.isEmpty ? _exampleColumns : columns;
    final effectiveDataRows = dataRows.isEmpty ? _exampleDataRows : dataRows;

    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.getCard(isDark),
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        border: Border.all(color: AppColors.getGreyScale(200, isDark)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(isDark),

          // Divider
          Divider(height: 1, color: AppColors.getGreyScale(200, isDark)),

          // Table Content
          _buildTable(isDark, effectiveColumns, effectiveDataRows),

          // Divider
          Divider(height: 1, color: AppColors.getGreyScale(200, isDark)),
        ],
      ),
    );
  }

  Widget _buildSwitchOptions(bool isDark) {
    if (switchOptions == null || switchOptions!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.getGreyScale(100, isDark),
              borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: switchOptions!.asMap().entries.map((entry) {
                final option = entry.value.toString();
                final isSelected = selectedSwitchOption == option;

                return GestureDetector(
                  onTap: () {
                    if (onSwitchChanged != null) {
                      onSwitchChanged!(option);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.ml,
                      vertical: AppSpacing.sd,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(
                        AppConstants.radiusSmall + 2,
                      ),
                    ),
                    child: Text(
                      _formatOptionLabel(option),
                      style:
                          AppTextStyles.b12(
                            isDark: isSelected ? true : isDark,
                          ).copyWith(
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : AppColors.getTextPrimary(isDark),
                          ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _formatOptionLabel(String option) {
    switch (option) {
      case 'newly_added':
        return 'Newly Added';
      case 'pending':
        return 'Pending';
      case 'custom':
        return 'Custom';
      default:
        return option
            .replaceAll('_', ' ')
            .split(' ')
            .map(
              (word) => word.isNotEmpty
                  ? word[0].toUpperCase() + word.substring(1)
                  : word,
            )
            .join(' ');
    }
  }

  Widget _buildHeader(bool isDark) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.md),
      child: LayoutBuilder(
        builder: (context, constraints) {
          var commonWidget = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null && title!.isNotEmpty) ...[
                Text(
                  title!,
                  style: AppTextStyles.b16(
                    isDark: isDark,
                  ).copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],

              if (subtitle != null && subtitle!.isNotEmpty) ...[
                SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle!,
                  style: AppTextStyles.b14(
                    isDark: isDark,
                  ).copyWith(color: AppColors.getTextSecondary(isDark)),
                ),
              ],

              // Switch options right after subtitle
              if (switchOptions != null && switchOptions!.isNotEmpty) ...[
                SizedBox(height: AppSpacing.ml),
                _buildSwitchOptions(isDark),
              ],
            ],
          );

          if (MediaQuery.of(context).size.width < AppBreakpoints.tablet) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [commonWidget],
            );
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [commonWidget],
          );
        },
      ),
    );
  }

  Widget _buildTable(
    bool isDark,
    List<TableColumn> cols,
    List<Map<String, dynamic>> rows,
  ) {
    // Return empty container if no columns
    if (cols.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Text(
            'No data available',
            style: AppTextStyles.b14(
              isDark: isDark,
            ).copyWith(color: AppColors.getTextSecondary(isDark)),
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isDesktop = screenWidth >= AppBreakpoints.desktop;
        final isTablet =
            screenWidth >= AppBreakpoints.tablet &&
            screenWidth < AppBreakpoints.desktop;

        final columnSpacing = isDesktop
            ? AppSpacing.xxl
            : isTablet
            ? AppSpacing.xl
            : AppSpacing.md;

        final double configuredMinWidth = minWidth;

        // `constraints.maxWidth` can be infinite when nested in scrollables, so cap it.
        final double availableWidth =
            constraints.hasBoundedWidth && constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width;

        double targetWidth = configuredMinWidth;
        if (expandToAvailableWidth) {
          targetWidth = availableWidth > configuredMinWidth
              ? availableWidth
              : configuredMinWidth;
        }

        return Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: targetWidth),
              child: DataTable(
                horizontalMargin: AppSpacing.md,
                columnSpacing: columnSpacing,
                headingRowHeight: 48,
                dataRowMinHeight: 60,
                dataRowMaxHeight: 60,
                headingRowColor: WidgetStateProperty.all(
                  AppColors.getGreyScale(25, isDark),
                ),
                dividerThickness: 1,
                border: TableBorder(
                  horizontalInside: BorderSide(
                    color: AppColors.getGreyScale(200, isDark),
                    width: 1,
                  ),
                ),
                columns: cols
                    .map(
                      (col) => DataColumn(
                        label: Text(
                          col.label,
                          style: AppTextStyles.b14Medium(isDark: isDark)
                              .copyWith(
                                color: AppColors.getTextSecondary(isDark),
                                letterSpacing: 0,
                              ),
                        ),
                      ),
                    )
                    .toList(),
                rows: [
                  // Data rows
                  ...rows.map((row) => _buildDataRow(row, isDark, cols)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  DataRow _buildDataRow(
    Map<String, dynamic> row,
    bool isDark,
    List<TableColumn> cols,
  ) {
    return DataRow(
      cells: cols.map((col) {
        final value = row[col.key];

        // Special handling for action column
        if (col.key == 'action' && onRowAction != null) {
          return DataCell(
            IconButton(
              icon: Icon(
                Icons.more_horiz,
                size: AppConstants.iconSizeMedium,
                color: AppColors.getTextSecondary(isDark),
              ),
              onPressed: () => onRowAction!(row),
            ),
          );
        }

        return DataCell(
          col.builder != null
              ? col.builder!(value, isDark, false)
              : Text(
                  value?.toString() ?? '',
                  style: AppTextStyles.b14Medium(
                    isDark: isDark,
                  ).copyWith(letterSpacing: 0),
                ),
        );
      }).toList(),
    );
  }
}

/// Model class for table columns
class TableColumn {
  final String key;
  final String label;
  final Widget Function(dynamic value, bool isDark, bool isSummary)? builder;

  const TableColumn({required this.key, required this.label, this.builder});
}
