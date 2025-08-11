// lib/services/api_service.dart
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://your-api-domain.com/api/v1';
  static const Duration timeoutDuration = Duration(seconds: 30);
  
  // Headers for API requests
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Map<String, String> _headersWithAuth(String token) => {
    ..._headers,
    'Authorization': 'Bearer $token',
  };

  // Generic API call method
  Future<ApiResponse> _makeRequest({
    required String method,
    required String endpoint,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/$endpoint');
      final headers = token != null ? _headersWithAuth(token) : _headers;
      
      http.Response response;
      
      switch (method.toLowerCase()) {
        case 'get':
          response = await http.get(uri, headers: headers).timeout(timeoutDuration);
          break;
        case 'post':
          response = await http.post(
            uri, 
            headers: headers, 
            body: data != null ? jsonEncode(data) : null,
          ).timeout(timeoutDuration);
          break;
        case 'put':
          response = await http.put(
            uri, 
            headers: headers, 
            body: data != null ? jsonEncode(data) : null,
          ).timeout(timeoutDuration);
          break;
        case 'delete':
          response = await http.delete(uri, headers: headers).timeout(timeoutDuration);
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      return ApiResponse.fromHttpResponse(response);
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  // PLACEHOLDER DATA METHODS (Remove when connecting to real API)
  
  // Platform Statistics
  Future<Map<String, dynamic>> getPlatformStats() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    return {
      'creators': '1,250+',
      'brands': '350+',
      'campaigns': '2,500+',
      'satisfaction': '98%',
      'totalEarnings': 'KES 15M+',
      'averageRating': 4.8,
    };
  }

  // Featured Campaigns
  Future<List<Map<String, dynamic>>> getFeaturedCampaigns({int limit = 10}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    
    return [
      {
        'id': '1',
        'title': 'Summer Fashion Collection Launch',
        'brand': {
          'name': 'Kenyan Style Co.',
          'logo': 'https://via.placeholder.com/100',
          'verified': true,
        },
        'budget': {
          'min': 25000,
          'max': 75000,
          'currency': 'KES',
        },
        'category': 'Fashion & Beauty',
        'deadline': '2024-03-20',
        'requirements': [
          'Instagram posts (3-5)',
          'Instagram Stories (10+)',
          'TikTok videos (2)',
        ],
        'targetAudience': 'Women 18-35',
        'applicants': 45,
        'status': 'open',
        'createdAt': '2024-02-15',
      },
      {
        'id': '2',
        'title': 'Tech Product Review Campaign',
        'brand': {
          'name': 'Nairobi Tech Hub',
          'logo': 'https://via.placeholder.com/100',
          'verified': true,
        },
        'budget': {
          'min': 50000,
          'max': 150000,
          'currency': 'KES',
        },
        'category': 'Technology',
        'deadline': '2024-03-25',
        'requirements': [
          'YouTube review video (8-12 min)',
          'Instagram posts (2-3)',
          'Twitter thread',
        ],
        'targetAudience': 'Tech enthusiasts 20-45',
        'applicants': 23,
        'status': 'open',
        'createdAt': '2024-02-18',
      },
      {
        'id': '3',
        'title': 'Local Food Brand Promotion',
        'brand': {
          'name': 'Mama\'s Kitchen',
          'logo': 'https://via.placeholder.com/100',
          'verified': false,
        },
        'budget': {
          'min': 15000,
          'max': 40000,
          'currency': 'KES',
        },
        'category': 'Food & Beverage',
        'deadline': '2024-03-15',
        'requirements': [
          'TikTok cooking videos (3)',
          'Instagram Reels (5)',
          'Instagram Stories (15+)',
        ],
        'targetAudience': 'Food lovers 25-50',
        'applicants': 67,
        'status': 'open',
        'createdAt': '2024-02-12',
      },
    ];
  }

  // Top Creators
  Future<List<Map<String, dynamic>>> getTopCreators({int limit = 6}) async {
    await Future.delayed(const Duration(milliseconds: 700));
    
    return [
      {
        'id': '1',
        'name': 'Sarah Mwangi',
        'handle': '@sarah_lifestyle_ke',
        'profileImage': 'https://via.placeholder.com/150',
        'verified': true,
        'followers': {
          'instagram': 145000,
          'tiktok': 89000,
          'youtube': 23000,
        },
        'categories': ['Lifestyle', 'Fashion', 'Travel'],
        'rating': 4.9,
        'completedCampaigns': 87,
        'responseRate': '95%',
        'location': 'Nairobi, Kenya',
        'engagementRate': '8.5%',
      },
      {
        'id': '2',
        'name': 'John Kamau',
        'handle': '@johntech_reviews',
        'profileImage': 'https://via.placeholder.com/150',
        'verified': true,
        'followers': {
          'youtube': 67000,
          'instagram': 34000,
          'twitter': 12000,
        },
        'categories': ['Technology', 'Reviews', 'Gaming'],
        'rating': 4.8,
        'completedCampaigns': 52,
        'responseRate': '98%',
        'location': 'Mombasa, Kenya',
        'engagementRate': '12.3%',
      },
      {
        'id': '3',
        'name': 'Grace Wanjiku',
        'handle': '@grace_foodie',
        'profileImage': 'https://via.placeholder.com/150',
        'verified': true,
        'followers': {
          'instagram': 78000,
          'tiktok': 156000,
          'youtube': 15000,
        },
        'categories': ['Food', 'Cooking', 'Culture'],
        'rating': 4.7,
        'completedCampaigns': 73,
        'responseRate': '92%',
        'location': 'Kisumu, Kenya',
        'engagementRate': '9.8%',
      },
    ];
  }

  // User Authentication (Placeholder)
  Future<ApiResponse> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    
    if (email.isEmpty || password.isEmpty) {
      return ApiResponse.error('Email and password are required');
    }
    
    return ApiResponse.success({
      'token': 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
      'user': {
        'id': '1',
        'email': email,
        'name': 'Sample User',
        'type': 'creator',
        'verified': false,
        'profileComplete': false,
      },
    });
  }

  Future<ApiResponse> register(Map<String, dynamic> userData) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    
    return ApiResponse.success({
      'message': 'Registration successful',
      'user': {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'email': userData['email'],
        'name': userData['name'],
        'type': userData['type'],
        'verified': false,
        'profileComplete': false,
      },
    });
  }

  // When you connect to real API, replace placeholder methods with these:
  /*
  Future<ApiResponse> getPlatformStatsFromAPI() async {
    return await _makeRequest(method: 'GET', endpoint: 'stats/platform');
  }

  Future<ApiResponse> getFeaturedCampaignsFromAPI({int limit = 10}) async {
    return await _makeRequest(method: 'GET', endpoint: 'campaigns/featured?limit=$limit');
  }

  Future<ApiResponse> getTopCreatorsFromAPI({int limit = 6}) async {
    return await _makeRequest(method: 'GET', endpoint: 'creators/top?limit=$limit');
  }

  Future<ApiResponse> loginWithAPI(String email, String password) async {
    return await _makeRequest(
      method: 'POST', 
      endpoint: 'auth/login',
      data: {'email': email, 'password': password},
    );
  }

  Future<ApiResponse> registerWithAPI(Map<String, dynamic> userData) async {
    return await _makeRequest(
      method: 'POST', 
      endpoint: 'auth/register',
      data: userData,
    );
  }
  */
}

// API Response wrapper class
class ApiResponse {
  final bool success;
  final String? message;
  final dynamic data;
  final int? statusCode;

  ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.statusCode,
  });

  factory ApiResponse.success(dynamic data, {String? message}) {
    return ApiResponse(
      success: true,
      data: data,
      message: message,
      statusCode: 200,
    );
  }

  factory ApiResponse.error(String message, {int? statusCode}) {
    return ApiResponse(
      success: false,
      message: message,
      statusCode: statusCode ?? 500,
    );
  }

  factory ApiResponse.fromHttpResponse(http.Response response) {
    try {
      final dynamic data = response.body.isNotEmpty 
          ? jsonDecode(response.body) 
          : null;
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse.success(
          data,
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.error(
          data?['message'] ?? 'Request failed',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse.error(
        'Failed to parse response: $e',
        statusCode: response.statusCode,
      );
    }
  }
}