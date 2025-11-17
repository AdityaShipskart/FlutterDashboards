import 'package:flutter/material.dart';

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

  const CustomDataTable({
    super.key,
    this.title = 'Data Table', // Default example title
    this.subtitle = 'Summary of records', // Default example subtitle
    this.columns = const [], // Default empty, but will use example if empty
    this.dataRows = const [], // Default empty, but will use example if empty
    this.onRowAction,
    this.minWidth = 900,
    this.expandToAvailableWidth = true,
  });

  // Inline constants - no external dependencies
  static const double _spacingXs = 4.0;
  static const double _spacingLg = 16.0;
  static const double _spacingXl = 20.0;
  static const double _spacingXxl = 24.0;
  static const double _radiusLarge = 12.0;
  static const double _iconSizeMedium = 24.0;

  // Inline colors - no external dependencies
  static const Color _darkSurface = Color(0xFF1F2937);
  static const Color _darkBorder = Color(0xFF374151);
  static const Color _darkDivider = Color(0xFF374151);
  static const Color _textPrimaryDark = Color(0xFFF9FAFB);
  static const Color _textSecondaryDark = Color(0xFF9CA3AF);
  static const Color _textPrimaryLight = Color(0xFF111827);
  static const Color _textSecondaryLight = Color(0xFF6B7280);
  static const Color _grey25Light = Color(0xFFFCFCFD);
  static const Color _grey200Light = Color(0xFFE5E7EB);
  static const Color _grey200Dark = Color(0xFF374151);
  static const Color _grey300Dark = Color(0xFF4B5563);
  static const Color _grey600Dark = Color(0xFF9CA3AF);
  static const Color _grey600Light = Color(0xFF6B7280);
  static const Color _grey900Light = Color(0xFF111827);
  static const Color _lightBorder = Color(0xFFE5E7EB);
  static const Color _lightDivider = Color(0xFFE5E7EB);

  // Inline responsive breakpoint methods
  static bool _isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 850;

  static bool _isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

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
      padding: const EdgeInsets.all(_spacingLg),
      decoration: BoxDecoration(
        color: isDark ? _darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(_radiusLarge),
        border: Border.all(color: isDark ? _darkBorder : _lightBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(isDark),

          // Divider
          Divider(height: 1, color: isDark ? _darkDivider : _lightDivider),

          // Table Content
          _buildTable(isDark, effectiveColumns, effectiveDataRows),

          // Divider
          Divider(height: 1, color: isDark ? _darkDivider : _lightDivider),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: _spacingLg),
      child: LayoutBuilder(
        builder: (context, constraints) {
          var commonWidget = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null && title!.isNotEmpty) ...[
                Text(
                  title!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark ? _textPrimaryDark : _textPrimaryLight,
                  ),
                ),
              ],

              if (subtitle != null && subtitle!.isNotEmpty) ...[
                const SizedBox(height: _spacingXs),
                Text(
                  subtitle!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: isDark ? _textSecondaryDark : _textSecondaryLight,
                  ),
                ),
              ],
            ],
          );

          if (_isMobile(context)) {
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
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'No data available',
            style: TextStyle(
              color: isDark ? _textSecondaryDark : _textSecondaryLight,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = _isDesktop(context);
        final isTablet = _isTablet(context);

        final columnSpacing = isDesktop
            ? _spacingXxl
            : isTablet
            ? _spacingXl
            : _spacingLg;

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
                horizontalMargin: _spacingLg,
                columnSpacing: columnSpacing,
                headingRowHeight: 48,
                dataRowMinHeight: 60,
                dataRowMaxHeight: 60,
                headingRowColor: WidgetStateProperty.all(
                  isDark ? _grey200Dark : _grey25Light,
                ),
                dividerThickness: 1,
                border: TableBorder(
                  horizontalInside: BorderSide(
                    color: isDark ? _grey300Dark : _grey200Light,
                    width: 1,
                  ),
                ),
                columns: cols
                    .map(
                      (col) => DataColumn(
                        label: Text(
                          col.label,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: isDark ? _grey600Dark : _grey900Light,
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
                size: _iconSizeMedium,
                color: isDark ? _grey600Dark : _grey600Light,
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
                    color: isDark ? _textPrimaryDark : _textPrimaryLight,
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
