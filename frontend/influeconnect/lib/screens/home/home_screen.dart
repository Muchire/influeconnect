import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/auth_provider.dart';
import '../../utils/app_colors.dart';
import '../../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('InflueConnect'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (value) async {
              if (value == 'logout') {
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                await authProvider.logout();
                context.go('/user-type');
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'profile',
                child: Text('Profile'),
              ),
              PopupMenuItem(
                value: 'settings',
                child: Text('Settings'),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _DashboardTab(),
          _DiscoveryTab(),
          _CampaignsTab(),
          _ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class _DashboardTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _WelcomeCard(),
          SizedBox(height: 20),
          _QuickStatsCard(),
          SizedBox(height: 20),
          _RecentActivityCard(),
        ],
      ),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.accent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back!',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Ready to create amazing collaborations?',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickStatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Stats',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatItem(
                    icon: Icons.campaign,
                    label: 'Campaigns',
                    value: '0',
                    color: AppColors.primary,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    icon: Icons.people,
                    label: 'Connections',
                    value: '0',
                    color: AppColors.accent,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    icon: Icons.trending_up,
                    label: 'Success Rate',
                    value: '0%',
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _RecentActivityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activity',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 16),
            _ActivityItem(
              icon: Icons.add_circle_outline,
              title: 'Account Created',
              subtitle: 'Welcome to InflueConnect!',
              time: 'Just now',
            ),
            SizedBox(height: 12),
            _ActivityItem(
              icon: Icons.check_circle_outline,
              title: 'Profile Setup',
              subtitle: 'Complete your profile to get started',
              time: 'Pending',
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;

  const _ActivityItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _DiscoveryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Discovery Tab - Coming Soon',
        style: GoogleFonts.poppins(
          fontSize: 18,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _CampaignsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Campaigns Tab - Coming Soon',
        style: GoogleFonts.poppins(
          fontSize: 18,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile Tab - Coming Soon',
        style: GoogleFonts.poppins(
          fontSize: 18,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}