import 'package:flutter/material.dart';
import '../main.dart';
import 'catalogue_dashboard.dart';
import 'smc_dashboard.dart';
import 'vendor_dashboard.dart';

/// Minimal top navigation to showcase different dashboard configurations
class DashboardHub extends StatefulWidget {
  const DashboardHub({super.key});

  @override
  State<DashboardHub> createState() => _DashboardHubState();
}

class _DashboardHubState extends State<DashboardHub> {
  int _selectedIndex = 0;

  final List<DashboardConfig> _dashboards = [
    DashboardConfig(
      title: 'Vendor Dashboard',
      icon: Icons.store,
      builder: () => VendorDashboard(),
    ),
    DashboardConfig(
      title: 'Ship Management',
      icon: Icons.directions_boat,
      builder: () => SMCDashboard(),
    ),
    DashboardConfig(
      title: 'Catalogue',
      icon: Icons.category,
      builder: () => CatalogueDashboard(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.light;
    final selectedDashboard = _dashboards[_selectedIndex];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        title: Row(
          children: [
            Icon(
              selectedDashboard.icon,
              color: Theme.of(context).primaryColor,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              selectedDashboard.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
        actions: [
          // Theme Toggle Button
          PopupMenuButton<ThemeMode>(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
            tooltip: 'Change Theme',
            onSelected: (ThemeMode mode) {
              // Access the MyApp state to change theme
              MyApp.of(context)?.setThemeMode(mode);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<ThemeMode>>[
              const PopupMenuItem<ThemeMode>(
                value: ThemeMode.light,
                child: Row(
                  children: [
                    Icon(Icons.light_mode),
                    SizedBox(width: 8),
                    Text('Light'),
                  ],
                ),
              ),
              const PopupMenuItem<ThemeMode>(
                value: ThemeMode.dark,
                child: Row(
                  children: [
                    Icon(Icons.dark_mode),
                    SizedBox(width: 8),
                    Text('Dark'),
                  ],
                ),
              ),
              const PopupMenuItem<ThemeMode>(
                value: ThemeMode.system,
                child: Row(
                  children: [
                    Icon(Icons.settings_suggest),
                    SizedBox(width: 8),
                    Text('System'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          // Dashboard Selector
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: _dashboards.asMap().entries.map((entry) {
                final index = entry.key;
                final dashboard = entry.value;
                final isSelected = _selectedIndex == index;

                return _buildNavButton(
                  context,
                  dashboard: dashboard,
                  isSelected: isSelected,
                  onTap: () => setState(() => _selectedIndex = index),
                  isDarkMode: isDarkMode,
                );
              }).toList(),
            ),
          ),
        ],
      ),
      body: KeyedSubtree(
        key: ValueKey(selectedDashboard.title),
        child: selectedDashboard.builder(),
      ),
    );
  }

  Widget _buildNavButton(
    BuildContext context, {
    required DashboardConfig dashboard,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              dashboard.icon,
              size: 18,
              color: isSelected
                  ? Colors.white
                  : (isDarkMode ? Colors.grey[400] : Colors.grey[700]),
            ),
            const SizedBox(width: 8),
            Text(
              dashboard.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected
                    ? Colors.white
                    : (isDarkMode ? Colors.grey[400] : Colors.grey[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardConfig {
  final String title;
  final IconData icon;
  final Widget Function() builder;

  DashboardConfig({
    required this.title,
    required this.icon,
    required this.builder,
  });
}
