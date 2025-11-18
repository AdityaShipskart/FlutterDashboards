import 'package:flutter/material.dart';
import '../const/constant.dart';
// import 'package:shipskart_ui/shipskart_ui.dart';

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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      constraints: const BoxConstraints(minHeight: 120, maxHeight: 160),
      padding: AppSpacing.paddingMD,
      decoration: BoxDecoration(
        color: AppColors.getCard(isDark),
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: isDark ? AppColors.shadowDark : AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 0.2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Image
          Positioned(
            top: 10,
            left: 60,
            child: Image.asset(
              'assets/backgrounds/card-bg.png',
              width: 160,
              height: 160,
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
                flex: 2,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(
                      AppConstants.radiusMedium,
                    ),
                  ),
                  child: Center(child: _buildIcon(iconKey, color)),
                ),
              ),

              SizedBox(width: AppSpacing.ml),

              // Value and Label
              Expanded(
                flex: 4,
                child: Padding(
                  padding: AppSpacing.paddingXS,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            value,
                            style: AppTextStyles.h30(isDark: isDark).copyWith(
                              fontWeight: FontWeight.w500,
                              height: 1.0,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      ),

                      Text(
                        label,
                        style: AppTextStyles.b13Medium(isDark: isDark).copyWith(
                          color: AppColors.getTextSecondary(isDark),
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
    return Icon(icon, size: AppConstants.iconSizeMedium, color: color);
  }

  // Inline percentage chip builder - no external dependencies
  Widget _buildPercentageChip(double percentage, bool isDark) {
    final isPositive = percentage >= 0;

    final color = isPositive
        ? (isDark ? AppColors.successActiveDark : AppColors.success)
        : (isDark ? AppColors.errorActiveDark : AppColors.error);

    final bgColor = isPositive
        ? (isDark ? AppColors.successSoftDark : AppColors.successSoft)
        : (isDark ? AppColors.errorSoftDark : AppColors.errorSoft);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive ? Icons.arrow_upward : Icons.arrow_downward,
            size: AppConstants.iconSizeSmall - 4,
            color: color,
          ),
          SizedBox(width: AppSpacing.xs),
          Text(
            '${percentage.abs().toStringAsFixed(1)}%',
            style: AppTextStyles.b12(isDark: isDark).copyWith(
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
