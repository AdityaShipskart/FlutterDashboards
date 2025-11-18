import 'package:flutter/material.dart';
import '../const/constant.dart';

/// Example data for when no data is provided
const Map<String, dynamic> _exampleData = {
  'title': 'Quick Wins',
  'subtitle': 'Take action on high-value opportunities',
  'icon': Icons.trending_up,
  'switch-options': ['Pending RFQs', 'Upcoming Deliveries'],
  'Pending RFQs': [
    {
      'name': 'Marine Engine Parts',
      'value': '\$45,230',
      'percentage': 12.5,
      'trend': 'up',
      'priority': 'HIGH',
      'daysLeft': 3,
      'status': 'pending',
      'color': 0xFFFF6F1E, // Orange indicator
    },
    {
      'name': 'Deck Equipment',
      'value': '\$32,100',
      'percentage': 8.3,
      'trend': 'up',
      'priority': 'MEDIUM',
      'daysLeft': 5,
      'status': 'pending',
      'color': 0xFF1379F0, // Blue indicator
    },
    {
      'name': 'Safety Gear Package',
      'value': '\$18,900',
      'percentage': 15.7,
      'trend': 'up',
      'priority': 'HIGH',
      'daysLeft': 2,
      'status': 'pending',
      'color': 0xFFEF4444, // Red indicator
    },
  ],
  'Upcoming Deliveries': [
    {
      'name': 'Hydraulic Systems',
      'value': '\$67,500',
      'percentage': 5.2,
      'trend': 'up',
      'priority': 'HIGH',
      'daysLeft': 4,
      'status': 'scheduled',
      'color': 0xFF10B981, // Green indicator
    },
    {
      'name': 'Navigation Equipment',
      'value': '\$28,400',
      'percentage': -2.1,
      'trend': 'down',
      'priority': 'MEDIUM',
      'daysLeft': 7,
      'status': 'scheduled',
      'color': 0xFF8B5CF6, // Purple indicator
    },
  ],
};

/// DashboardQuickWins - A widget displaying actionable items with priority and deadlines
///
/// This widget displays a list of high-value opportunities that require action,
/// with support for multiple categories via tab switching.
///
/// Features:
/// - Header with icon, title, and subtitle
/// - Tab switching between different categories
/// - Priority badges (HIGH, MEDIUM, LOW)
/// - Value display with growth percentage indicators
/// - Days left indicator with clock icon
/// - Action button for each item
/// - Colored circle indicators for each item
///
/// Example usage:
/// ```dart
/// DashboardQuickWins(
///   data: {
///     'title': 'Quick Wins',
///     'subtitle': 'Take action on high-value opportunities',
///     'icon': Icons.trending_up,
///     'switch-options': ['Pending RFQs', 'Upcoming Deliveries'],
///     'Pending RFQs': [
///       {
///         'name': 'Marine Engine Parts',
///         'value': '\$45,230',
///         'percentage': 12.5,
///         'trend': 'up',
///         'priority': 'HIGH',
///         'daysLeft': 3,
///         'color': 0xFFFF6F1E,
///       },
///     ],
///   },
/// )
/// ```
class DashboardQuickWins extends StatefulWidget {
  final Map<String, dynamic> data;
  final double minWidth;
  final bool expandToAvailableWidth;

  const DashboardQuickWins({
    super.key,
    Map<String, dynamic>? data,
    this.minWidth = 440,
    this.expandToAvailableWidth = false,
  }) : data = data ?? _exampleData;

  @override
  State<DashboardQuickWins> createState() => _DashboardQuickWinsState();
}

class _DashboardQuickWinsState extends State<DashboardQuickWins> {
  String? selectedTab;

  @override
  void initState() {
    super.initState();
    // Initialize with first tab option if available
    final tabOptions = widget.data['switch-options'] as List<dynamic>?;
    if (tabOptions != null && tabOptions.isNotEmpty) {
      selectedTab = tabOptions.first.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final title = widget.data['title'] ?? 'Quick Wins';
    final subtitle =
        widget.data['subtitle'] ?? 'Take action on high-value opportunities';
    final icon = widget.data['icon'] as IconData? ?? Icons.trending_up;

    return Container(
      constraints: BoxConstraints(
        minWidth: widget.minWidth,
        maxWidth: widget.expandToAvailableWidth
            ? double.infinity
            : widget.minWidth + 200,
      ),
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.getCard(isDark),
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        border: Border.all(color: AppColors.getBorder(isDark)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with icon, title, and subtitle
          _buildHeader(isDark, icon, title, subtitle),

          SizedBox(height: AppSpacing.md),

          // Tab buttons
          _buildTabButtons(isDark),

          SizedBox(height: AppSpacing.md),

          // Items list
          _buildItemsList(isDark),
        ],
      ),
    );
  }

  /// Build header section with icon, title, and subtitle
  Widget _buildHeader(
    bool isDark,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon container
        Container(
          padding: EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.primarySoftDark
                : AppColors.primarySoftLight,
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          ),
          child: Icon(
            icon,
            size: AppConstants.iconSizeMedium,
            color: AppColors.primary,
          ),
        ),

        SizedBox(width: AppSpacing.ml),

        // Title and subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.h22(
                  isDark: isDark,
                ).copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: AppSpacing.xxs),
              Text(
                subtitle,
                style: AppTextStyles.b12(
                  isDark: isDark,
                ).copyWith(color: AppColors.getTextSecondary(isDark)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build tab switching buttons
  Widget _buildTabButtons(bool isDark) {
    final tabOptions = widget.data['switch-options'] as List<dynamic>?;

    if (tabOptions == null || tabOptions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.grey200Dark : AppColors.grey100Light,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: tabOptions.map((option) {
          final optionStr = option.toString();
          final isSelected = selectedTab == optionStr;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTab = optionStr;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(
                  AppConstants.radiusSmall + 2,
                ),
              ),
              child: Text(
                optionStr,
                style: AppTextStyles.b12(isDark: isSelected ? true : isDark)
                    .copyWith(
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
    );
  }

  /// Build list of quick win items
  Widget _buildItemsList(bool isDark) {
    // Get items based on selected tab
    List<dynamic> items = [];

    if (selectedTab != null && widget.data.containsKey(selectedTab!)) {
      items = (widget.data[selectedTab!] ?? []) as List<dynamic>;
    } else {
      // Fallback to 'items' or 'data' key
      items =
          (widget.data['items'] ?? widget.data['data'] ?? []) as List<dynamic>;
    }

    if (items.isEmpty) {
      return _buildEmptyState(isDark);
    }

    // Calculate height: show max 3 items, enable scroll if more
    const int maxVisibleItems = 3;
    final bool needsScroll = items.length > maxVisibleItems;

    // Approximate height per item (padding + content)
    const double itemHeight = 120.0; // Adjust based on actual item height
    final double maxHeight = needsScroll
        ? itemHeight * maxVisibleItems
        : itemHeight * items.length;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: SingleChildScrollView(
        physics: needsScroll
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        child: Column(
          children: items
              .map((item) => _buildQuickWinItem(isDark, item))
              .toList(),
        ),
      ),
    );
  }

  /// Build empty state when no items available
  Widget _buildEmptyState(bool isDark) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      alignment: Alignment.center,
      child: Column(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: AppConstants.iconSizeLarge,
            color: AppColors.getTextSecondary(isDark),
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            'No items available',
            style: AppTextStyles.b14(
              isDark: isDark,
            ).copyWith(color: AppColors.getTextSecondary(isDark)),
          ),
        ],
      ),
    );
  }

  /// Build individual quick win item
  Widget _buildQuickWinItem(bool isDark, Map<String, dynamic> item) {
    final name = item['name'] ?? item['portName'] ?? 'Unknown Item';
    final value = item['value'] ?? item['purchaseValue'] ?? '\$0';
    final percentage =
        (item['percentage'] ?? item['percentageChange'] ?? 0.0) as num;
    final trend = item['trend'] ?? 'neutral';
    final priority = (item['priority'] ?? 'MEDIUM').toString().toUpperCase();
    // final status = item['status'] ?? ' ';
    final colorValue = item['color'] as int?;
    final indicatorColor = colorValue != null
        ? Color(colorValue)
        : AppColors.primary;

    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.ml),
      padding: EdgeInsets.all(AppSpacing.ml),
      decoration: BoxDecoration(
        color: isDark ? AppColors.grey100Dark : AppColors.grey50Light,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        border: Border.all(
          color: isDark ? AppColors.grey300Dark : AppColors.grey200Light,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Indicator, Name, and Priority Badge
          Row(
            children: [
              // Colored circle indicator
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: indicatorColor,
                  shape: BoxShape.circle,
                ),
              ),

              SizedBox(width: AppSpacing.sm),

              // Item name
              Expanded(
                child: Text(
                  name,
                  style: AppTextStyles.b14(isDark: isDark).copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.getTextPrimary(isDark),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              SizedBox(width: AppSpacing.sm),

              // Priority badge
              _buildPriorityBadge(isDark, priority),
            ],
          ),

          SizedBox(height: AppSpacing.sm),

          // Row 2: Order Value with percentage
          _buildValueWithPercentage(isDark, value, percentage, trend),

          SizedBox(height: AppSpacing.sm),

          // Row 3: Days left and Action button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusIndicator(isDark, item['status'] ?? ' '),
              _buildActionButton(isDark),
            ],
          ),
        ],
      ),
    );
  }

  /// Build priority badge
  Widget _buildPriorityBadge(bool isDark, String priority) {
    Color bgColor;
    Color textColor;

    switch (priority) {
      case 'HIGH PRIORITY':
      case 'HIGH':
        bgColor = isDark ? const Color(0xFFFFEBEE) : const Color(0xFFFFEBEE);
        textColor = isDark ? const Color(0xFFDC2626) : const Color(0xFFDC2626);
        break;
      case 'MEDIUM PRIORITY':
      case 'MEDIUM':
        bgColor = isDark ? const Color(0xFFFFF8E1) : const Color(0xFFFFF8E1);
        textColor = isDark ? const Color(0xFFEA580C) : const Color(0xFFEA580C);
        break;
      case 'LOW PRIORITY':
      case 'LOW':
        bgColor = isDark ? const Color(0xFFD1FAE5) : const Color(0xFFD1FAE5);
        textColor = isDark ? const Color(0xFF059669) : const Color(0xFF059669);
        break;
      default:
        bgColor = isDark ? AppColors.grey200Dark : AppColors.grey100Light;
        textColor = AppColors.getTextSecondary(isDark);
    }

    // Format priority text - display as "Priority Name" instead of "NAME PRIORITY"
    String displayText = priority
        .replaceAll('PRIORITY', '')
        .trim()
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
    displayText = '$displayText Priority';

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: textColor, // Border color matches text color
          width: 0.4,
        ),
      ),
      child: Text(
        displayText,
        style: AppTextStyles.b12(isDark: isDark).copyWith(
          color: textColor,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  /// Build value with growth percentage indicator
  Widget _buildValueWithPercentage(
    bool isDark,
    String value,
    num percentage,
    String trend,
  ) {
    final isPositive = trend == 'up';
    final isNegative = trend == 'down';

    return Row(
      children: [
        // Value label
        // Text(
        //   'Order Value: ',
        //   style: AppTextStyles.b12(
        //     isDark: isDark,
        //   ).copyWith(color: AppColors.getTextSecondary(isDark)),
        // ),

        // Value amount
        Text(
          value,
          style: AppTextStyles.b14(isDark: isDark).copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.getTextPrimary(isDark),
          ),
        ),

        SizedBox(width: AppSpacing.sm),

        // Growth indicator
        if (isPositive || isNegative) ...[
          Icon(
            isPositive ? Icons.arrow_upward : Icons.arrow_downward,
            size: AppConstants.iconSizeSmall - 2,
            color: isPositive
                ? (isDark ? AppColors.successActiveDark : AppColors.success)
                : (isDark ? AppColors.errorActiveDark : AppColors.error),
          ),
          SizedBox(width: AppSpacing.xxs),
          Text(
            '${percentage.toStringAsFixed(1)}%',
            style: AppTextStyles.b12(isDark: isDark).copyWith(
              fontWeight: FontWeight.w600,
              color: isPositive
                  ? (isDark ? AppColors.successActiveDark : AppColors.success)
                  : (isDark ? AppColors.errorActiveDark : AppColors.error),
            ),
          ),
        ],
      ],
    );
  }

  /// Build days left indicator
  Widget _buildStatusIndicator(bool isDark, String status) {
    return Row(
      children: [
        Icon(
          Icons.schedule,
          size: AppConstants.iconSizeSmall,
          color: AppColors.getTextSecondary(isDark),
        ),
        SizedBox(width: AppSpacing.xs),
        Text(
          '$status ',
          style: AppTextStyles.b12(
            isDark: isDark,
          ).copyWith(color: AppColors.getTextSecondary(isDark)),
        ),
      ],
    );
  }

  /// Build action button
  Widget _buildActionButton(bool isDark) {
    return InkWell(
      onTap: () {
        // Handle action button tap
        debugPrint('Take Action button pressed');
      },
      borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.ml,
          vertical: AppSpacing.sd,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Take Action',
              style: AppTextStyles.b12(
                isDark: true,
              ).copyWith(fontWeight: FontWeight.w600, color: Colors.white),
            ),
            SizedBox(width: AppSpacing.xs),
            Icon(
              Icons.arrow_forward,
              size: AppConstants.iconSizeSmall,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
