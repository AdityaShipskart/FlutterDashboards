import 'package:flutter/material.dart';
import '../widgets/dashboard_horizontal_bar_chart.dart';
import '../const/constant.dart';

class SaleFunnelExample extends StatelessWidget {
  const SaleFunnelExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardHorizontalBarChart(
      title: 'Sale Funnel',
      subtitle: 'Amount of revenue in one month',
      data: [
        BarData(
          label: 'Awareness',
          percentage: 100,
          color: const Color(0xFFB3D4FF), // Light blue
        ),
        BarData(
          label: 'Research',
          percentage: 80,
          color: const Color(0xFF80B3FF), // Medium-light blue
        ),
        BarData(
          label: 'Intent',
          percentage: 65,
          color: const Color(0xFF4D94FF), // Medium blue
        ),
        BarData(
          label: 'Evaluation',
          percentage: 48,
          color: const Color(0xFF3380FF), // Blue
        ),
        BarData(
          label: 'Negotiation',
          percentage: 37,
          color: const Color(0xFF1A6BFF), // Darker blue
        ),
        BarData(
          label: 'Acquisition',
          percentage: 30,
          color: AppColors.success, // Green
        ),
      ],
      tableData: [
        TableRowData(
          stage: 'Awareness',
          lostLead: '32.2%',
          thisMonth: '6.01%',
          color: const Color(0xFFB3D4FF),
          changeColor: AppColors.success,
        ),
        TableRowData(
          stage: 'Research',
          lostLead: '30.1%',
          thisMonth: '4.12%',
          color: const Color(0xFF80B3FF),
          changeColor: AppColors.success,
        ),
        TableRowData(
          stage: 'Intent',
          lostLead: '22.1%',
          thisMonth: '3.91%',
          color: const Color(0xFF4D94FF),
          changeColor: AppColors.error,
        ),
        TableRowData(
          stage: 'Evaluation',
          lostLead: '15.6%',
          thisMonth: '0.01%',
          color: const Color(0xFF3380FF),
          changeColor: AppColors.warning,
        ),
      ],
    );
  }
}
