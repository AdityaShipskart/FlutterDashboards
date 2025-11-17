import 'package:flutter/material.dart';
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

  // Inline constants - no external dependencies
  static const double _spacingXs = 4.0;
  static const double _spacingXxs = 2.0;
  static const double _spacingSm = 8.0;
  static const double _spacingMd = 16.0;
  static const double _spacingLg = 24.0;
  static const double _spacingXl = 32.0;
  static const double _spacingXxl = 48.0;
  static const double _spacingMl = 12.0;
  static const double _radiusLarge = 12.0;
  static const double _radiusMedium = 8.0;
  static const double _radiusXLarge = 16.0;
  static const double _iconSizeMedium = 24.0;

  static const Color _darkSurface = Color(0xFF1A1A1A);
  static const Color _darkBorder = Color(0xFF363843);
  static const Color _darkDivider = Color(0xFF363843);
  static const Color _lightBorder = Color(0xFFE0E0E0);
  static const Color _lightDivider = Color(0xFFE0E0E0);
  static const Color _textPrimaryDark = Color(0xFFFFFFFF);
  static const Color _textPrimaryLight = Color(0xFF212121);
  static const Color _textSecondaryDark = Color(0xFFB5B7C8);
  static const Color _textSecondaryLight = Color(0xFF757575);
  static const Color _grey600Dark = Color(0xFF808290);
  static const Color _grey600Light = Color(0xFF8E9198);
  static const Color _success = Color(0xFF10B981);
  static const Color _successSoft = Color(0xFFD1FAE5);
  static const Color _successSoftDark = Color(0xFF064E3B);
  static const Color _error = Color(0xFFEF4444);
  static const Color _errorSoft = Color(0xFFFEE2E2);
  static const Color _errorSoftDark = Color(0xFF7F1D1D);

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
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        // color: context.colorPalette.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
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
          Divider(height: 1, color: isDark ? _darkDivider : _lightDivider),

          // Content
          _isLoading
              ? _buildLoading()
              : _data == null
              ? _buildError()
              : Padding(
                  padding: const EdgeInsets.all(_spacingLg),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isSmallScreen = constraints.maxWidth < 600;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Total Value Section
                          _buildTotalValue(isDark),

                          const SizedBox(height: _spacingLg),

                          // Product Breakdown Bar
                          _buildProductBreakdown(isDark),

                          const SizedBox(height: _spacingXl),

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
      padding: EdgeInsetsGeometry.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Highlights',
            // style: context.textTheme.titleMedium?.copyWith(
            //             fontWeight: FontWeight.bold,
            //             color: isDark ? Colors.white : Colors.black,
            //           ),
          ),
          Icon(
            Icons.more_vert,
            size: _iconSizeMedium,
            color: isDark ? _grey600Dark : _grey600Light,
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Padding(
      padding: EdgeInsets.all(_spacingXxl),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildError() {
    return const Padding(
      padding: EdgeInsets.all(_spacingXxl),
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
            color: isDark ? _textSecondaryDark : _textSecondaryLight,
          ),
        ),
        const SizedBox(height: _spacingXs),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              displayValue,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: isDark ? _textPrimaryDark : _textPrimaryLight,
                height: 1.2,
              ),
            ),
            const SizedBox(width: _spacingMl),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: _spacingSm,
                vertical: _spacingXs,
              ),
              decoration: BoxDecoration(
                color: isPositive
                    ? (isDark ? _successSoftDark : _successSoft)
                    : (isDark ? _errorSoftDark : _errorSoft),
                borderRadius: BorderRadius.circular(_radiusMedium),
              ),
              child: Text(
                '${isPositive ? '+' : '-'}${percentageChange.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isPositive ? _success : _error,
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
            borderRadius: BorderRadius.circular(_radiusXLarge),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_radiusXLarge),
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

        const SizedBox(height: _spacingMd),

        // Legend
        Wrap(
          spacing: _spacingLg,
          runSpacing: _spacingSm,
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
        const SizedBox(width: _spacingXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? _textSecondaryDark : _textSecondaryLight,
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
          padding: const EdgeInsets.only(bottom: _spacingMd),
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
            size: _iconSizeMedium,
            color: isDark ? _grey600Dark : _grey600Light,
          ),
        ),

        const SizedBox(width: _spacingXxs),

        // Label
        Expanded(
          child: Text(
            channel.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? _textPrimaryDark : _textPrimaryLight,
            ),
          ),
        ),

        // Value
        Text(
          channel.value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? _textPrimaryDark : _textPrimaryLight,
          ),
        ),

        const SizedBox(width: _spacingMd),

        // Change Indicator
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              channel.isPositive ? Icons.arrow_upward : Icons.arrow_downward,
              size: 14,
              color: channel.isPositive ? _success : _error,
            ),
            // const SizedBox(width: _spacingXxs),
            Text(
              '${channel.change.toStringAsFixed(1)}%',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: channel.isPositive ? _success : _error,
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
