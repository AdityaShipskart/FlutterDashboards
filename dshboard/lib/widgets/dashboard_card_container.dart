import 'package:flutter/material.dart';
import '../const/constant.dart';
import 'dashboard_card.dart';
import 'dashboard_content_section.dart';
import 'package:responsive_grid/responsive_grid.dart';

class DashboardCardContainer extends StatefulWidget {
  final List<Map<String, dynamic>> cards;
  final Map<String, dynamic>? contentData;
  final String? contentKey;

  const DashboardCardContainer({
    super.key,
    required this.cards,
    this.contentData,
    this.contentKey,
  });

  @override
  State<DashboardCardContainer> createState() => _DashboardCardContainerState();
}

class _DashboardCardContainerState extends State<DashboardCardContainer> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Helper function to convert color string to Color object
  Color _getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'freeicon':
        return DashboardColors.freeIcon;
      case 'goldicon':
        return DashboardColors.goldIcon;
      case 'platinumicon':
        return DashboardColors.platinumIcon;
      case 'expiringicon':
        return DashboardColors.expiringIcon;
      case 'transparent':
        return Colors.transparent;
      default:
        return DashboardColors.freeIcon; // Default fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildDashboardContent(widget.cards);
  }

  Widget _buildDashboardContent(List<Map<String, dynamic>> cards) {
    return Container(
      width: 1000,
      height: 500,
      decoration: const BoxDecoration(
        color: AppColors.grey25Light,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Content Section
          Expanded(
            flex: 2,
            child: DashboardContentSection(
              content: widget.contentKey != null && widget.contentData != null
                  ? widget.contentData![widget.contentKey!]
                  : null,
            ),
          ),

          // Divider
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(vertical: 14),
            color: const Color(0xFFE5E7EB),
            // margin: const EdgeInsets.symmetric(vertical: 14),
          ),

          // Cards Section (responsive widths using ResponsiveGrid)
          Expanded(
            flex: 7,
            child: SingleChildScrollView(
              child: ResponsiveGridRow(
                rowSegments: 12,
                children: [
                  for (var i = 0; i < cards.length; i++)
                    ResponsiveGridCol(
                      xs: 12, // Full width on extra small screens
                      sm: 6, // Half width on small screens
                      md: 6, // Half width on medium screens
                      lg: 3, // Quarter width on large screens
                      xl: 3, // Quarter width on extra large screens
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 16.0,
                          right: 8.0,
                        ),
                        child: DashboardCard(
                          iconPath: cards[i]['iconPath'],
                          value: cards[i]['value'],
                          label: cards[i]['label'],
                          growth: cards[i]['growth'],
                          color: _getColorFromString(cards[i]['color']),
                          iconBgColor: _getColorFromString(
                            cards[i]['iconBgColor'],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
