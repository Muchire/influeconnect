import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';

class UserTypeSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(height: 60),
              Text(
                'Welcome to InflueConnect',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Choose your account type to get started',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 80),
              Expanded(
                child: Column(
                  children: [
                    _UserTypeCard(
                      title: 'I\'m an Influencer',
                      subtitle: 'Connect with brands and manage collaborations',
                      icon: Icons.star,
                      onTap: () => context.go('/register?type=influencer'),
                    ),
                    SizedBox(height: 24),
                    _UserTypeCard(
                      title: 'I\'m an Organization',
                      subtitle: 'Find influencers and manage campaigns',
                      icon: Icons.business,
                      onTap: () => context.go('/register?type=organisation'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              TextButton(
                onPressed: () => context.go('/login'),
                child: Text(
                  'Already have an account? Sign In',
                  style: GoogleFonts.poppins(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserTypeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _UserTypeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.lightBrown.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    icon,
                    size: 40,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
