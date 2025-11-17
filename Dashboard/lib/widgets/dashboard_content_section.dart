import 'package:flutter/material.dart';
// import 'package:get/get_utils/src/extensions/export.dart';

class DashboardContentSection extends StatelessWidget {
  final Map<String, dynamic>? content;

  const DashboardContentSection({super.key, this.content});

  // Example data for when no content is provided
  static const Map<String, dynamic> _exampleContent = {
    'greeting': 'Hello, User',
    'subtitle': 'Welcome back to your dashboard',
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveContent = content ?? _exampleContent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          effectiveContent["greeting"] ?? 'Hello, User',
          // style: context.textTheme.titleMedium?.copyWith(
          //   fontWeight: FontWeight.bold,
          //   color: isDark ? Colors.white : Colors.black,
          // ),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 8),
        Text(
          effectiveContent["subtitle"] ?? 'Welcome back to your dashboard',
          style: TextStyle(
            fontSize: 14,
            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
