import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String iconKey;
  final String value;
  final String label;
  final String? growth;
  final Color color;
  final Color iconBgColor;

  const DashboardCard({
    super.key,
    this.iconKey = 'revenue', // Default icon key
    this.value = '\$1,234', // Default example value
    this.label = 'Metric Label', // Default example label
    this.growth = '+5.3%', // Default example growth
    this.color = Colors.blue, // Default example color
    this.iconBgColor = const Color(0xFFEBF5FF), // Default example bg color
  });

  // Inline color getter - no external dependencies
  static Color _getCardColor(bool isDark) {
    return isDark ? const Color(0xFF1F2937) : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      constraints: const BoxConstraints(minHeight: 120, maxHeight: 150),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _getCardColor(isDark),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Background Image
          Positioned(
            top: -10,
            left: -10,
            child: Image.asset(
              'assets/backgrounds/card-bg.png',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
            ),
          ),

          // Growth Chip (inline version - no external dependency)
          if (growth != null) ...[
            Positioned(
              top: 0,
              right: 0,
              child: _buildPercentageChip(
                double.tryParse(
                      growth!.replaceAll('%', '').replaceAll('+', ''),
                    ) ??
                    0.0,
                isDark,
              ),
            ),
          ],

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon Container
              Expanded(
                flex: 3,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(child: _buildIcon(iconKey, color)),
                ),
              ),

              const SizedBox(width: 12),

              // Value and Label
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? const Color(0xFFF9FAFB)
                                  : const Color(0xFF111827),
                              height: 1.0,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      ),

                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? const Color(0xFF9CA3AF)
                              : const Color(0xFF6B7280),
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(String key, Color color) {
    const iconMap = {
      'revenue': Icons.trending_up,
      'users': Icons.group_outlined,
      'orders': Icons.shopping_cart_outlined,
      'profit': Icons.payments_outlined,
      'messages': Icons.chat_bubble_outline,
      'notifications': Icons.notifications_outlined,
      'settings': Icons.settings,
    };

    final icon = iconMap[key] ?? Icons.circle;
    return Icon(icon, size: 28, color: color);
  }

  // Inline percentage chip builder - no external dependencies
  Widget _buildPercentageChip(double percentage, bool isDark) {
    final isPositive = percentage >= 0;

    // Inline colors
    const successLight = Color(0xFF10B981);
    const successDark = Color(0xFF34D399);
    const successSoftLight = Color(0xFFD1FAE5);
    const successSoftDark = Color(0xFF064E3B);
    const errorLight = Color(0xFFEF4444);
    const errorDark = Color(0xFFF87171);
    const errorSoftLight = Color(0xFFFEE2E2);
    const errorSoftDark = Color(0xFF7F1D1D);

    final color = isPositive
        ? (isDark ? successDark : successLight)
        : (isDark ? errorDark : errorLight);

    final bgColor = isPositive
        ? (isDark ? successSoftDark : successSoftLight)
        : (isDark ? errorSoftDark : errorSoftLight);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive ? Icons.arrow_upward : Icons.arrow_downward,
            size: 12,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            '${percentage.abs().toStringAsFixed(1)}%',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }
}
