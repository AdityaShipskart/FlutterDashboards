import 'package:flutter/material.dart';
import 'package:flutte_design_application/pages/vendor_dashboard_v2.dart';

/// Quick integration example - Add this to your main.dart or routing
///
/// This shows different ways to use the new dashboard system

// Example 1: Direct usage in a route
class VendorDashboardRoute extends StatelessWidget {
  const VendorDashboardRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const VendorDashboardV2(
      dashboardConfigPath: 'assets/data/vendor_dashboard_config.json',
      title: 'Vendor Dashboard',
    );
  }
}

// Example 2: Parameterized dashboard (different configs for different vendors)
class DynamicVendorDashboard extends StatelessWidget {
  final String vendorId;
  final String vendorName;

  const DynamicVendorDashboard({
    super.key,
    required this.vendorId,
    required this.vendorName,
  });

  @override
  Widget build(BuildContext context) {
    // In a real app, you might fetch this from an API based on vendorId
    // For now, we'll use different configs based on vendor type
    final configPath = _getConfigPathForVendor(vendorId);

    return VendorDashboardV2(
      dashboardConfigPath: configPath,
      title: '$vendorName Dashboard',
    );
  }

  String _getConfigPathForVendor(String vendorId) {
    // Example: Different vendors might have different dashboard layouts
    if (vendorId.startsWith('PORT')) {
      return 'assets/data/port_vendor_config.json';
    } else if (vendorId.startsWith('SHIP')) {
      return 'assets/data/shipping_vendor_config.json';
    } else {
      return 'assets/data/vendor_dashboard_config.json';
    }
  }
}

// Example 3: Dashboard with role-based configuration
class RoleBasedDashboard extends StatelessWidget {
  final UserRole role;

  const RoleBasedDashboard({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final (configPath, title) = _getDashboardConfig(role);

    return VendorDashboardV2(dashboardConfigPath: configPath, title: title);
  }

  (String, String) _getDashboardConfig(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return ('assets/data/admin_dashboard_config.json', 'Admin Dashboard');
      case UserRole.manager:
        return (
          'assets/data/manager_dashboard_config.json',
          'Manager Dashboard',
        );
      case UserRole.vendor:
        return ('assets/data/vendor_dashboard_config.json', 'Vendor Dashboard');
      case UserRole.analyst:
        return (
          'assets/data/analytics_dashboard_config.json',
          'Analytics Dashboard',
        );
    }
  }
}

enum UserRole { admin, manager, vendor, analyst }

// Example 4: Navigation setup with named routes
class AppRoutes {
  static const String vendorDashboard = '/vendor-dashboard';
  static const String salesDashboard = '/sales-dashboard';
  static const String analyticsDashboard = '/analytics-dashboard';
  static const String portDashboard = '/port-dashboard';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      vendorDashboard: (context) => const VendorDashboardV2(
        dashboardConfigPath: 'assets/data/vendor_dashboard_config.json',
        title: 'Vendor Dashboard',
      ),
      salesDashboard: (context) => const VendorDashboardV2(
        dashboardConfigPath: 'assets/data/sales_dashboard_config.json',
        title: 'Sales Dashboard',
      ),
      analyticsDashboard: (context) => const VendorDashboardV2(
        dashboardConfigPath: 'assets/data/analytics_dashboard_config.json',
        title: 'Analytics Dashboard',
      ),
      portDashboard: (context) => const VendorDashboardV2(
        dashboardConfigPath: 'assets/data/port_dashboard_config.json',
        title: 'Port Management',
      ),
    };
  }
}

// Example 5: Dashboard with tab navigation
class MultiDashboardView extends StatefulWidget {
  const MultiDashboardView({super.key});

  @override
  State<MultiDashboardView> createState() => _MultiDashboardViewState();
}

class _MultiDashboardViewState extends State<MultiDashboardView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<DashboardConfig> _dashboards = [
    DashboardConfig(
      title: 'Overview',
      configPath: 'assets/data/vendor_dashboard_config.json',
      icon: Icons.dashboard,
    ),
    DashboardConfig(
      title: 'Sales',
      configPath: 'assets/data/simple_dashboard_config.json',
      icon: Icons.shopping_cart,
    ),
    DashboardConfig(
      title: 'Analytics',
      configPath: 'assets/data/vendor_dashboard_config.json',
      icon: Icons.analytics,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _dashboards.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Dashboard'),
        bottom: TabBar(
          controller: _tabController,
          tabs: _dashboards
              .map((d) => Tab(icon: Icon(d.icon), text: d.title))
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _dashboards
            .map(
              (d) => VendorDashboardV2(
                dashboardConfigPath: d.configPath,
                title: d.title,
              ),
            )
            .toList(),
      ),
    );
  }
}

class DashboardConfig {
  final String title;
  final String configPath;
  final IconData icon;

  DashboardConfig({
    required this.title,
    required this.configPath,
    required this.icon,
  });
}

// Example 6: Dashboard with side drawer navigation
class DashboardWithDrawer extends StatefulWidget {
  const DashboardWithDrawer({super.key});

  @override
  State<DashboardWithDrawer> createState() => _DashboardWithDrawerState();
}

class _DashboardWithDrawerState extends State<DashboardWithDrawer> {
  String _currentDashboard = 'assets/data/vendor_dashboard_config.json';
  String _currentTitle = 'Vendor Dashboard';

  final List<DrawerItem> _drawerItems = [
    DrawerItem(
      title: 'Vendor Dashboard',
      icon: Icons.store,
      configPath: 'assets/data/vendor_dashboard_config.json',
    ),
    DrawerItem(
      title: 'Simple Dashboard',
      icon: Icons.analytics_outlined,
      configPath: 'assets/data/simple_dashboard_config.json',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.dashboard, size: 48, color: Colors.white),
                  SizedBox(height: 8),
                  Text(
                    'Dashboards',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ..._drawerItems.map(
              (item) => ListTile(
                leading: Icon(item.icon),
                title: Text(item.title),
                selected: _currentDashboard == item.configPath,
                onTap: () {
                  setState(() {
                    _currentDashboard = item.configPath;
                    _currentTitle = item.title;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
      body: VendorDashboardV2(
        key: ValueKey(_currentDashboard), // Force rebuild on change
        dashboardConfigPath: _currentDashboard,
        title: _currentTitle,
      ),
    );
  }
}

class DrawerItem {
  final String title;
  final IconData icon;
  final String configPath;

  DrawerItem({
    required this.title,
    required this.icon,
    required this.configPath,
  });
}

/*
═══════════════════════════════════════════════════════════════
INTEGRATION INTO YOUR MAIN APP
═══════════════════════════════════════════════════════════════

Option 1: Simple replacement in main.dart
────────────────────────────────────────────
import 'package:flutte_design_application/pages/vendor_dashboard_v2.dart';

void main() {
  runApp(MaterialApp(
    home: VendorDashboardV2(
      dashboardConfigPath: 'assets/data/vendor_dashboard_config.json',
    ),
  ));
}

Option 2: With named routes
────────────────────────────────────────────
import 'integration_examples.dart';

void main() {
  runApp(MaterialApp(
    routes: AppRoutes.getRoutes(),
    initialRoute: AppRoutes.vendorDashboard,
  ));
}

Option 3: With navigation
────────────────────────────────────────────
Navigator.pushNamed(context, AppRoutes.vendorDashboard);

// Or with direct widget
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const VendorDashboardV2(
      dashboardConfigPath: 'assets/data/vendor_dashboard_config.json',
    ),
  ),
);

Option 4: As a tab in existing app
────────────────────────────────────────────
BottomNavigationBar(
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
  ],
)

// When dashboard tab selected:
body: VendorDashboardV2(
  dashboardConfigPath: 'assets/data/vendor_dashboard_config.json',
)

═══════════════════════════════════════════════════════════════
CREATING DASHBOARD CONFIGS FOR YOUR USE CASE
═══════════════════════════════════════════════════════════════

1. Create JSON files in assets/data/:
   - vendor_dashboard_config.json (main vendor view)
   - admin_dashboard_config.json (admin view)
   - sales_dashboard_config.json (sales team view)
   - analytics_dashboard_config.json (analysts view)

2. Each file contains only the widgets needed for that role/view

3. Use VendorDashboardV2 with different configPath for each view

4. Widgets automatically hide if data is missing

5. Layout automatically adjusts to fill available space

═══════════════════════════════════════════════════════════════
*/
