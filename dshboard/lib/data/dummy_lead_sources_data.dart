import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/dashboard_pie_chart.dart';

/// Dummy data for Lead Sources Card
/// This simulates data that will come from your .NET backend API
///
/// TO INTEGRATE WITH .NET API:
/// ===========================
/// Replace the getDummyLeadSourcesData() call with actual HTTP request:
///
/// ```dart
/// import 'package:http/http.dart' as http;
/// import 'dart:convert';
///
/// Future<Map<String, dynamic>> getLeadSourcesDataFromAPI() async {
///   final response = await http.get(
///     Uri.parse('https://your-api.com/api/dashboard/lead-sources'),
///     headers: {
///       'Authorization': 'Bearer YOUR_TOKEN',
///       'Content-Type': 'application/json',
///     },
///   );
///
///   if (response.statusCode == 200) {
///     return json.decode(response.body);
///   } else {
///     throw Exception('Failed to load lead sources data');
///   }
/// }
/// ```

class DummyLeadSourcesData {
  /// Simulates API call with 800ms delay
  /// Returns all dynamic data for the Lead Sources card
  static Future<Map<String, dynamic>> getDummyLeadSourcesData() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Return data in the same format your .NET API will provide
    return {
      // Card header
      'cardTitle': 'Lead Sources',
      'cardSubtitle': 'Ratio of generated leads',

      // Center value in donut chart
      'totalLeads': '2847',

      // Pie chart sections (donut chart)
      // Each section has: label, value, percentage, color
      'pieChartData': [
        {
          'label': 'Organic',
          'value': 950.0, // Number of leads
          'percentage': 33.4, // Percentage of total
          'color': '0xFF4F9EF8', // Blue
        },
        {
          'label': 'Marketing',
          'value': 712.0,
          'percentage': 25.0,
          'color': '0xFFFFA644', // Orange
        },
        {
          'label': 'Social media',
          'value': 599.0,
          'percentage': 21.0,
          'color': '0xFF3DD9BC', // Cyan/Turquoise
        },
        {
          'label': 'Blog posts',
          'value': 586.0,
          'percentage': 20.6,
          'color': '0xFF4DB88E', // Green
        },
      ],

      // Legend data (same as pie chart but for display below)
      'legendData': [
        {'label': 'Organic', 'color': '0xFF4F9EF8'},
        {'label': 'Marketing', 'color': '0xFFFFA644'},
        {'label': 'Social media', 'color': '0xFF3DD9BC'},
        {'label': 'Blog posts', 'color': '0xFF4DB88E'},
      ],
    };
  }

  /// Converts API pie chart data to fl_chart PieChartSectionData format
  /// Can accept optional touchedIndex to scale the hovered section
  static List<PieChartSectionData> convertToPieChartData(
    List<dynamic> pieData, {
    int touchedIndex = -1,
  }) {
    return pieData.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      final colorValue = int.parse(item['color'] as String);
      final isTouched = index == touchedIndex;

      return PieChartSectionData(
        value: item['value'] as double,
        title: '', // Remove percentage labels from chart
        color: Color(colorValue),
        radius: isTouched ? 42 : 38, // Scale up when hovered (38→42)
        badgePositionPercentageOffset: isTouched
            ? 1.3
            : 1.0, // Push outward on hover
        titleStyle: const TextStyle(
          fontSize: 0, // Hidden
          fontWeight: FontWeight.w600,
          color: Colors.transparent,
        ),
      );
    }).toList();
  }

  /// Converts API legend data to LeadSourceItem format
  static List<LeadSourceItem> convertToLegendItems(List<dynamic> legendData) {
    return legendData.map((item) {
      final colorValue = int.parse(item['color'] as String);

      return LeadSourceItem(
        label: item['label'] as String,
        color: Color(colorValue),
      );
    }).toList();
  }
}

// ==========================================
// .NET API ENDPOINT EXAMPLE
// ==========================================
//
// Your .NET backend should return JSON in this format:
//
// GET /api/dashboard/lead-sources
//
// Response (200 OK):
// {
//   "cardTitle": "Lead Sources",
//   "cardSubtitle": "Ratio of generated leads",
//   "totalLeads": "2847",
//   "pieChartData": [
//     {
//       "label": "Organic",
//       "value": 950.0,
//       "percentage": 33.4,
//       "color": "0xFF4F9EF8"
//     },
//     {
//       "label": "Marketing",
//       "value": 712.0,
//       "percentage": 25.0,
//       "color": "0xFFFFA644"
//     },
//     {
//       "label": "Social media",
//       "value": 599.0,
//       "percentage": 21.0,
//       "color": "0xFF3DD9BC"
//     },
//     {
//       "label": "Blog posts",
//       "value": 586.0,
//       "percentage": 20.6,
//       "color": "0xFF4DB88E"
//     }
//   ],
//   "legendData": [
//     {
//       "label": "Organic",
//       "color": "0xFF4F9EF8"
//     },
//     {
//       "label": "Marketing",
//       "color": "0xFFFFA644"
//     },
//     {
//       "label": "Social media",
//       "color": "0xFF3DD9BC"
//     },
//     {
//       "label": "Blog posts",
//       "color": "0xFF4DB88E"
//     }
//   ]
// }
//
// ==========================================
// C# BACKEND EXAMPLE
// ==========================================
//
// [ApiController]
// [Route("api/dashboard")]
// public class DashboardController : ControllerBase
// {
//     private readonly ILeadSourcesService _leadSourcesService;
//
//     public DashboardController(ILeadSourcesService leadSourcesService)
//     {
//         _leadSourcesService = leadSourcesService;
//     }
//
//     [HttpGet("lead-sources")]
//     public async Task<IActionResult> GetLeadSources()
//     {
//         try
//         {
//             var leadSourcesData = await _leadSourcesService.GetLeadSourcesDataAsync();
//
//             var response = new
//             {
//                 cardTitle = "Lead Sources",
//                 cardSubtitle = "Ratio of generated leads",
//                 totalLeads = leadSourcesData.TotalLeads.ToString(),
//                 pieChartData = leadSourcesData.Sources.Select(s => new
//                 {
//                     label = s.SourceName,
//                     value = (double)s.LeadCount,
//                     percentage = s.Percentage,
//                     color = s.ColorHex
//                 }).ToList(),
//                 legendData = leadSourcesData.Sources.Select(s => new
//                 {
//                     label = s.SourceName,
//                     color = s.ColorHex
//                 }).ToList()
//             };
//
//             return Ok(response);
//         }
//         catch (Exception ex)
//         {
//             return StatusCode(500, new { message = "Error fetching lead sources data", error = ex.Message });
//         }
//     }
// }
//
// // Models
// public class LeadSourcesData
// {
//     public int TotalLeads { get; set; }
//     public List<LeadSource> Sources { get; set; }
// }
//
// public class LeadSource
// {
//     public string SourceName { get; set; }
//     public int LeadCount { get; set; }
//     public double Percentage { get; set; }
//     public string ColorHex { get; set; } // e.g., "0xFF4F9EF8"
// }
