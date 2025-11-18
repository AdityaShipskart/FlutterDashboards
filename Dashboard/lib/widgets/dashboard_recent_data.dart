import 'package:flutter/material.dart';
import '../const/constant.dart';
// import 'package:get/utils.dart';
// import 'package:shipskart_ui/shipskart_ui.dart';

class DashboardRecentData extends StatefulWidget {
  final Map<String, dynamic>? data;
  final String type; // 'sales', 'revenue', or 'customers'

  const DashboardRecentData({super.key, this.data, this.type = 'sales'});

  // Example data
  static const Map<String, dynamic> exampleData = {
    'salesHighlights': {
      'title': 'Total Sales',
      'totalValue': 125430,
      'currency': '\$',
      'percentageChange': 12.5,
      'isPositive': true,
      'products': [
        {'name': 'Product A', 'percentage': 40, 'color': 0xFF4F46E5},
        {'name': 'Product B', 'percentage': 30, 'color': 0xFF10B981},
        {'name': 'Product C', 'percentage': 20, 'color': 0xFFF59E0B},
        {'name': 'Product D', 'percentage': 10, 'color': 0xFFEF4444},
      ],
      'channels': [
        {
          'icon': 'store_outlined',
          'name': 'Direct',
          'value': 45230,
          'percentageChange': 8.3,
          'isPositive': true,
        },
        {
          'icon': 'shopping_cart_outlined',
          'name': 'Online',
          'value': 38900,
          'percentageChange': 15.2,
          'isPositive': true,
        },
        {
          'icon': 'business_center_outlined',
          'name': 'Wholesale',
          'value': 28400,
          'percentageChange': -3.1,
          'isPositive': false,
        },
        {
          'icon': 'support_agent_outlined',
          'name': 'Partners',
          'value': 12900,
          'percentageChange': 5.7,
          'isPositive': true,
        },
      ],
    },
  };

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
      final Map<String, dynamic> jsonData =
          widget.data ?? DashboardRecentData.exampleData;

      Map<String, dynamic>? data;
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

      data ??= DashboardRecentData.exampleData['salesHighlights'];

      setState(() {
        _data = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _data = DashboardRecentData.exampleData['salesHighlights'];
        _isLoading = false;
      });
      debugPrint('DashboardRecentData: Error loading data $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.all(AppSpacing.sm),
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.getCard(isDark),
        borderRadius: BorderRadius.circular(AppConstants.radiusXLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 0.2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(isDark),

          // Divider
          Divider(height: 1, color: AppColors.getGreyScale(200, isDark)),

          // Content
          _isLoading
              ? _buildLoading()
              : _data == null
              ? _buildError()
              : Padding(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isSmallScreen = constraints.maxWidth < 600;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Total Value Section
                          _buildTotalValue(isDark),

                          SizedBox(height: AppSpacing.lg),

                          // Product Breakdown Bar
                          _buildProductBreakdown(isDark),

                          SizedBox(height: AppSpacing.xl),

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
      padding: EdgeInsets.all(AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Highlights', style: AuroraTheme.cardTitleStyle(isDark)),
          Icon(
            Icons.more_vert,
            size: AppConstants.iconSizeMedium,
            color: AppColors.getTextSecondary(isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.xxxl),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildError() {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.xxxl),
      child: const Center(child: Text('Failed to load data')),
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
          style: AppTextStyles.b14(
            isDark: isDark,
          ).copyWith(color: AppColors.getTextSecondary(isDark)),
        ),
        SizedBox(height: AppSpacing.xs),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              displayValue,
              style: AppTextStyles.h30(isDark: isDark).copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 32,
                height: 1.2,
              ),
            ),
            SizedBox(width: AppSpacing.ml),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: AuroraTheme.percentageContainerDecoration(
                isPositive: isPositive,
                isDark: isDark,
              ),
              child: Text(
                '${isPositive ? '+' : '-'}${percentageChange.toStringAsFixed(1)}%',
                style: AuroraTheme.percentageTextStyle(
                  isPositive: isPositive,
                  isDark: isDark,
                ).copyWith(fontSize: 12, fontWeight: FontWeight.w600),
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

        SizedBox(height: AppSpacing.md),

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
        SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: AppTextStyles.b14(
            isDark: isDark,
          ).copyWith(color: AppColors.getTextSecondary(isDark)),
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
          padding: EdgeInsets.only(bottom: AppSpacing.md),
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
            color: AppColors.getTextSecondary(isDark),
          ),
        ),

        SizedBox(width: AppSpacing.xxs),

        // Label
        Expanded(
          child: Text(
            channel.label,
            style: AppTextStyles.b14Medium(isDark: isDark),
          ),
        ),

        // Value
        Text(
          channel.value,
          style: AppTextStyles.b14(
            isDark: isDark,
          ).copyWith(fontWeight: FontWeight.w600),
        ),

        SizedBox(width: AppSpacing.md),

        // Change Indicator
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              channel.isPositive ? Icons.arrow_upward : Icons.arrow_downward,
              size: 14,
              color: channel.isPositive ? AppColors.success : AppColors.error,
            ),
            Text(
              '${channel.change.toStringAsFixed(1)}%',
              style: AppTextStyles.b14(isDark: isDark).copyWith(
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
