import 'package:flutte_design_application/widgets/dashboard_bar_chart.dart';
import 'package:flutte_design_application/widgets/dashboard_combobar_chart.dart';
import 'package:flutte_design_application/widgets/dashboard_comparison.dart';
import 'package:flutte_design_application/widgets/dashboard_financial_card.dart';
import 'package:flutte_design_application/widgets/dashboard_leading_port.dart';
import 'package:flutte_design_application/widgets/dashboard_line_chart.dart';
import 'package:flutte_design_application/widgets/dashboard_pie_chart.dart';
import 'package:flutte_design_application/widgets/dashboard_recent_data.dart';
import 'package:flutte_design_application/widgets/dashboard_table.dart';
import 'package:flutter/material.dart';
import 'package:flutte_design_application/widgets/dashboard_card_container.dart';
import 'package:flutte_design_application/services/dashboard_data_service.dart';

/// New Vendor Dashboard with centralized data loading
///
/// Features:
/// - Loads all dashboard data from a single JSON file once
/// - Conditionally renders widgets based on data availability
/// - Widgets that don't have data are hidden, and remaining widgets take full space
/// - Easily reusable for multiple dashboard types
class VendorDashboardV2 extends StatefulWidget {
  /// Path to the dashboard configuration JSON file
  final String dashboardConfigPath;

  /// Optional dashboard title
  final String? title;

  const VendorDashboardV2({
    super.key,
    this.dashboardConfigPath = 'assets/data/vendor_dashboard_config.json',
    this.title,
  });

  @override
  State<VendorDashboardV2> createState() => _VendorDashboardV2State();
}

class _VendorDashboardV2State extends State<VendorDashboardV2> {
  DashboardData? _dashboardData;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  /// Load dashboard data once from JSON file
  Future<void> _loadDashboardData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final data = await DashboardDataService.loadDashboardData(
        widget.dashboardConfigPath,
      );

      if (mounted) {
        setState(() {
          _dashboardData = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to load dashboard: $e';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        title: Text(
          widget.title ?? 'Vendor Dashboard',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        centerTitle: false,
      ),
      body: _isLoading
          ? _buildLoadingState(context)
          : _errorMessage != null
          ? _buildErrorState(context)
          : _buildDashboardContent(context),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading dashboard data...',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
          const SizedBox(height: 16),
          Text(
            _errorMessage!,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadDashboardData,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardContent(BuildContext context) {
    if (_dashboardData == null) {
      return const SizedBox.shrink();
    }

    return RefreshIndicator(
      onRefresh: _loadDashboardData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Cards and Recent Activity
              if (_dashboardData!.hasData('cards') ||
                  _dashboardData!.hasData('recentActivity'))
                _buildSection1(),

              // Section 2: Line Chart, Pie Chart, Financial Card Row
              if (_dashboardData!.hasData('lineChart') ||
                  _dashboardData!.hasData('pieChart') ||
                  _dashboardData!.hasData('financialCard'))
                _buildSection2(),

              // Section 3: Combo Bar Chart and Comparison
              if (_dashboardData!.hasData('comboBarChart') ||
                  _dashboardData!.hasData('comparison'))
                _buildSection3(),

              // Section 4: Bar Chart (full width if exists)
              if (_dashboardData!.hasData('barChart')) _buildSection4(),

              // Section 5: Table
              // if (_dashboardData!.hasData('table')) _buildSection5(),

              // Section 6: Leading Ports (Multiple Tables)
              if (_dashboardData!.hasData('leadingPorts')) _buildSection6(),
            ],
          ),
        ),
      ),
    );
  }

  /// Section 1: Dashboard Cards and Recent Activity
  Widget _buildSection1() {
    final hasCards = _dashboardData!.hasData('cards');
    final hasRecent = _dashboardData!.hasData('recentActivity');

    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;

          if (isMobile) {
            return Column(
              children: [
                if (hasCards) _buildCardsWidget(),
                if (hasCards && hasRecent) const SizedBox(height: 16),
                if (hasRecent) _buildRecentActivityWidget(),
              ],
            );
          }

          // Desktop layout
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasCards)
                Expanded(flex: hasRecent ? 7 : 10, child: _buildCardsWidget()),
              if (hasCards && hasRecent) const SizedBox(width: 16),
              if (hasRecent)
                Expanded(
                  flex: hasCards ? 3 : 10,
                  child: _buildRecentActivityWidget(),
                ),
            ],
          );
        },
      ),
    );
  }

  /// Section 2: Line Chart, Pie Chart, Financial Card
  Widget _buildSection2() {
    final hasLine = _dashboardData!.hasData('lineChart');
    final hasPie = _dashboardData!.hasData('pieChart');
    final hasFinancial = _dashboardData!.hasData('financialCard');

    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;

          if (isMobile) {
            return Column(
              children: [
                if (hasLine) _buildLineChartWidget(),
                if (hasLine && (hasPie || hasFinancial))
                  const SizedBox(height: 20),
                if (hasPie) _buildPieChartWidget(),
                if (hasPie && hasFinancial) const SizedBox(height: 20),
                if (hasFinancial) _buildFinancialCardWidget(),
              ],
            );
          }

          // Desktop layout - calculate flex based on available widgets
          final activeWidgets = [
            hasLine,
            hasPie,
            hasFinancial,
          ].where((has) => has).length;

          if (activeWidgets == 0) return const SizedBox.shrink();

          final widgets = <Widget>[];

          if (hasLine) {
            widgets.add(
              Expanded(
                flex: activeWidgets == 1 ? 10 : 35,
                child: _buildLineChartWidget(),
              ),
            );
          }

          if (hasPie) {
            if (widgets.isNotEmpty) widgets.add(const SizedBox(width: 20));
            widgets.add(
              Expanded(
                flex: activeWidgets == 1 ? 10 : 25,
                child: _buildPieChartWidget(),
              ),
            );
          }

          if (hasFinancial) {
            if (widgets.isNotEmpty) widgets.add(const SizedBox(width: 20));
            widgets.add(
              Expanded(
                flex: activeWidgets == 1 ? 10 : 25,
                child: _buildFinancialCardWidget(),
              ),
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets,
          );
        },
      ),
    );
  }

  /// Section 3: Combo Bar Chart and Comparison
  Widget _buildSection3() {
    final hasCombo = _dashboardData!.hasData('comboBarChart');
    final hasComparison = _dashboardData!.hasData('comparison');

    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;

          if (isMobile) {
            return Column(
              children: [
                if (hasCombo) _buildComboBarChartWidget(),
                if (hasCombo && hasComparison) const SizedBox(height: 20),
                if (hasComparison) _buildComparisonWidget(),
              ],
            );
          }

          // Desktop layout
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasCombo)
                Expanded(
                  flex: hasComparison ? 50 : 10,
                  child: _buildComboBarChartWidget(),
                ),
              if (hasCombo && hasComparison) const SizedBox(width: 20),
              if (hasComparison)
                Expanded(
                  flex: hasCombo ? 50 : 10,
                  child: _buildComparisonWidget(),
                ),
            ],
          );
        },
      ),
    );
  }

  /// Section 4: Bar Chart (Full Width)
  Widget _buildSection4() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: _buildBarChartWidget(),
    );
  }

  /// Section 5: Table
  Widget _buildSection5() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: _buildTableWidget(),
    );
  }

  /// Section 6: Leading Ports
  Widget _buildSection6() {
    final leadingPorts = _dashboardData!.leadingPorts!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const double gap = 16;
          final double availableWidth =
              constraints.hasBoundedWidth && constraints.maxWidth.isFinite
              ? constraints.maxWidth
              : MediaQuery.of(context).size.width;

          // Responsive column count
          final int columns = availableWidth < 768
              ? 1
              : availableWidth < 1200
              ? 2
              : leadingPorts.length;

          final double totalGap = columns > 1 ? gap * (columns - 1) : 0;
          final double itemWidth = (availableWidth - totalGap) / columns;

          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: leadingPorts.map((portData) {
              return SizedBox(
                width: itemWidth,
                child: DashboardLeadingPort(
                  data: portData,
                  minWidth: itemWidth,
                  expandToAvailableWidth: false,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  // ============ Widget Builders ============

  Widget _buildCardsWidget() {
    return DashboardCardContainer(
      cards: _dashboardData!.cards!,
      contentData: _dashboardData!.contentData,
      contentKey: "child_dashboard",
    );
  }

  Widget _buildRecentActivityWidget() {
    return DashboardRecentData(data: _dashboardData!.recentActivity);
  }

  Widget _buildLineChartWidget() {
    return RevenueGeneratedCard(chartData: _dashboardData!.lineChart!);
  }

  Widget _buildPieChartWidget() {
    return DashboardPieChart(data: _dashboardData!.pieChart);
  }

  Widget _buildFinancialCardWidget() {
    return DashboardFinancialCard(data: _dashboardData!.financialCard);
  }

  Widget _buildBarChartWidget() {
    return DashboardBarChart(data: _dashboardData!.barChart);
  }

  Widget _buildComboBarChartWidget() {
    return DashboardcombobarChart(data: _dashboardData!.comboBarChart);
  }

  Widget _buildComparisonWidget() {
    return MultiAnalyticsOveriview(data: _dashboardData!.comparison);
  }

  Widget _buildTableWidget() {
    return DashboardTable(data: _dashboardData!.table);
  }
}
