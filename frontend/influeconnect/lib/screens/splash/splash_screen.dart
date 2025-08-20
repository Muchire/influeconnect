import 'package:flutter/material.dart';
import '/service/service_locator.dart';
import '/service/auth_service.dart';
import 'package:influeconnect/utils/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final AuthService _authService = getIt<AuthService>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    
    _animationController.forward();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 3));
    
    bool isLoggedIn = await _authService.isLoggedIn();
    
    if (mounted) {
      Navigator.pushReplacementNamed(
        context, 
        isLoggedIn ? '/home' : '/login'
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryWhite,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppTheme.mediumBrown,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.connect_without_contact,
                  size: 60,
                  color: AppTheme.primaryWhite,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'InflueConnect',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.mediumBrown,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Connecting Brands with Influencers',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.textLight,
                ),
              ),
              const SizedBox(height: 40),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.lightBrown),
              ),
            ],
          ),
        ),
      ),
    );
  }
}