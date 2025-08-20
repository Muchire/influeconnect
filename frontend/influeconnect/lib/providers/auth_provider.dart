// lib/providers/auth_provider.dart
import 'package:flutter/material.dart';
import '../service/service_locator.dart';
import '../service/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = getIt<AuthService>();
  
  bool _isLoading = false;
  bool _isLoggedIn = false;
  String? _userType;
  Map<String, dynamic>? _userData;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  String? get userType => _userType;
  Map<String, dynamic>? get userData => _userData;
  String? get errorMessage => _errorMessage;

  Future<void> checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();
    
    _isLoggedIn = await _authService.isLoggedIn();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _authService.login(
      username: username,
      password: password,
    );

    _isLoading = false;
    
    if (result['success']) {
      _isLoggedIn = true;
      _userData = result['data'];
      _errorMessage = null;
    } else {
      _errorMessage = result['error'] ?? 'Login failed';
    }
    
    notifyListeners();
    return result['success'];
  }

  Future<bool> register({
    required String username,
    required String email,
    required String password,
    required String password2,
    required String userType,
    String? firstName,
    String? lastName,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _authService.register(
      username: username,
      email: email,
      password: password,
      password2: password2,
      userType: userType,
      firstName: firstName,
      lastName: lastName,
    );

    _isLoading = false;
    
    if (result['success']) {
      _isLoggedIn = true;
      _userType = userType;
      _userData = result['data'];
      _errorMessage = null;
    } else {
      if (result['data'] != null && result['data'] is Map) {
        List<String> errors = [];
        result['data'].forEach((key, value) {
          if (value is List) {
            errors.addAll(value.cast<String>());
          } else {
            errors.add(value.toString());
          }
        });
        _errorMessage = errors.join(', ');
      } else {
        _errorMessage = result['error'] ?? 'Registration failed';
      }
    }
    
    notifyListeners();
    return result['success'];
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    await _authService.logout();
    
    _isLoggedIn = false;
    _userData = null;
    _userType = null;
    _errorMessage = null;
    _isLoading = false;
    
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

// lib/providers/organization_provider.dart


// lib/providers/influencer_provider.dart
