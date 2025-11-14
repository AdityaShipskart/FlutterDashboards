import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../const/constant.dart';

/// Highlights Section Widget
/// Displays highlights with total value, percentage change,
/// breakdown, and channel performance metrics
///
/// Types: 'sales', 'revenue', 'customers'
///
/// TODO: Replace dummy data with API calls
/// Example:
/// ```dart
/// final response = await http.get(
///   Uri.parse('https://your-api.com/api/highlights/sales'),
///   headers: {'Authorization': 'Bearer YOUR_API_KEY'},
/// );
/// ```
class DashboardRecentData extends StatefulWidget {
  final String type; // 'sales', 'revenue', or 'customers'

  const DashboardRecentData({super.key, this.type = 'sales'});

  @override
  State<DashboardRecentData> createState() => _DashboardRecentDataState();
}

class _DashboardRecentDataState extends State<DashboardRecentData> {
  bool _isLoading = true;
  Map<String, dynamic>? _data;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      // Load JSON file
      final String jsonString = await rootBundle.loadString(
        'assets/data/recent_acitivity_data.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      // Get the appropriate data based on type
      Map<String, dynamic> data;
      switch (widget.type) {
        case 'revenue':
          data = jsonData['revenueHighlights'] ?? jsonData['salesHighlights'];
          break;
        case 'customers':
          data = jsonData['customerHighlights'] ?? jsonData['salesHighlights'];
          break;
        case 'sales':
        default:
          data = jsonData['salesHighlights'];
      }

      setState(() {
        _data = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _data = null;
        _isLoading = false;
      });
      debugPrint('Error loading data: $e');
    }
  }

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

          // Content
          _isLoading
              ? _buildLoading()
              : _data == null
              ? _buildError()
              : Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isSmallScreen = constraints.maxWidth < 600;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Total Value Section
                          _buildTotalValue(isDark),

                          const SizedBox(height: AppSpacing.lg),

                          // Product Breakdown Bar
                          _buildProductBreakdown(isDark),

                          const SizedBox(height: AppSpacing.xl),

                          // Channel Performance
                          _buildChannelPerformance(isDark, isSmallScreen),
                        ],
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Highlights',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          Icon(
            Icons.more_vert,
            size: AppConstants.iconSizeMedium,
            color: isDark ? AppColors.grey600Dark : AppColors.grey600Light,
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Padding(
      padding: EdgeInsets.all(AppSpacing.xxl),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildError() {
    return const Padding(
      padding: EdgeInsets.all(AppSpacing.xxl),
      child: Center(child: Text('Failed to load data')),
    );
  }

  Widget _buildTotalValue(bool isDark) {
    if (_data == null) return const SizedBox();

    final title = _data!['title'] as String;
    final totalValue = _data!['totalValue'] as int;
    final currency = _data!['currency'] as String?;
    final percentageChange = _data!['percentageChange'] as double;
    final isPositive = _data!['isPositive'] as bool;

    final displayValue = _formatCurrency(totalValue, currency);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              displayValue,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
                height: 1.2,
              ),
            ),
            const SizedBox(width: AppSpacing.ml),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: isPositive
                    ? (isDark
                          ? AppColors.successSoftDark
                          : AppColors.successSoft)
                    : (isDark ? AppColors.errorSoftDark : AppColors.errorSoft),
                borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
              ),
              child: Text(
                '${isPositive ? '+' : '-'}${percentageChange.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isPositive ? AppColors.success : AppColors.error,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProductBreakdown(bool isDark) {
    if (_data == null) return const SizedBox();

    final products = _data!['products'] as List;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Progress Bar
        Container(
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.radiusXLarge),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.radiusXLarge),
            child: Row(
              children: products.map((product) {
                return Expanded(
                  flex: product['percentage'] as int,
                  child: Container(color: Color(product['color'] as int)),
                );
              }).toList(),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Legend
        Wrap(
          spacing: AppSpacing.lg,
          runSpacing: AppSpacing.sm,
          children: products.map((product) {
            return _buildLegendItem(
              product['name'] as String,
              Color(product['color'] as int),
              isDark,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color, bool isDark) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }

  Widget _buildChannelPerformance(bool isDark, bool isSmallScreen) {
    if (_data == null) return const SizedBox();

    final channels = _data!['channels'] as List;

    return Column(
      children: channels.map((channelData) {
        final channel = ChannelData(
          icon: _getIconData(channelData['icon'] as String),
          label: channelData['name'] as String,
          value: _formatCurrency(
            channelData['value'] as int,
            _data!['currency'] as String?,
          ),
          change: (channelData['percentageChange'] as num).toDouble(),
          isPositive: channelData['isPositive'] as bool,
        );

        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: _buildChannelRow(channel, isDark),
        );
      }).toList(),
    );
  }

  IconData _getIconData(String iconName) {
    final iconMap = {
      'store_outlined': Icons.store_outlined,
      'facebook_outlined': Icons.facebook_outlined,
      'photo_camera_outlined': Icons.photo_camera_outlined,
      'search': Icons.search,
      'storefront_outlined': Icons.storefront_outlined,
      'card_membership_outlined': Icons.card_membership_outlined,
      'shopping_cart_outlined': Icons.shopping_cart_outlined,
      'business_center_outlined': Icons.business_center_outlined,
      'support_agent_outlined': Icons.support_agent_outlined,
      'person_add_outlined': Icons.person_add_outlined,
      'replay_outlined': Icons.replay_outlined,
      'stars_outlined': Icons.stars_outlined,
      'timer_outlined': Icons.timer_outlined,
      'inventory_2_outlined': Icons.inventory_2_outlined,
      'description_outlined': Icons.description_outlined,
      'local_shipping_outlined': Icons.local_shipping_outlined,
      'schedule_outlined': Icons.schedule_outlined,
    };
    return iconMap[iconName] ?? Icons.help_outline;
  }

  String _formatCurrency(int value, String? currency) {
    if (currency == null) {
      return _formatNumber(value);
    }

    if (value >= 1000) {
      final thousands = value / 1000;
      return '\$${thousands.toStringAsFixed(1)}k';
    }

    return '\$${_formatNumber(value)}';
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  Widget _buildChannelRow(ChannelData channel, bool isDark) {
    return Row(
      children: [
        // Icon
        SizedBox(
          width: 36,
          height: 26,
          child: Icon(
            channel.icon,
            size: AppConstants.iconSizeMedium,
            color: isDark ? AppColors.grey600Dark : AppColors.grey600Light,
          ),
        ),

        const SizedBox(width: AppSpacing.xxs),

        // Label
        Expanded(
          child: Text(
            channel.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
        ),

        // Value
        Text(
          channel.value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),

        const SizedBox(width: AppSpacing.md),

        // Change Indicator
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              channel.isPositive ? Icons.arrow_upward : Icons.arrow_downward,
              size: 14,
              color: channel.isPositive ? AppColors.success : AppColors.error,
            ),
            // const SizedBox(width: AppSpacing.xxs),
            Text(
              '${channel.change.toStringAsFixed(1)}%',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: channel.isPositive ? AppColors.success : AppColors.error,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Channel Data Model
class ChannelData {
  final IconData icon;
  final String label;
  final String value;
  final double change;
  final bool isPositive;

  ChannelData({
    required this.icon,
    required this.label,
    required this.value,
    required this.change,
    required this.isPositive,
  });
}
