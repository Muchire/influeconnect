// lib/services/organization_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class OrganizationService extends ApiService {
  
  // Create organization profile
  Future<Map<String, dynamic>> createOrganization({
    required String name,
    String? phoneNumber,
    String? country,
    String? socialTiktok,
    String? socialInstagram,
    String? socialThreads,
    String? socialX,
    String? socialLinkedin,
    String? sector,
    List<String>? brands,
    File? profilePicture,
  }) async {
    try {
      Map<String, dynamic> organizationData = {
        'name': name,
        'phone_number': phoneNumber ?? '',
        'country': country ?? '',
        'social_tiktok': socialTiktok ?? '',
        'social_instagram': socialInstagram ?? '',
        'social_threads': socialThreads ?? '',
        'social_x': socialX ?? '',
        'social_linkedin': socialLinkedin ?? '',
        'sector': sector ?? '',
        'brands': brands ?? [],
      };
      
      final response = await makeAuthenticatedRequest(
        'POST',
        '/organizations/',
        body: organizationData,
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
  
  // Get all organizations (for influencers to discover)
  Future<Map<String, dynamic>> getOrganizations({
    int? page,
    int? pageSize,
  }) async {
    try {
      Map<String, String> queryParams = {};
      if (page != null) queryParams['page'] = page.toString();
      if (pageSize != null) queryParams['page_size'] = pageSize.toString();
      
      final response = await makeAuthenticatedRequest(
        'GET',
        '/organizations/',
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
  
  // Get current user's organization profile
  Future<Map<String, dynamic>> getMyOrganization() async {
    try {
      final response = await makeAuthenticatedRequest(
        'GET',
        '/organizations/my_profile/',
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
  
  // Update organization profile
  Future<Map<String, dynamic>> updateOrganization({
    int? organizationId,
    String? name,
    String? phoneNumber,
    String? country,
    String? socialTiktok,
    String? socialInstagram,
    String? socialThreads,
    String? socialX,
    String? socialLinkedin,
    String? sector,
    List<String>? brands,
  }) async {
    try {
      Map<String, dynamic> updateData = {};
      if (name != null) updateData['name'] = name;
      if (phoneNumber != null) updateData['phone_number'] = phoneNumber;
      if (country != null) updateData['country'] = country;
      if (socialTiktok != null) updateData['social_tiktok'] = socialTiktok;
      if (socialInstagram != null) updateData['social_instagram'] = socialInstagram;
      if (socialThreads != null) updateData['social_threads'] = socialThreads;
      if (socialX != null) updateData['social_x'] = socialX;
      if (socialLinkedin != null) updateData['social_linkedin'] = socialLinkedin;
      if (sector != null) updateData['sector'] = sector;
      if (brands != null) updateData['brands'] = brands;
      
      String endpoint = organizationId != null 
          ? '/organizations/$organizationId/'
          : '/organizations/my_profile/';
      
      final response = await makeAuthenticatedRequest(
        'PATCH',
        endpoint,
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
  
  // Add brand to organization
  Future<Map<String, dynamic>> addBrandToOrganization({
    required int organizationId,
    required String brandName,
  }) async {
    try {
      final response = await makeAuthenticatedRequest(
        'POST',
        '/organizations/$organizationId/add_brand/',
        body: {'brand_name': brandName},
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
  
  // Remove brand from organization
  Future<Map<String, dynamic>> removeBrandFromOrganization({
    required int organizationId,
    required String brandName,
  }) async {
    try {
      final response = await makeAuthenticatedRequest(
        'POST',
        '/organizations/$organizationId/remove_brand/',
        body: {'brand_name': brandName},
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