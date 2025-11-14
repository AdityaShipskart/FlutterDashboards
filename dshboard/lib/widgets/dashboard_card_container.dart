import 'package:flutter/material.dart';
import '../const/constant.dart' show AppColors;
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
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        color: AppColors.grey100Light,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Content Section
          Expanded(
            flex: 1,
            child: DashboardContentSection(
              content: widget.contentKey != null && widget.contentData != null
                  ? widget.contentData![widget.contentKey!]
                  : null,
            ),
          ),
          SizedBox(height: 14),
          Container(
            height: 1,
            color: const Color(0xFFE5E7EB),
            // margin: const EdgeInsets.symmetric(vertical: 14),
          ),
          // Cards Section
          Expanded(
            flex: 1,
            child: Scrollbar(
              controller: _scrollController, // Added controller here
              thickness: 0,
              radius: const Radius.circular(2),
              thumbVisibility: false,
              trackVisibility: false,
              child: SingleChildScrollView(
                controller: _scrollController, // Added controller here
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < cards.length; i++) ...[
                      SizedBox(
                        width: 180,
                        child: DashboardCard(
                          iconPath: cards[i]['iconPath'],
                          value: cards[i]['value'],
                          label: cards[i]['label'],
                          growth: cards[i]['growth'],
                          color: cards[i]['color'],
                          iconBgColor: cards[i]['iconBgColor'],
                        ),
                      ),
                      if (i < cards.length - 1) const SizedBox(width: 16),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
