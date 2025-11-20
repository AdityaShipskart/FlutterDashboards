import 'package:flutter/material.dart';
import '../const/constant.dart';

class DashboardHorizontalBarChart extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<BarData> data;
  final List<TableRowData> tableData;

  const DashboardHorizontalBarChart({
    super.key,
    required this.title,
    required this.subtitle,
    required this.data,
    required this.tableData,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.getCard(isDark),
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: isDark ? AppColors.shadowDark : AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: AppSpacing.paddingLG,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.h22Compact(
                      isDark: isDark,
                    ).copyWith(fontWeight: AppTextStyles.bold),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    subtitle,
                    style: AppTextStyles.b14(
                      isDark: isDark,
                    ).copyWith(color: AppColors.getTextSecondary(isDark)),
                  ),
                ],
              ),
              Icon(
                Icons.more_horiz,
                color: AppColors.getGreyScale(700, isDark),
                size: AppConstants.iconSizeMedium,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Horizontal Bar Chart
          ...data.asMap().entries.map((entry) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: entry.key < data.length - 1 ? AppSpacing.md : 0,
              ),
              child: _buildBarItem(entry.value, isDark),
            );
          }).toList(),

          const SizedBox(height: AppSpacing.md),
          Divider(color: AppColors.getBorder(isDark)),
          const SizedBox(height: AppSpacing.md),

          // Table Header
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Stage',
                  style: AppTextStyles.b14(isDark: isDark).copyWith(
                    fontWeight: AppTextStyles.semiBold,
                    color: AppColors.getGreyScale(700, isDark),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Lost lead',
                  style: AppTextStyles.b14(isDark: isDark).copyWith(
                    fontWeight: AppTextStyles.semiBold,
                    color: AppColors.getGreyScale(700, isDark),
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(width: AppSpacing.xl),
              Expanded(
                child: Text(
                  'This week',
                  style: AppTextStyles.b14(isDark: isDark).copyWith(
                    fontWeight: AppTextStyles.semiBold,
                    color: AppColors.getGreyScale(700, isDark),
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Table Rows
          ...tableData.map((row) => _buildTableRow(row, isDark)).toList(),
        ],
      ),
    );
  }

  Widget _buildBarItem(BarData data, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                data.label,
                style: AppTextStyles.b14(
                  isDark: isDark,
                ).copyWith(color: AppColors.getGreyScale(700, isDark)),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Stack(
                children: [
                  // Background bar
                  Container(
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.getGreyScale(100, isDark),
                      borderRadius: BorderRadius.circular(AppSpacing.xs),
                    ),
                  ),
                  // Progress bar
                  FractionallySizedBox(
                    widthFactor: data.percentage / 100,
                    child: Container(
                      height: 32,
                      decoration: BoxDecoration(
                        color: data.color,
                        borderRadius: BorderRadius.circular(AppSpacing.xs),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${data.percentage.toStringAsFixed(0)}%',
                        style: AppTextStyles.b14(isDark: isDark).copyWith(
                          color: AppColors.white,
                          fontWeight: AppTextStyles.semiBold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTableRow(TableRowData row, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: row.color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  row.stage,
                  style: AppTextStyles.b14(
                    isDark: isDark,
                  ).copyWith(color: AppColors.getGreyScale(800, isDark)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              row.lostLead,
              style: AppTextStyles.b14(
                isDark: isDark,
              ).copyWith(color: AppColors.getGreyScale(600, isDark)),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: AppSpacing.xl),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xxs,
              ),
              decoration: BoxDecoration(
                color: row.changeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSpacing.xs),
              ),
              child: Text(
                row.thisMonth,
                style: AppTextStyles.b14(isDark: isDark).copyWith(
                  color: row.changeColor,
                  fontWeight: AppTextStyles.semiBold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BarData {
  final String label;
  final double percentage;
  final Color color;

  BarData({required this.label, required this.percentage, required this.color});
}

class TableRowData {
  final String stage;
  final String lostLead;
  final String thisMonth;
  final Color color;
  final Color changeColor;

  TableRowData({
    required this.stage,
    required this.lostLead,
    required this.thisMonth,
    required this.color,
    required this.changeColor,
  });
}
