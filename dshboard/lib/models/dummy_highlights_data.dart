/// Dummy Highlights Data
/// This file contains sample data for the highlights section.
///
/// TODO: Replace with API calls to your .NET backend
/// Example API endpoints:
/// - GET /api/highlights/sales - for sales highlights
/// - GET /api/highlights/revenue - for revenue highlights
/// - GET /api/highlights/customers - for customer highlights
///
/// Example API integration:
/// ```dart
/// Future<Map<String, dynamic>> fetchSalesHighlights() async {
///   final response = await http.get(
///     Uri.parse('https://your-api.com/api/highlights/sales'),
///     headers: {'Authorization': 'Bearer YOUR_API_KEY'},
///   );
///   if (response.statusCode == 200) {
///     return json.decode(response.body);
///   }
///   throw Exception('Failed to load highlights');
/// }
/// ```
library;

class DummyHighlightsData {
  DummyHighlightsData._();

  /// Simulate API delay
  static Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  /// Get Sales Highlights Data
  /// API Endpoint: GET /api/highlights/sales
  static Future<Map<String, dynamic>> getSalesHighlights() async {
    await _simulateDelay();

    return {
      'title': 'All time sales',
      'totalValue': 295700,
      'currency': 'USD',
      'percentageChange': 2.7,
      'isPositive': true,
      'products': [
        {
          'name': 'Metronic',
          'percentage': 54,
          'color': 0xFF10B981, // Success green
        },
        {
          'name': 'Bundle',
          'percentage': 19,
          'color': 0xFFEF4444, // Error red
        },
        {
          'name': 'MetronicNest',
          'percentage': 27,
          'color': 0xFF8B5CF6, // Purple
        },
      ],
      'channels': [
        {
          'id': 'online_store',
          'name': 'Online Store',
          'icon': 'store_outlined',
          'value': 172000,
          'percentageChange': 3.9,
          'isPositive': true,
        },
        {
          'id': 'facebook',
          'name': 'Facebook',
          'icon': 'facebook_outlined',
          'value': 85000,
          'percentageChange': 0.7,
          'isPositive': false,
        },
        {
          'id': 'instagram',
          'name': 'Instagram',
          'icon': 'photo_camera_outlined',
          'value': 36000,
          'percentageChange': 8.2,
          'isPositive': true,
        },
        {
          'id': 'google',
          'name': 'Google',
          'icon': 'search',
          'value': 26000,
          'percentageChange': 8.2,
          'isPositive': true,
        },
        {
          'id': 'retail',
          'name': 'Retail',
          'icon': 'storefront_outlined',
          'value': 7000,
          'percentageChange': 0.7,
          'isPositive': false,
        },
      ],
    };
  }

  /// Get Revenue Highlights Data
  /// API Endpoint: GET /api/highlights/revenue
  static Future<Map<String, dynamic>> getRevenueHighlights() async {
    await _simulateDelay();

    return {
      'title': 'Total Revenue',
      'totalValue': 485200,
      'currency': 'USD',
      'percentageChange': 12.5,
      'isPositive': true,
      'products': [
        {
          'name': 'Premium',
          'percentage': 65,
          'color': 0xFF1379F0, // Primary blue
        },
        {
          'name': 'Standard',
          'percentage': 25,
          'color': 0xFFFEC524, // Warning yellow
        },
        {
          'name': 'Basic',
          'percentage': 10,
          'color': 0xFF808290, // Grey
        },
      ],
      'channels': [
        {
          'id': 'subscription',
          'name': 'Subscriptions',
          'icon': 'card_membership_outlined',
          'value': 315000,
          'percentageChange': 15.2,
          'isPositive': true,
        },
        {
          'id': 'one_time',
          'name': 'One-time Sales',
          'icon': 'shopping_cart_outlined',
          'value': 125000,
          'percentageChange': 5.8,
          'isPositive': true,
        },
        {
          'id': 'consulting',
          'name': 'Consulting',
          'icon': 'business_center_outlined',
          'value': 32000,
          'percentageChange': 22.3,
          'isPositive': true,
        },
        {
          'id': 'support',
          'name': 'Support Plans',
          'icon': 'support_agent_outlined',
          'value': 13200,
          'percentageChange': 3.5,
          'isPositive': false,
        },
      ],
    };
  }

  /// Get Customer Highlights Data
  /// API Endpoint: GET /api/highlights/customers
  static Future<Map<String, dynamic>> getCustomerHighlights() async {
    await _simulateDelay();

    return {
      'title': 'Active Customers',
      'totalValue': 12847,
      'currency': null, // No currency for customer count
      'percentageChange': 18.3,
      'isPositive': true,
      'products': [
        {
          'name': 'Enterprise',
          'percentage': 15,
          'color': 0xFF8B5CF6, // Purple
        },
        {
          'name': 'Business',
          'percentage': 35,
          'color': 0xFF1379F0, // Blue
        },
        {
          'name': 'Individual',
          'percentage': 50,
          'color': 0xFF10B981, // Green
        },
      ],
      'channels': [
        {
          'id': 'new_customers',
          'name': 'New Customers',
          'icon': 'person_add_outlined',
          'value': 1247,
          'percentageChange': 25.4,
          'isPositive': true,
        },
        {
          'id': 'returning',
          'name': 'Returning',
          'icon': 'replay_outlined',
          'value': 8532,
          'percentageChange': 12.1,
          'isPositive': true,
        },
        {
          'id': 'vip',
          'name': 'VIP Members',
          'icon': 'stars_outlined',
          'value': 2147,
          'percentageChange': 8.7,
          'isPositive': true,
        },
        {
          'id': 'trial',
          'name': 'Trial Users',
          'icon': 'timer_outlined',
          'value': 921,
          'percentageChange': 3.2,
          'isPositive': false,
        },
      ],
    };
  }

  /// Format currency value
  static String formatCurrency(int value, String? currency) {
    if (currency == null) {
      return _formatNumber(value);
    }

    final formatted = _formatNumber(value);

    if (value >= 1000) {
      final thousands = value / 1000;
      return '\$${thousands.toStringAsFixed(1)}k';
    }

    return '\$$formatted';
  }

  /// Format number with commas
  static String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
