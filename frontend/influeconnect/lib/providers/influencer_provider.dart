import 'package:flutter/material.dart';
import '../service/service_locator.dart';
import '../service/influencer_service.dart';

class InfluencerProvider with ChangeNotifier {
  final InfluencerService _influencerService = getIt<InfluencerService>();
  
  bool _isLoading = false;
  List<Map<String, dynamic>> _influencers = [];
  Map<String, dynamic>? _myProfile;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get influencers => _influencers;
  Map<String, dynamic>? get myProfile => _myProfile;
  String? get errorMessage => _errorMessage;

  Future<bool> createInfluencer({
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
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _influencerService.createInfluencer(
      firstName: firstName,
      lastName: lastName,
      secondName: secondName,
      phoneNumber: phoneNumber,
      country: country,
      socialTiktok: socialTiktok,
      socialInstagram: socialInstagram,
      socialThreads: socialThreads,
      socialX: socialX,
      socialLinkedin: socialLinkedin,
      interests: interests,
      description: description,
    );

    _isLoading = false;
    
    if (result['success']) {
      _myProfile = result['data'];
      _errorMessage = null;
    } else {
      _errorMessage = result['error'] ?? 'Failed to create influencer profile';
    }
    
    notifyListeners();
    return result['success'];
  }

  Future<void> loadInfluencers() async {
    _isLoading = true;
    notifyListeners();

    final result = await _influencerService.getInfluencers();
    
    _isLoading = false;
    
    if (result['success']) {
      _influencers = List<Map<String, dynamic>>.from(result['data']['results'] ?? []);
      _errorMessage = null;
    } else {
      _errorMessage = result['error'] ?? 'Failed to load influencers';
    }
    
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}