// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'services/api_service.dart';
import 'pages/home_page.dart';
import 'pages/auth/influencer_signup_page.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<ApiService>(create: (_) => ApiService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InfluencerConnect',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: AppTheme.primaryWhite,
        appBarTheme: AppBarTheme(
          backgroundColor: AppTheme.primaryWhite,
          elevation: 0,
          iconTheme: IconThemeData(color: AppTheme.accentBrown),
          titleTextStyle: TextStyle(
            color: AppTheme.accentBrown,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomePage(),
      routes: {
        '/dashboard': (context) => const HomePage(),
        '/influencer-signup': (context) => const InfluencerSignUpPage(),
        // Add more routes as needed
      },
    );
  }
}