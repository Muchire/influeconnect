import 'dart:convert';
import '../service/api_service.dart';

class BrandService extends ApiService {
  
  // Create new brand
  Future<Map<String, dynamic>> createBrand({
    required String brand,
    required String brandName,
  }) async {
    try {
      final response = await makeAuthenticatedRequest(
        'POST',
        '/brands/',
        body: {
          'brand': brand,
          'brand_name': brandName,
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
  
  // Get all brands
  Future<Map<String, dynamic>> getBrands({
    int? page,
    int? pageSize,
  }) async {
    try {
      Map<String, String> queryParams = {};
      if (page != null) queryParams['page'] = page.toString();
      if (pageSize != null) queryParams['page_size'] = pageSize.toString();
      
      final response = await makeAuthenticatedRequest(
        'GET',
        '/brands/',
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
  
  // Get organization's brands
  Future<Map<String, dynamic>> getMyBrands() async {
    try {
      final response = await makeAuthenticatedRequest(
        'GET',
        '/brands/my_brands/',
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
  
  // Search brands
  Future<Map<String, dynamic>> searchBrands({
    required String query,
    int? page,
    int? pageSize,
  }) async {
    try {
      Map<String, String> queryParams = {'q': query};
      if (page != null) queryParams['page'] = page.toString();
      if (pageSize != null) queryParams['page_size'] = pageSize.toString();
      
      final response = await makeAuthenticatedRequest(
        'GET',
        '/brands/search/',
        queryParams: queryParams,
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
  
  // Get specific brand
  Future<Map<String, dynamic>> getBrand(int brandId) async {
    try {
      final response = await makeAuthenticatedRequest(
        'GET',
        '/brands/$brandId/',
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
  
  // Update brand
  Future<Map<String, dynamic>> updateBrand({
    required int brandId,
    String? brand,
    String? brandName,
  }) async {
    try {
      Map<String, dynamic> updateData = {};
      if (brand != null) updateData['brand'] = brand;
      if (brandName != null) updateData['brand_name'] = brandName;
      
      final response = await makeAuthenticatedRequest(
        'PATCH',
        '/brands/$brandId/',
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
  
  // Delete brand
  Future<Map<String, dynamic>> deleteBrand(int brandId) async {
    try {
      final response = await makeAuthenticatedRequest(
        'DELETE',
        '/brands/$brandId/',
      );
      
      return {
        'success': response.statusCode == 204,
        'message': 'Brand deleted successfully',
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
