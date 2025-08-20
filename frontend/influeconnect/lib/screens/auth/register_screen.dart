import 'package:flutter/material.dart';
import 'package:influeconnect/service/service_locator.dart';
import 'package:influeconnect/service/auth_service.dart';
import 'package:influeconnect/utils/app_theme.dart';
import 'package:influeconnect/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final AuthService _authService = getIt<AuthService>();
  
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _selectedUserType = 'influencer';

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: AppTheme.errorRed,
        ),
      );
      return;
    }
    
    setState(() => _isLoading = true);
    
    final result = await _authService.register(
      username: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      password2: _confirmPasswordController.text,
      userType: _selectedUserType,
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
    );
    
    setState(() => _isLoading = false);
    
    if (result['success']) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      String errorMessage = result['data']?['message'] ?? 'Registration failed';
      if (result['data'] is Map && result['data'].containsKey('errors')) {
        errorMessage = result['data']['errors'].values.first.first;
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: AppTheme.errorRed,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              
              // Logo and title
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppTheme.mediumBrown,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.connect_without_contact,
                        size: 40,
                        color: AppTheme.primaryWhite,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Join our community',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Register form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // User type selector
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppTheme.creamWhite,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.lightBrown),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: _selectedUserType,
                        items: const [
                          DropdownMenuItem(
                            value: 'influencer',
                            child: Text('Influencer'),
                          ),
                          DropdownMenuItem(
                            value: 'organization',
                            child: Text('Organization'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedUserType = value!;
                          });
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Name fields
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _firstNameController,
                            labelText: 'First Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomTextField(
                            controller: _lastNameController,
                            labelText: 'Last Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    CustomTextField(
                      controller: _usernameController,
                      labelText: 'Username',
                      prefixIcon: Icons.person,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        if (value.length < 4) {
                          return 'Username must be at least 4 characters';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    CustomTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      prefixIcon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    CustomTextField(
                      controller: _passwordController,
                      labelText: 'Password',
                      prefixIcon: Icons.lock,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    CustomTextField(
                      controller: _confirmPasswordController,
                      labelText: 'Confirm Password',
                      prefixIcon: Icons.lock,
                      obscureText: _obscureConfirmPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Register button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _register,
                        child: _isLoading
                            ? const CircularProgressIndicator(color: AppTheme.primaryWhite)
                            : const Text('Sign Up'),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Login link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(color: AppTheme.textLight),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: AppTheme.mediumBrown,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}