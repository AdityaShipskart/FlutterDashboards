import 'package:flutter/material.dart';
import '../const/constant.dart';
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
          style: AppTextStyles.h30(isDark: isDark).copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.9,
            color: isDark ? AppColors.grey200Light : AppColors.grey200Dark,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: AppSpacing.sm),
        Text(
          effectiveContent["subtitle"] ?? 'Welcome back to your dashboard',
          style: AppTextStyles.b14(isDark: isDark).copyWith(
            color: isDark ? AppColors.grey200Light : AppColors.grey200Dark,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.99,
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
