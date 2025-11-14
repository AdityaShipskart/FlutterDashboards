import 'package:flutter/material.dart';

class DashboardContentSection extends StatelessWidget {
  final Map<String, dynamic>? content;

  const DashboardContentSection({super.key, this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          content?["greeting"] ?? '',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827),
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 8),
        Text(
          content?["subtitle"] ?? '',
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
