import 'package:flutter/material.dart';
import '../service/service_locator.dart';
import '../service/organization_service.dart';

class OrganizationProvider with ChangeNotifier {
  final OrganizationService _orgService = getIt<OrganizationService>();
  
  bool _isLoading = false;
  List<Map<String, dynamic>> _organizations = [];
  Map<String, dynamic>? _myOrganization;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get organizations => _organizations;
  Map<String, dynamic>? get myOrganization => _myOrganization;
  String? get errorMessage => _errorMessage;

  Future<bool> createOrganization({
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
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _orgService.createOrganization(
      name: name,
      phoneNumber: phoneNumber,
      country: country,
      socialTiktok: socialTiktok,
      socialInstagram: socialInstagram,
      socialThreads: socialThreads,
      socialX: socialX,
      socialLinkedin: socialLinkedin,
      sector: sector,
      brands: brands,
    );

    _isLoading = false;
    
    if (result['success']) {
      _myOrganization = result['data'];
      _errorMessage = null;
    } else {
      _errorMessage = result['error'] ?? 'Failed to create organization';
    }
    
    notifyListeners();
    return result['success'];
  }

  Future<void> loadOrganizations() async {
    _isLoading = true;
    notifyListeners();

    final result = await _orgService.getOrganizations();
    
    _isLoading = false;
    
    if (result['success']) {
      _organizations = List<Map<String, dynamic>>.from(result['data']['results'] ?? []);
      _errorMessage = null;
    } else {
      _errorMessage = result['error'] ?? 'Failed to load organizations';
    }
    
    notifyListeners();
  }

  Future<void> loadMyOrganization() async {
    _isLoading = true;
    notifyListeners();

    final result = await _orgService.getMyOrganization();
    
    _isLoading = false;
    
    if (result['success']) {
      _myOrganization = result['data'];
      _errorMessage = null;
    } else {
      _errorMessage = result['error'] ?? 'Failed to load organization profile';
    }
    
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}