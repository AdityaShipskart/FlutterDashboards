import 'package:flutter/material.dart';

class DashboardContentSection extends StatelessWidget {
  final Map<String, dynamic>? content;

  const DashboardContentSection({super.key, this.content});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          content?["greeting"] ?? 'Hello, User',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: isDark ? const Color(0xFFF9FAFB) : const Color(0xFF111827),
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 8),
        Text(
          content?["subtitle"] ?? ' Welcome back to your dashboard',
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
