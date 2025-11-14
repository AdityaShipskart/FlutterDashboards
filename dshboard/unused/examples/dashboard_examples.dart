import 'package:flutter/material.dart';
import 'package:flutte_design_application/pages/vendor_dashboard_v2.dart';

/// Example app demonstrating how to use the centralized dashboard system
///
/// This shows how to create multiple dashboard configurations
/// by simply passing different JSON configuration files
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      home: const DashboardsHomePage(),
    );
  }
}

class DashboardsHomePage extends StatelessWidget {
  const DashboardsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Selector'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Choose a Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Each dashboard loads data from a different JSON file and shows only the widgets that have data.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),

            // Full Vendor Dashboard
            _buildDashboardCard(
              context,
              title: 'Full Vendor Dashboard',
              description:
                  'Complete dashboard with all widgets: cards, charts, tables, and more.',
              icon: Icons.dashboard,
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VendorDashboardV2(
                      dashboardConfigPath:
                          'assets/data/vendor_dashboard_config.json',
                      title: 'Full Vendor Dashboard',
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Simple Dashboard
            _buildDashboardCard(
              context,
              title: 'Simple Dashboard',
              description:
                  'Minimal dashboard with only cards, line chart, and table.',
              icon: Icons.analytics_outlined,
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VendorDashboardV2(
                      dashboardConfigPath:
                          'assets/data/simple_dashboard_config.json',
                      title: 'Simple Dashboard',
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Custom Dashboard Example
            _buildDashboardCard(
              context,
              title: 'Create Your Own',
              description:
                  'Create a new JSON config file and it will automatically render!',
              icon: Icons.add_circle_outline,
              color: Colors.orange,
              onTap: () {
                _showCustomDashboardDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }

  void _showCustomDashboardDialog(BuildContext context) {
    final pathController = TextEditingController(
      text: 'assets/data/custom_dashboard.json',
    );
    final titleController = TextEditingController(text: 'Custom Dashboard');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Load Custom Dashboard'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Dashboard Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: pathController,
              decoration: const InputDecoration(
                labelText: 'JSON Config Path',
                border: OutlineInputBorder(),
                helperText: 'Path to your JSON configuration file',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Make sure the JSON file exists in your assets folder!',
              style: TextStyle(
                fontSize: 12,
                color: Colors.orange,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VendorDashboardV2(
                    dashboardConfigPath: pathController.text,
                    title: titleController.text,
                  ),
                ),
              );
            },
            child: const Text('Load'),
          ),
        ],
      ),
    );
  }
}

// Example: How to create different dashboard configs

/// Sales Dashboard - Focus on revenue and sales metrics
/// JSON Config: assets/data/sales_dashboard.json
/// {
///   "cards": [...sales metrics...],
///   "lineChart": {...revenue trend...},
///   "barChart": {...monthly sales...},
///   "table": {...top products...}
/// }

/// Analytics Dashboard - Focus on analytics and insights
/// JSON Config: assets/data/analytics_dashboard.json
/// {
///   "cards": [...user metrics...],
///   "pieChart": {...user distribution...},
///   "comparison": {...metric comparisons...}
/// }

/// Port Management Dashboard - Focus on port operations
/// JSON Config: assets/data/port_dashboard.json
/// {
///   "cards": [...port stats...],
///   "leadingPorts": [{...port 1...}, {...port 2...}]
/// }

/// Minimal Dashboard - Just the essentials
/// JSON Config: assets/data/minimal_dashboard.json
/// {
///   "cards": [...basic stats...],
///   "lineChart": {...main trend...}
/// }
