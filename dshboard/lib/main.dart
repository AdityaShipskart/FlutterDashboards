import 'package:flutte_design_application/pages/vendor_dashboard.dart';
import 'package:flutte_design_application/pages/smc_dashboard.dart';
import 'package:flutte_design_application/pages/catalogue_dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const DashboardWrapper(),
    );
  }
}

enum DashboardType { smc, vendor, catalogue }

class DashboardWrapper extends StatefulWidget {
  const DashboardWrapper({super.key});

  @override
  State<DashboardWrapper> createState() => _DashboardWrapperState();
}

class _DashboardWrapperState extends State<DashboardWrapper> {
  DashboardType _currentDashboard = DashboardType.vendor;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        title: Text(
          _getDashboardTitle(),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                  width: 1,
                ),
              ),
              child: DropdownButton<DashboardType>(
                value: _currentDashboard,
                underline: const SizedBox(),
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                onChanged: (DashboardType? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _currentDashboard = newValue;
                    });
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: DashboardType.smc,
                    child: Text('SMC Dashboard'),
                  ),
                  DropdownMenuItem(
                    value: DashboardType.vendor,
                    child: Text('Vendor Dashboard'),
                  ),
                  DropdownMenuItem(
                    value: DashboardType.catalogue,
                    child: Text('Catalogue Dashboard'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: _buildCurrentDashboard(),
    );
  }

  String _getDashboardTitle() {
    switch (_currentDashboard) {
      case DashboardType.smc:
        return 'SMC Dashboard';
      case DashboardType.vendor:
        return 'Vendor Dashboard';
      case DashboardType.catalogue:
        return 'Catalogue Dashboard';
    }
  }

  Widget _buildCurrentDashboard() {
    switch (_currentDashboard) {
      case DashboardType.smc:
        return const SmcDashboard();
      case DashboardType.vendor:
        return const VendorDashboard();
      case DashboardType.catalogue:
        return const CatalogueDashboard();
    }
  }
}
