import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'common/percentage_chip.dart';

class DashboardCard extends StatelessWidget {
  final String iconPath;
  final String value;
  final String label;
  final String? growth;
  final Color color;
  final Color iconBgColor;

  const DashboardCard({
    super.key,
    required this.iconPath,
    required this.value,
    required this.label,
    this.growth,
    required this.color,
    required this.iconBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 120, maxHeight: 150),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
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

          // Growth Chip
          if (growth != null) ...[
            Positioned(
              top: 0,
              right: 0,
              child: PercentageChip(
                percentage:
                    double.tryParse(
                      growth!.replaceAll('%', '').replaceAll('+', ''),
                    ) ??
                    0.0,
                isDark: false,
                horizontalPadding: 6,
                verticalPadding: 3,
                fontSize: 12,
                fontWeight: FontWeight.w600,
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
                  child: Center(child: _buildIcon(iconPath, color)),
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
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111827),
                              height: 1.0,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      ),

                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
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

  Widget _buildIcon(String iconPath, Color color) {
    // Map icon paths to Material Icons as fallbacks
    IconData getIconData(String path) {
      switch (path) {
        case "award":
          return Icons.emoji_events;
        case "setting":
          return Icons.settings;
        case "information":
          return Icons.info;
        case "ghost":
          return Icons.warning;
        default:
          return Icons.circle;
      }
    }

    return SvgPicture.asset(
      iconPath,
      width: 60,
      height: 60,
      // Apply color to SVG - easy to change by modifying the color parameter
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      placeholderBuilder: (context) =>
          Icon(getIconData(iconPath), size: 24, color: color),
    );
  }
}
