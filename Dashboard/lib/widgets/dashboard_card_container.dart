import 'package:flutter/material.dart';
import 'dashboard_card.dart';
import 'dashboard_content_section.dart';

class DashboardCardContainer extends StatefulWidget {
  final List<Map<String, dynamic>> cards;
  final Map<String, dynamic>? contentData;
  final String? contentKey;

  const DashboardCardContainer({
    super.key,
    this.cards = const [], // Will use example data if empty
    this.contentData,
    this.contentKey,
  });

  // Example data for when no cards are provided
  static final List<Map<String, dynamic>> _exampleCards = [
    {
      'iconKey': 'revenue',
      'value': '\$45,231',
      'label': 'Total Revenue',
      'growth': '+12.5%',
      'color': const Color(0xFF3B82F6),
      'iconBgColor': const Color(0xFFEBF5FF),
    },
    {
      'iconKey': 'users',
      'value': '1,234',
      'label': 'Active Users',
      'growth': '+5.3%',
      'color': const Color(0xFF10B981),
      'iconBgColor': const Color(0xFFD1FAE5),
    },
    {
      'iconKey': 'orders',
      'value': '567',
      'label': 'Total Orders',
      'growth': '-2.1%',
      'color': const Color(0xFFF59E0B),
      'iconBgColor': const Color(0xFFFEF3C7),
    },
    {
      'iconKey': 'profit',
      'value': '\$12,345',
      'label': 'Net Profit',
      'growth': '+8.7%',
      'color': const Color(0xFF8B5CF6),
      'iconBgColor': const Color(0xFFEDE9FE),
    },
  ];

  // Inline color getter - no external dependencies
  static Color _getBackgroundColor(bool isDark) {
    return isDark ? const Color(0xFF374151) : const Color(0xFFFCFCFD);
  }

  static Color _getBorderColor(bool isDark) {
    return isDark ? const Color(0xFF4B5563) : const Color(0xFFE5E7EB);
  }

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
    // Use example data if none provided
    final effectiveCards = widget.cards.isEmpty
        ? DashboardCardContainer._exampleCards
        : widget.cards;
    return _buildDashboardContent(effectiveCards);
  }

  Widget _buildDashboardContent(List<Map<String, dynamic>> cards) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.all(10),
      width: 1000,
      height: 500,
      decoration: BoxDecoration(
        // color: DashboardCardContainer._getBackgroundColor(isDark),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
   
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Content Section
          Expanded(
            flex: 2,
            child: DashboardContentSection(
              content: widget.contentKey != null && widget.contentData != null
                  ? widget.contentData![widget.contentKey!]
                  : null, // Will use default example data in DashboardContentSection
            ),
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
                                  iconKey:
                                      cards[col * 2 + row]['iconKey'] ??
                                      'revenue',
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
