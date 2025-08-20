import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api'; // Change this to your Django server URL
  
  // Get stored access token
  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }
  
  // Get stored refresh token
  Future<String?> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }
  
  // Store tokens
  Future<void> storeTokens(String accessToken, String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
  }
  
  // Clear tokens (logout)
  Future<void> clearTokens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }
  
  // Get headers with authorization
  Future<Map<String, String>> getHeaders() async {
    String? token = await getAccessToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
  
  // Refresh access token
  Future<bool> refreshToken() async {
    try {
      String? refreshToken = await getRefreshToken();
      if (refreshToken == null) return false;
      
      final response = await http.post(
        Uri.parse('$baseUrl/auth/token/refresh/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'refresh': refreshToken}),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await storeTokens(data['access'], refreshToken);
        return true;
      }
      return false;
    } catch (e) {
      print('Error refreshing token: $e');
      return false;
    }
  }
  
  // Generic API call with automatic token refresh
  Future<http.Response> makeAuthenticatedRequest(
    String method,
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParams,
  }) async {
    Uri uri = Uri.parse('$baseUrl$endpoint');
    if (queryParams != null) {
      uri = uri.replace(queryParameters: queryParams);
    }
    
    Map<String, String> headers = await getHeaders();
    
    http.Response response;
    
    switch (method.toUpperCase()) {
      case 'GET':
        response = await http.get(uri, headers: headers);
        break;
      case 'POST':
        response = await http.post(
          uri,
          headers: headers,
          body: body != null ? json.encode(body) : null,
        );
        break;
      case 'PUT':
        response = await http.put(
          uri,
          headers: headers,
          body: body != null ? json.encode(body) : null,
        );
        break;
      case 'PATCH':
        response = await http.patch(
          uri,
          headers: headers,
          body: body != null ? json.encode(body) : null,
        );
        break;
      case 'DELETE':
        response = await http.delete(uri, headers: headers);
        break;
      default:
        throw Exception('Unsupported HTTP method: $method');
    }
    
    // If token expired, try to refresh and retry
    if (response.statusCode == 401) {
      bool refreshed = await refreshToken();
      if (refreshed) {
        // Retry the request with new token
        headers = await getHeaders();
        switch (method.toUpperCase()) {
          case 'GET':
            response = await http.get(uri, headers: headers);
            break;
          case 'POST':
            response = await http.post(
              uri,
              headers: headers,
              body: body != null ? json.encode(body) : null,
            );
            break;
          case 'PUT':
            response = await http.put(
              uri,
              headers: headers,
              body: body != null ? json.encode(body) : null,
            );
            break;
          case 'PATCH':
            response = await http.patch(
              uri,
              headers: headers,
              body: body != null ? json.encode(body) : null,
            );
            break;
          case 'DELETE':
            response = await http.delete(uri, headers: headers);
            break;
        }
      }
    }
    
    return response;
  }
}