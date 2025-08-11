// lib/services/auth_service.dart
import 'dart:async';
import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String email;
  final String name;
  final String type; // 'creator' or 'brand'
  final bool verified;
  
  User({
    required this.id,
    required this.email,
    required this.name,
    required this.type,
    this.verified = false,
  });
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      type: json['type'],
      verified: json['verified'] ?? false,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'type': type,
      'verified': verified,
    };
  }
}

class AuthService extends ChangeNotifier {
  User? _currentUser;
  String? _token;
  bool _isLoading = false;
  
  User? get currentUser => _currentUser;
  String? get token => _token;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null && _token != null;
  
  // Stream controller for auth state changes
  final StreamController<User?> _authStateController = StreamController<User?>.broadcast();
  Stream<User?> get authStateChanges => _authStateController.stream;
  
  // Login method
  Future<Map<String, dynamic>> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 1000));
      
      // Mock successful login
      if (email.isNotEmpty && password.isNotEmpty) {
        _token = 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}';
        _currentUser = User(
          id: '1',
          email: email,
          name: 'Sample User',
          type: 'creator',
          verified: true,
        );
        
        _authStateController.add(_currentUser);
        
        _isLoading = false;
        notifyListeners();
        
        return {
          'success': true,
          'message': 'Login successful',
          'user': _currentUser!.toJson(),
        };
      } else {
        _isLoading = false;
        notifyListeners();
        
        return {
          'success': false,
          'message': 'Invalid email or password',
        };
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      
      return {
        'success': false,
        'message': 'Login failed: $e',
      };
    }
  }
  
  // Register method
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String name,
    required String type,
  }) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 1000));
      
      // Mock successful registration
      _token = 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}';
      _currentUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        name: name,
        type: type,
        verified: false,
      );
      
      _authStateController.add(_currentUser);
      
      _isLoading = false;
      notifyListeners();
      
      return {
        'success': true,
        'message': 'Registration successful',
        'user': _currentUser!.toJson(),
      };
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      
      return {
        'success': false,
        'message': 'Registration failed: $e',
      };
    }
  }
  
  // Logout method
  Future<void> logout() async {
    _currentUser = null;
    _token = null;
    _authStateController.add(null);
    notifyListeners();
  }
  
  // Check if user is logged in (useful for app initialization)
  Future<void> checkAuthStatus() async {
    // In a real app, you'd check stored token/session here
    // For now, we'll assume user is not logged in initially
    _currentUser = null;
    _token = null;
    notifyListeners();
  }
  
  // Reset password method
  Future<Map<String, dynamic>> resetPassword(String email) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 800));
      
      return {
        'success': true,
        'message': 'Password reset email sent successfully',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to send reset email: $e',
      };
    }
  }
  
  @override
  void dispose() {
    _authStateController.close();
    super.dispose();
  }
}