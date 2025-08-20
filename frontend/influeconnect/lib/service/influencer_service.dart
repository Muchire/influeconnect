import 'dart:convert';
import 'dart:io';
import 'api_service.dart';

class InfluencerService extends ApiService {
  
  // Create influencer profile
  Future<Map<String, dynamic>> createInfluencer({
    required String firstName,
    required String lastName,
    String? secondName,
    String? phoneNumber,
    String? country,
    String? socialTiktok,
    String? socialInstagram,
    String? socialThreads,
    String? socialX,
    String? socialLinkedin,
    List<String>? interests,
    String? description,
    File? profilePicture,
  }) async {
    try {
      final response = await makeAuthenticatedRequest(
        'POST',
        '/influencers/create/',
        body: {
          'first_name': firstName,
          'last_name': lastName,
          'second_name': secondName ?? '',
          'phone_number': phoneNumber ?? '',
          'country': country ?? '',
          'social_tiktok': socialTiktok ?? '',
          'social_instagram': socialInstagram ?? '',
          'social_threads': socialThreads ?? '',
          'social_x': socialX ?? '',
          'social_linkedin': socialLinkedin ?? '',
          'interests': interests ?? [],
          'description': description ?? '',
        },
      );
      
      final data = json.decode(response.body);
      
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
  
  // Get all influencers
  Future<Map<String, dynamic>> getInfluencers({
    int? page,
    int? pageSize,
  }) async {
    try {
      Map<String, String> queryParams = {};
      if (page != null) queryParams['page'] = page.toString();
      if (pageSize != null) queryParams['page_size'] = pageSize.toString();
      
      final response = await makeAuthenticatedRequest(
        'GET',
        '/influencers/influencers/',
        queryParams: queryParams.isNotEmpty ? queryParams : null,
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
}