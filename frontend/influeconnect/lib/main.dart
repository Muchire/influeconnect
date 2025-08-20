// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'service/service_locator.dart';
import 'providers/auth_provider.dart';
import 'providers/organization_provider.dart';
import 'providers/influencer_provider.dart';
import 'utils/app_colors.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/user_type_selection_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/profile/organization_profile_screen.dart';
import 'screens/profile/influencer_profile_screen.dart';
import 'screens/brands/brands_screen.dart';
import 'screens/discovery/discovery_screen.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => OrganizationProvider()),
        ChangeNotifierProvider(create: (_) => InfluencerProvider()),
      ],
      child: MaterialApp.router(
        title: 'InflueConnect',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: MaterialColor(0xFF8B4513, AppColors.brownSwatch),
          scaffoldBackgroundColor: AppColors.background,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          textTheme: GoogleFonts.poppinsTextTheme(),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 2,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.lightBrown),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.lightBrown),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
        routerConfig: _router,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/user-type',
      builder: (context, state) => UserTypeSelectionScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/organization-profile',
      builder: (context, state) => OrganizationProfileScreen(),
    ),
    GoRoute(
      path: '/influencer-profile',
      builder: (context, state) => InfluencerProfileScreen(),
    ),
    GoRoute(
      path: '/brands',
      builder: (context, state) => BrandsScreen(),
    ),
    GoRoute(
      path: '/discovery',
      builder: (context, state) => DiscoveryScreen(),
    ),
  ],
);

// lib/utils/app_colors.dart
class AppColors {
  static const Color primary = Color(0xFF8B4513); // Brown
  static const Color lightBrown = Color(0xFFD2B48C); // Light Brown
  static const Color background = Color(0xFFFAFAFA); // Off-white
  static const Color surface = Colors.white;
  static const Color accent = Color(0xFFA0522D); // Sienna
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF666666);
  static const Color error = Color(0xFFE53E3E);
  static const Color success = Color(0xFF38A169);
  
  static const Map<int, Color> brownSwatch = {
    50: Color(0xFFFAF5F0),
    100: Color(0xFFF5EBE0),
    200: Color(0xFFE6D3C7),
    300: Color(0xFFD7BBAE),
    400: Color(0xFFC8A395),
    500: Color(0xFF8B4513),
    600: Color(0xFF7A3D11),
    700: Color(0xFF69350F),
    800: Color(0xFF582D0D),
    900: Color(0xFF47250B),
  };
}

// lib/services/service_locator.dart
import 'package:get_it/get_it.dart';
import 'auth_service.dart';
import 'organization_service.dart';
import 'brand_service.dart';
import 'influencer_service.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<OrganizationService>(() => OrganizationService());
  getIt.registerLazySingleton<BrandService>(() => BrandService());
  getIt.registerLazySingleton<InfluencerService>(() => InfluencerService());
}

// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  
  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }
  
  Future<String?> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }
  
  Future<void> storeTokens(String accessToken, String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
  }
  
  Future<void> clearTokens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }
  
  Future<Map<String, String>> getHeaders() async {
    String? token = await getAccessToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
  
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
      return false;
    }
  }
  
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
    
    if (response.statusCode == 401) {
      bool refreshed = await refreshToken();
      if (refreshed) {
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

// lib/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class AuthService extends ApiService {
  
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    required String password2,
    required String userType,
    String? firstName,
    String? lastName,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
          'password2': password2,
          'user_type': userType,
          'first_name': firstName ?? '',
          'last_name': lastName ?? '',
        }),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 201) {
        await storeTokens(
          data['tokens']['access'],
          data['tokens']['refresh'],
        );
      }
      
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
  
  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        await storeTokens(data['access'], data['refresh']);
      }
      
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
  
  Future<Map<String, dynamic>> logout() async {
    try {
      String? refreshToken = await getRefreshToken();
      
      final response = await makeAuthenticatedRequest(
        'POST',
        '/auth/logout/',
        body: {'refresh_token': refreshToken},
      );
      
      await clearTokens();
      
      return {
        'success': true,
        'message': 'Logged out successfully',
      };
    } catch (e) {
      await clearTokens();
      return {
        'success': true,
        'message': 'Logged out locally',
      };
    }
  }
  
  Future<bool> isLoggedIn() async {
    String? token = await getAccessToken();
    return token != null;
  }
}

// lib/services/organization_service.dart
import 'dart:convert';
import 'api_service.dart';

class OrganizationService extends ApiService {
  
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
}

// lib/services/influencer_service.dart
import 'dart:convert';
import 'api_service.dart';

class InfluencerService extends ApiService {
  
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

// lib/services/brand_service.dart
import 'dart:convert';
import 'api_service.dart';

class BrandService extends ApiService {
  
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
}