import 'package:flutter/material.dart';
import '../const/constant.dart';
import 'dashboard_card.dart';
import 'dashboard_content_section.dart';

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

  @override
  Widget build(BuildContext context) {
    return _buildDashboardContent(widget.cards);
  }

  Widget _buildDashboardContent(List<Map<String, dynamic>> cards) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 1000,
      height: 500,
      decoration: BoxDecoration(
        color: isDark ? AppColors.grey100Dark : AppColors.grey25Light,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
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
                  : 'Hello Child',
            ),
          ),

          // Divider
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(vertical: 14),
            color: AppColors.getBorder(isDark),
          ),

          // Cards Section (responsive widths)
          Expanded(
            flex: 7,
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Number of vertical columns (each column has up to 2 cards stacked)
                int columns = (cards.length + 1) ~/ 2;
                if (columns == 0) columns = 1;

                // spacing between columns
                const double columnGap = 16.0;

                // compute card width to evenly divide available space across columns
                final double totalGap = (columns - 1) * columnGap;
                final double available = constraints.maxWidth - totalGap;
                final double cardWidth = (available / columns).clamp(
                  120.0,
                  constraints.maxWidth,
                );

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Arrange cards into 2 rows stacked vertically across multiple columns
                    for (int col = 0; col < columns; col++) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int row = 0; row < 2; row++) ...[
                            if (col * 2 + row < cards.length)
                              SizedBox(
                                width: cardWidth,
                                child: DashboardCard(
                                  iconPath: cards[col * 2 + row]['iconPath'],
                                  value: cards[col * 2 + row]['value'],
                                  label: cards[col * 2 + row]['label'],
                                  growth: cards[col * 2 + row]['growth'],
                                  color: cards[col * 2 + row]['color'],
                                  iconBgColor:
                                      cards[col * 2 + row]['iconBgColor'],
                                ),
                              ),
                            if (row == 0) const SizedBox(height: 16),
                          ],
                        ],
                      ),
                      if (col < columns - 1) const SizedBox(width: columnGap),
                    ],
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
