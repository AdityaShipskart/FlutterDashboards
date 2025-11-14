import 'package:flutter/material.dart';
import '../../const/constant.dart';

class CustomDataTable extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<TableColumn> columns;
  final List<Map<String, dynamic>> dataRows;
  final Function(Map<String, dynamic>)? onRowAction;

  const CustomDataTable({
    super.key,
    required this.title,
    required this.subtitle,
    required this.columns,
    required this.dataRows,
    this.onRowAction,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
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
          // Header
          _buildHeader(isDark),

          // Divider
          Divider(
            height: 1,
            color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
          ),

          // Table Content
          _buildTable(isDark),

          // Divider
          Divider(
            height: 1,
            color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 600;

          if (isSmallScreen) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTable(bool isDark) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 1024;
        final isTablet =
            constraints.maxWidth > 768 && constraints.maxWidth <= 1024;

        final columnSpacing = isDesktop
            ? AppSpacing.xxl
            : isTablet
            ? AppSpacing.xl
            : AppSpacing.lg;

        final minTableWidth = 900.0;

        return Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth > minTableWidth
                    ? constraints.maxWidth
                    : minTableWidth,
              ),
              child: DataTable(
                horizontalMargin: AppSpacing.lg,
                columnSpacing: columnSpacing,
                headingRowHeight: 48,
                dataRowMinHeight: 60,
                dataRowMaxHeight: 60,
                headingRowColor: WidgetStateProperty.all(
                  isDark ? AppColors.grey200Dark : AppColors.grey25Light,
                ),
                dividerThickness: 1,
                border: TableBorder(
                  horizontalInside: BorderSide(
                    color: isDark
                        ? AppColors.grey300Dark
                        : AppColors.grey200Light,
                    width: 1,
                  ),
                ),
                columns: columns
                    .map(
                      (col) => DataColumn(
                        label: Text(
                          col.label,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: isDark
                                ? AppColors.grey600Dark
                                : AppColors.grey900Light,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                rows: [
                  // Data rows
                  ...dataRows.map((row) => _buildDataRow(row, isDark)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  DataRow _buildDataRow(Map<String, dynamic> row, bool isDark) {
    return DataRow(
      cells: columns.map((col) {
        final value = row[col.key];

        // Special handling for action column
        if (col.key == 'action' && onRowAction != null) {
          return DataCell(
            IconButton(
              icon: Icon(
                Icons.more_horiz,
                size: AppConstants.iconSizeMedium,
                color: isDark ? AppColors.grey600Dark : AppColors.grey600Light,
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
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                    letterSpacing: 0,
                  ),
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
