import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class AuthService extends ApiService {
  
  // Register new user
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    required String password2,
    required String userType,
    String? firstName,
    String? lastName,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/auth/register/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
          'password2': password2,
          'user_type': userType,
          'first_name': firstName ?? '',
          'last_name': lastName ?? '',
        }),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 201) {
        // Store tokens on successful registration
        await storeTokens(
          data['tokens']['access'],
          data['tokens']['refresh'],
        );
      }
      
      return {
        'success': response.statusCode == 201,
        'data': data,
        'statusCode': response.statusCode,
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: $e',
        'statusCode': 0,
      };
    }
  }
  
  // Login user
  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/auth/login/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        // Store tokens on successful login
        await storeTokens(data['access'], data['refresh']);
      }
      
      return {
        'success': response.statusCode == 200,
        'data': data,
        'statusCode': response.statusCode,
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: $e',
        'statusCode': 0,
      };
    }
  }
  
  // Logout user
  Future<Map<String, dynamic>> logout() async {
    try {
      String? refreshToken = await getRefreshToken();
      
      final response = await makeAuthenticatedRequest(
        'POST',
        '/auth/logout/',
        body: {'refresh_token': refreshToken},
      );
      
      // Clear tokens regardless of response
      await clearTokens();
      
      return {
        'success': true,
        'message': 'Logged out successfully',
      };
    } catch (e) {
      await clearTokens(); // Clear tokens even if request fails
      return {
        'success': true,
        'message': 'Logged out locally',
      };
    }
  }
  
  // Get user profile
  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final response = await makeAuthenticatedRequest('GET', '/auth/profile/');
      final data = json.decode(response.body);
      
      return {
        'success': response.statusCode == 200,
        'data': data,
        'statusCode': response.statusCode,
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: $e',
        'statusCode': 0,
      };
    }
  }
  
  // Update user profile
  Future<Map<String, dynamic>> updateUserProfile({
    String? username,
    String? email,
    String? firstName,
    String? lastName,
  }) async {
    try {
      Map<String, dynamic> updateData = {};
      if (username != null) updateData['username'] = username;
      if (email != null) updateData['email'] = email;
      if (firstName != null) updateData['first_name'] = firstName;
      if (lastName != null) updateData['last_name'] = lastName;
      
      final response = await makeAuthenticatedRequest(
        'PUT',
        '/auth/profile/',
        body: updateData,
      );
      
      final data = json.decode(response.body);
      
      return {
        'success': response.statusCode == 200,
        'data': data,
        'statusCode': response.statusCode,
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: $e',
        'statusCode': 0,
      };
    }
  }
  
  // Change password
  Future<Map<String, dynamic>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String newPassword2,
  }) async {
    try {
      final response = await makeAuthenticatedRequest(
        'POST',
        '/auth/change-password/',
        body: {
          'old_password': oldPassword,
          'new_password': newPassword,
          'new_password2': newPassword2,
        },
      );
      
      final data = json.decode(response.body);
      
      return {
        'success': response.statusCode == 200,
        'data': data,
        'statusCode': response.statusCode,
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: $e',
        'statusCode': 0,
      };
    }
  }
  
  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    String? token = await getAccessToken();
    return token != null;
  }
}
