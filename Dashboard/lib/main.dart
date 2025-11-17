// import 'package:flutte_design_application/pages/dashboard_hub.dart';
import 'package:flutte_design_application/pages/new-dashboards/vendor_dashboard.dart';
import 'package:flutte_design_application/pages/new-dashboards/catalogue_dashboard_new.dart';
import 'package:flutte_design_application/pages/new-dashboards/smc_dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();

  // Static method to access theme notifier from anywhere
  static MyAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<MyAppState>();
  }
}

enum DashboardType { catalogue, smc, vendor }

class MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  DashboardType _currentDashboard = DashboardType.vendor;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : _themeMode == ThemeMode.dark
          ? ThemeMode.system
          : ThemeMode.light;
    });
  }

  void setThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  void switchDashboard(DashboardType dashboard) {
    setState(() {
      _currentDashboard = dashboard;
    });
  }

  Widget _getCurrentDashboard() {
    switch (_currentDashboard) {
      case DashboardType.catalogue:
        return const CatalogueDashboard();
      case DashboardType.smc:
        return const SMCDashboard();
      case DashboardType.vendor:
        return const VendorDashboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _themeMode,
      home: DashboardSelector(
        currentDashboard: _currentDashboard,
        onDashboardChanged: switchDashboard,
        child: _getCurrentDashboard(),
      ),
    );
  }
}

class DashboardSelector extends StatelessWidget {
  final DashboardType currentDashboard;
  final Function(DashboardType) onDashboardChanged;
  final Widget child;

  const DashboardSelector({
    super.key,
    required this.currentDashboard,
    required this.onDashboardChanged,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getDashboardTitle(currentDashboard)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          PopupMenuButton<DashboardType>(
            onSelected: onDashboardChanged,
            icon: const Icon(Icons.dashboard),
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<DashboardType>>[
                  const PopupMenuItem<DashboardType>(
                    value: DashboardType.catalogue,
                    child: Text('Catalogue Dashboard'),
                  ),
                  const PopupMenuItem<DashboardType>(
                    value: DashboardType.smc,
                    child: Text('SMC Dashboard'),
                  ),
                  const PopupMenuItem<DashboardType>(
                    value: DashboardType.vendor,
                    child: Text('Vendor Dashboard'),
                  ),
                ],
          ),
          IconButton(
            onPressed: () => MyApp.of(context)?.toggleTheme(),
            icon: Icon(
              Theme.of(context).brightness == Brightness.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          ),
        ],
      ),
      body: child,
    );
  }

  String _getDashboardTitle(DashboardType dashboard) {
    switch (dashboard) {
      case DashboardType.catalogue:
        return 'Catalogue Dashboard';
      case DashboardType.smc:
        return 'SMC Dashboard';
      case DashboardType.vendor:
        return 'Vendor Dashboard';
    }
  }
}
