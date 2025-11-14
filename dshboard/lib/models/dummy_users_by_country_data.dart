/// ============================================
/// DUMMY DATA FOR USERS BY COUNTRY TABLE
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
///    - GET /api/analytics/users-by-country
///    - Query Parameters:
///      * period: string (Weekly, Monthly, Yearly)
///      * page: int (default: 1)
///      * pageSize: int (default: 8)
///
/// 2. API RESPONSE FORMAT (JSON):
/// {
///   "header": {
///     "title": "Users by Country",
///     "subtitle": "Detail informations of users",
///     "selectedPeriod": "Weekly",
///     "availablePeriods": ["Weekly", "Monthly", "Yearly"]
///   },
///   "summary": {
///     "totalUsers": 187500,
///     "percentageChange": 16.2,
///     "newUsers": 87200,
///     "engagedSessions": 156000
///   },
///   "countries": [
///     {
///       "rank": 1,
///       "country": "Nepal",
///       "countryCode": "NP",
///       "totalUsers": 52847,
///       "percentageChange": 18.2,
///       "newUsers": 24520,
///       "engagedSessions": 43920
///     }
///   ],
///   "pagination": {
///     "currentPage": 1,
///     "totalPages": 3,
///     "showingStart": 1,
///     "showingEnd": 8,
///     "totalItems": 24
///   }
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

class UserCountryData {
  final int rank;
  final String country;
  final String countryCode; // ISO 3166-1 alpha-2 code for flag
  final int totalUsers;
  final double percentageChange; // vs. Last week
  final int newUsers;
  final int engagedSessions;

  UserCountryData({
    required this.rank,
    required this.country,
    required this.countryCode,
    required this.totalUsers,
    required this.percentageChange,
    required this.newUsers,
    required this.engagedSessions,
  });

  /// Convert to JSON (for future API integration)
  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'country': country,
      'countryCode': countryCode,
      'totalUsers': totalUsers,
      'percentageChange': percentageChange,
      'newUsers': newUsers,
      'engagedSessions': engagedSessions,
    };
  }

  /// Create from JSON (for future API integration)
  factory UserCountryData.fromJson(Map<String, dynamic> json) {
    return UserCountryData(
      rank: json['rank'] as int,
      country: json['country'] as String,
      countryCode: json['countryCode'] as String,
      totalUsers: json['totalUsers'] as int,
      percentageChange: (json['percentageChange'] as num).toDouble(),
      newUsers: json['newUsers'] as int,
      engagedSessions: json['engagedSessions'] as int,
    );
  }
}

class DummyUsersByCountryData {
  /// Simulates fetching users by country data from backend
  ///
  /// TODO: Replace with .NET API call:
  /// GET /api/analytics/users-by-country?period={period}
  static Future<Map<String, dynamic>> getUsersByCountryData({
    String period = 'Weekly',
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    return {
      // Header configuration - from API
      "header": {
        "title": "Users by Country",
        "subtitle": "Detail informations of users",
        "selectedPeriod": period, // Current selected period
        "availablePeriods": ["Weekly", "Monthly", "Yearly"], // Period options
      },

      // Summary data - from API
      "summary": {
        "totalUsers": 166999,
        "percentageChange": 1.56,
        "newUsers": 28935,
        "engagedSessions": 104135,
      },

      // Country data - from API
      "countries": [
        {
          "rank": 1,
          "country": "Nepal",
          "countryCode": "NP",
          "totalUsers": 84694,
          "percentageChange": 2.90,
          "newUsers": 9536,
          "engagedSessions": 19536,
        },
        {
          "rank": 2,
          "country": "India",
          "countryCode": "IN",
          "totalUsers": 30612,
          "percentageChange": -4.31,
          "newUsers": 7700,
          "engagedSessions": 2900,
        },
        {
          "rank": 3,
          "country": "Australia",
          "countryCode": "AU",
          "totalUsers": 22112,
          "percentageChange": 0.05,
          "newUsers": 2778,
          "engagedSessions": 21778,
        },
        {
          "rank": 4,
          "country": "USA",
          "countryCode": "US",
          "totalUsers": 9928,
          "percentageChange": 11.31,
          "newUsers": 2272,
          "engagedSessions": 29272,
        },
        {
          "rank": 5,
          "country": "Egypt",
          "countryCode": "EG",
          "totalUsers": 9025,
          "percentageChange": 3.77,
          "newUsers": 1374,
          "engagedSessions": 10374,
        },
        {
          "rank": 6,
          "country": "France",
          "countryCode": "FR",
          "totalUsers": 5357,
          "percentageChange": -1.94,
          "newUsers": 3374,
          "engagedSessions": 3374,
        },
        {
          "rank": 7,
          "country": "Bangladesh",
          "countryCode": "BD",
          "totalUsers": 5271,
          "percentageChange": 2.01,
          "newUsers": 1901,
          "engagedSessions": 16901,
        },
        {
          "rank": 8,
          "country": "Germany",
          "countryCode": "DE",
          "totalUsers": 4823,
          "percentageChange": 5.12,
          "newUsers": 1456,
          "engagedSessions": 8456,
        },
      ],
      "pagination": {
        "currentPage": 1,
        "totalPages": 3,
        "itemsPerPage": 8,
        "totalItems": 24,
        "showingStart": 1,
        "showingEnd": 8,
      },
    };
  }

  /// Get list of UserCountryData objects
  static Future<List<UserCountryData>> getUserCountryList() async {
    final data = await getUsersByCountryData();
    final countriesList = data['countries'] as List;
    return countriesList
        .map((country) => UserCountryData.fromJson(country))
        .toList();
  }
}
