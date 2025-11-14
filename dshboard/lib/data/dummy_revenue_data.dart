/// ============================================
/// DUMMY DATA FOR REVENUE GENERATED CARD
/// ============================================
///
/// CURRENT STATUS: Using local dummy data
///
/// FUTURE: Replace with .NET Backend API
///
/// ============================================
/// .NET API INTEGRATION GUIDE
/// ============================================
///
/// 1. CREATE API ENDPOINT IN YOUR .NET BACKEND:
///    - GET /api/revenue/dashboard
///    - Query Parameters:
///      * period: string (e.g., "Full Year", "Jan-Jun", "Jul-Dec")
///      * year: int (e.g., 2024, 2025)
///
/// 2. API RESPONSE FORMAT (JSON):
/// {
///   "cardTitle": "Revenue Generated",
///   "cardSubtitle": "Comparison with Last Year",
///   "thisYearLabel": "This year",
///   "lastYearLabel": "Last year",
///   "percentageChange": "+6.19%",
///   "isPositiveChange": true,
///   "availablePeriods": ["Jan-Jun", "Jul-Dec", "Full Year"],
///   "selectedPeriod": "Full Year",
///   "chartConfig": {
///     "minX": 0,
///     "maxX": 11,
///     "minY": 2,
///     "maxY": 7
///   },
///   "thisYearData": [
///     {"x": 0, "y": 3.5},
///     {"x": 1, "y": 3.8},
///     ...
///   ],
///   "lastYearData": [
///     {"x": 0, "y": 3.0},
///     ...
///   ],
///   "labels": ["Jan", "Feb", "Mar", ...]
/// }
///
/// 3. AUTHENTICATION:
///    - Use Bearer token in Authorization header
///    - Example: 'Authorization': 'Bearer YOUR_JWT_TOKEN'
///
/// 4. ERROR HANDLING:
///    - 200: Success
///    - 401: Unauthorized
///    - 404: Not Found
///    - 500: Server Error
///
/// ============================================
library;

// TODO: For .NET API Integration - Uncomment these imports:
// import 'package:http/http.dart' as http;
// import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';

class DummyRevenueData {
  /// Simulates fetching revenue data from backend
  ///
  /// CURRENT: Uses dummy data
  /// FUTURE: Replace with .NET API call
  ///
  /// TODO: Replace this method with actual API call:
  /// ```dart
  /// static Future<Map<String, dynamic>> getDummyRevenueData({
  ///   String period = 'Full Year',
  ///   int? year,
  /// }) async {
  ///   final response = await http.get(
  ///     Uri.parse('https://your-api.com/api/revenue/dashboard?period=$period&year=${year ?? DateTime.now().year}'),
  ///     headers: {
  ///       'Content-Type': 'application/json',
  ///       'Authorization': 'Bearer YOUR_API_TOKEN',
  ///     },
  ///   );
  ///
  ///   if (response.statusCode == 200) {
  ///     return json.decode(response.body) as Map<String, dynamic>;
  ///   } else {
  ///     throw Exception('Failed to load revenue data: ${response.statusCode}');
  ///   }
  /// }
  /// ```
  static Future<Map<String, dynamic>> getDummyRevenueData({
    String period = 'Full Year',
    int? year,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // ============================================
    // DYNAMIC DATA BASED ON PERIOD PARAMETER
    // ============================================
    // In .NET API, this logic will be handled by the backend
    // The API will return different data based on the period query parameter

    final currentYear = year ?? DateTime.now().year;
    final lastYear = currentYear - 1;

    // Full year data (all 12 months)
    final fullThisYearData = [
      {"x": 0.0, "y": 3.5}, // Jan
      {"x": 1.0, "y": 3.8}, // Feb
      {"x": 2.0, "y": 4.2}, // Mar
      {"x": 3.0, "y": 3.9}, // Apr
      {"x": 4.0, "y": 3.8}, // May
      {"x": 5.0, "y": 4.5}, // Jun
      {"x": 6.0, "y": 5.1}, // Jul
      {"x": 7.0, "y": 4.8}, // Aug
      {"x": 8.0, "y": 4.5}, // Sep
      {"x": 9.0, "y": 5.3}, // Oct
      {"x": 10.0, "y": 5.8}, // Nov
      {"x": 11.0, "y": 6.5}, // Dec
    ];

    final fullLastYearData = [
      {"x": 0.0, "y": 3.0}, // Jan
      {"x": 1.0, "y": 3.3}, // Feb
      {"x": 2.0, "y": 3.5}, // Mar
      {"x": 3.0, "y": 3.4}, // Apr
      {"x": 4.0, "y": 3.2}, // May
      {"x": 5.0, "y": 3.9}, // Jun
      {"x": 6.0, "y": 4.5}, // Jul
      {"x": 7.0, "y": 4.2}, // Aug
      {"x": 8.0, "y": 4.0}, // Sep
      {"x": 9.0, "y": 4.7}, // Oct
      {"x": 10.0, "y": 5.0}, // Nov
      {"x": 11.0, "y": 6.0}, // Dec
    ];

    // EXAMPLE: Third line - 2 Year Average (can be enabled/disabled)
    final fullTwoYearAvgData = [
      {"x": 0.0, "y": 3.25}, // Jan
      {"x": 1.0, "y": 3.55}, // Feb
      {"x": 2.0, "y": 3.85}, // Mar
      {"x": 3.0, "y": 3.65}, // Apr
      {"x": 4.0, "y": 3.5}, // May
      {"x": 5.0, "y": 4.2}, // Jun
      {"x": 6.0, "y": 4.8}, // Jul
      {"x": 7.0, "y": 4.5}, // Aug
      {"x": 8.0, "y": 4.25}, // Sep
      {"x": 9.0, "y": 5.0}, // Oct
      {"x": 10.0, "y": 5.4}, // Nov
      {"x": 11.0, "y": 6.25}, // Dec
    ];

    final allLabels = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];

    // Filter data based on selected period
    List<Map<String, double>> thisYearData;
    List<Map<String, double>> lastYearData;
    // ignore: unused_local_variable
    List<Map<String, double>> twoYearAvgData; // Used when third line is enabled
    List<String> labels;
    double maxX;

    if (period == "Jan-Jun") {
      // First 6 months (Jan to Jun, indices 0-5)
      thisYearData = fullThisYearData.sublist(0, 6);
      lastYearData = fullLastYearData.sublist(0, 6);
      twoYearAvgData = fullTwoYearAvgData.sublist(0, 6);
      labels = allLabels.sublist(0, 6);
      maxX = 5.0;
    } else if (period == "Jul-Dec") {
      // Last 6 months (Jul to Dec, indices 6-11)
      // Re-index from 0-5 for the chart
      thisYearData = fullThisYearData.sublist(6, 12).asMap().entries.map((
        entry,
      ) {
        return {"x": entry.key.toDouble(), "y": entry.value["y"]!};
      }).toList();
      lastYearData = fullLastYearData.sublist(6, 12).asMap().entries.map((
        entry,
      ) {
        return {"x": entry.key.toDouble(), "y": entry.value["y"]!};
      }).toList();
      twoYearAvgData = fullTwoYearAvgData.sublist(6, 12).asMap().entries.map((
        entry,
      ) {
        return {"x": entry.key.toDouble(), "y": entry.value["y"]!};
      }).toList();
      labels = allLabels.sublist(6, 12);
      maxX = 5.0;
    } else {
      // Full Year (all 12 months)
      thisYearData = fullThisYearData;
      lastYearData = fullLastYearData;
      twoYearAvgData = fullTwoYearAvgData;
      labels = allLabels;
      maxX = 11.0;
    }

    return {
      // Card header - DYNAMIC from API
      "cardTitle": "Revenue Generated",
      "cardSubtitle": "Comparison with $lastYear",
      "percentageChange": "+6.19%", // DYNAMIC: Calculate from backend
      "isPositiveChange": true, // DYNAMIC: Based on comparison
      // Period options - DYNAMIC from API
      "availablePeriods": ["Jan-Jun", "Jul-Dec", "Full Year"],
      "selectedPeriod": period, // DYNAMIC: Current selection
      // Chart configuration - DYNAMIC from API based on data range
      "chartConfig": {"minX": 0.0, "maxX": maxX, "minY": 2.0, "maxY": 7.0},

      // ============================================
      // DYNAMIC DATASETS - Supports N number of lines
      // ============================================
      // IMPORTANT: You can add/remove datasets here. Backend will control this.
      // Each dataset represents one line on the chart.
      //
      // TO ADD MORE LINES:
      // 1. Create data in the format above (fullThisYearData, fullLastYearData, etc.)
      // 2. Filter it based on period (see twoYearAvgData processing above)
      // 3. Add a new object to this "datasets" array
      // 4. No code changes needed in the widget! It's fully dynamic.
      //
      // SUPPORTED COLORS: Hex format "#RRGGBB" or "#AARRGGBB"
      // Common colors:
      //   - Blue: "#4F46E5", Green: "#10B981", Red: "#EF4444"
      //   - Yellow: "#F59E0B", Purple: "#8B5CF6", Gray: "#9CA3AF"
      "datasets": [
        {
          "label": "$lastYear",
          "data": lastYearData,
          "color": "#9CA3AF", // Gray color
          "strokeWidth": 2.0,
          "showDots": true,
        },
        {
          "label": "$currentYear",
          "data": thisYearData,
          "color": "#4F46E5", // Primary blue
          "strokeWidth": 2.5,
          "showDots": true,
        },
        // ============================================
        // EXAMPLE: Third Line (2-Year Average)
        // ============================================
        // TO ENABLE: Simply uncomment the code below!
        // This demonstrates how easy it is to add more lines.
        // The chart will automatically show 3 lines with proper legend.
        //
        // {
        //   "label": "2-Yr Avg",
        //   "data": twoYearAvgData,
        //   "color": "#10B981", // Green
        //   "strokeWidth": 2.0,
        //   "showDots": true,
        // },
        // ============================================
        // ADD MORE LINES HERE (4th, 5th, etc.)
        // ============================================
        // Just copy the format above and add as many as you need!
        // No widget code changes required - it's fully dynamic.
      ],

      // X-axis labels - DYNAMIC from API based on period
      "labels": labels,

      // DEPRECATED: Old format (kept for backward compatibility)
      // Will be removed in future versions
      "thisYearLabel": "$currentYear",
      "lastYearLabel": "$lastYear",
      "thisYearData": thisYearData,
      "lastYearData": lastYearData,
    };
  }

  /// ============================================
  /// .NET API CONTROLLER EXAMPLE
  /// ============================================
  ///
  /// Here's how to implement the API endpoint in your .NET backend:
  ///
  /// ```csharp
  /// [ApiController]
  /// [Route("api/revenue")]
  /// public class RevenueController : ControllerBase
  /// {
  ///     private readonly IRevenueService _revenueService;
  ///
  ///     public RevenueController(IRevenueService revenueService)
  ///     {
  ///         _revenueService = revenueService;
  ///     }
  ///
  ///     [HttpGet("dashboard")]
  ///     [Authorize] // Require authentication
  ///     public async Task<IActionResult> GetRevenueDashboard(
  ///         [FromQuery] string period = "Full Year",
  ///         [FromQuery] int? year = null)
  ///     {
  ///         try
  ///         {
  ///             var currentYear = year ?? DateTime.Now.Year;
  ///             var lastYear = currentYear - 1;
  ///
  ///             var thisYearData = await _revenueService.GetRevenueDataAsync(currentYear, period);
  ///             var lastYearData = await _revenueService.GetRevenueDataAsync(lastYear, period);
  ///
  ///             var percentageChange = CalculatePercentageChange(thisYearData, lastYearData);
  ///
  ///             var response = new
  ///             {
  ///                 CardTitle = "Revenue Generated",
  ///                 CardSubtitle = $"Comparison with {lastYear}",
  ///                 ThisYearLabel = currentYear.ToString(),
  ///                 LastYearLabel = lastYear.ToString(),
  ///                 PercentageChange = $"{(percentageChange >= 0 ? "+" : "")}{percentageChange:F2}%",
  ///                 IsPositiveChange = percentageChange >= 0,
  ///                 AvailablePeriods = new[] { "Jan-Jun", "Jul-Dec", "Full Year" },
  ///                 SelectedPeriod = period,
  ///                 ChartConfig = new
  ///                 {
  ///                     MinX = 0.0,
  ///                     MaxX = 11.0,
  ///                     MinY = 2.0,
  ///                     MaxY = 7.0
  ///                 },
  ///                 ThisYearData = thisYearData,
  ///                 LastYearData = lastYearData,
  ///                 Labels = GetLabelsForPeriod(period)
  ///             };
  ///
  ///             return Ok(response);
  ///         }
  ///         catch (Exception ex)
  ///         {
  ///             return StatusCode(500, new { error = ex.Message });
  ///         }
  ///     }
  ///
  ///     private string[] GetLabelsForPeriod(string period)
  ///     {
  ///         return period switch
  ///         {
  ///             "Jan-Jun" => new[] { "Jan", "Feb", "Mar", "Apr", "May", "Jun" },
  ///             "Jul-Dec" => new[] { "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" },
  ///             _ => new[] { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" }
  ///         };
  ///     }
  /// }
  /// ```
  /// ============================================

  /// Helper method to convert API data to FlSpot list for fl_chart
  static List<FlSpot> convertToFlSpots(List<dynamic> dataPoints) {
    return dataPoints.map((point) {
      return FlSpot(
        (point['x'] as num).toDouble(),
        (point['y'] as num).toDouble(),
      );
    }).toList();
  }

  /// Parse chart configuration from API response
  static Map<String, double> parseChartConfig(Map<String, dynamic> config) {
    return {
      'minX': (config['minX'] as num).toDouble(),
      'maxX': (config['maxX'] as num).toDouble(),
      'minY': (config['minY'] as num).toDouble(),
      'maxY': (config['maxY'] as num).toDouble(),
    };
  }
}
