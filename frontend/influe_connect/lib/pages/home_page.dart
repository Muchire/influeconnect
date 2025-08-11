import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/theme/app_theme.dart';
import '/widgets/feature_card.dart';
import '/pages/influencer/dashboard_page.dart';
import '/pages/influencer/influencer_portal_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomeContent(),
    const InfluencerDashboardPage(),
    // Add other pages here as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryWhite,
      appBar: AppBar(
        title: Text('InfluencerConnect',
            style: GoogleFonts.lora(
              color: AppTheme.accentBrown,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: AppTheme.primaryWhite,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppTheme.accentBrown),
      ),
      drawer: _buildDrawer(context),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppTheme.accentBrown,
        unselectedItemColor: AppTheme.lightBrown,
        backgroundColor: AppTheme.primaryWhite,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppTheme.accentBrown.withOpacity(0.1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppTheme.accentBrown,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.people, size: 28, color: AppTheme.primaryWhite),
                ),
                const SizedBox(height: 12),
                Text('InfluencerConnect',
                    style: GoogleFonts.lora(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.accentBrown,
                    )),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.store, color: AppTheme.accentBrown),
            title: Text('Marketplace',
                style: GoogleFonts.lora(color: AppTheme.accentBrown)),
            onTap: () {
              Navigator.pop(context);
              // Add navigation to marketplace
            },
          ),
          ListTile(
            leading: Icon(Icons.business, color: AppTheme.accentBrown),
            title: Text('For Brands',
                style: GoogleFonts.lora(color: AppTheme.accentBrown)),
            onTap: () {
              Navigator.pop(context);
              // Add navigation for brands
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: AppTheme.accentBrown),
            title: Text('For Creators',
                style: GoogleFonts.lora(color: AppTheme.accentBrown)),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 1; // Switch to dashboard
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.school, color: AppTheme.accentBrown),
            title: Text('Learn',
                style: GoogleFonts.lora(color: AppTheme.accentBrown)),
            onTap: () {
              Navigator.pop(context);
              // Add navigation to learn section
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.login, color: AppTheme.accentBrown),
            title: Text('Login',
                style: GoogleFonts.lora(color: AppTheme.accentBrown)),
            onTap: () {
              Navigator.pop(context);
              // Add login navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.person_add, color: AppTheme.accentBrown),
            title: Text('Get Started',
                style: GoogleFonts.lora(color: AppTheme.accentBrown)),
            onTap: () {
              Navigator.pop(context);
              // Add registration navigation
            },
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeroSection(context),
          _buildFeaturesSection(),
          _buildStatsSection(),
          _buildCTASection(context),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.lightBrown.withOpacity(0.1),
            AppTheme.primaryWhite,
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.accentBrown,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text("Kenya's Premier Influencer Platform",
                style: GoogleFonts.lora(
                  color: AppTheme.primaryWhite,
                  fontSize: 14,
                )),
          ),
          const SizedBox(height: 16),
          Text(
            'Bridge the Gap Between Brands & Creators',
            style: GoogleFonts.lora(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppTheme.accentBrown,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Text(
              'InfluencerConnect simplifies influencer marketing with secure payments, verified profiles, and seamless collaboration tools.',
              style: GoogleFonts.lora(
                fontSize: 16,
                color: AppTheme.lightBrown,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      // Replace with BrandPortalPage navigation when created
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const BrandPortalPage()),
                      // );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentBrown,
                    foregroundColor: AppTheme.primaryWhite,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text("I'm a Brand", style: GoogleFonts.lora(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const InfluencerPortalPage()),
                      );
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.accentBrown,
                    side: BorderSide(color: AppTheme.accentBrown),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text("I'm a Creator", style: GoogleFonts.lora(fontSize: 16)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        children: [
          Text(
            'Everything You Need',
            style: GoogleFonts.lora(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.accentBrown,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Innovative solutions for influencer marketing',
            style: GoogleFonts.lora(
              fontSize: 16,
              color: AppTheme.lightBrown,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          // Mobile-optimized feature cards layout
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildCompactFeatureCard(
                      icon: Icons.verified_user,
                      title: 'Verified Profiles',
                      description: 'Authentic engagement metrics',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildCompactFeatureCard(
                      icon: Icons.payment,
                      title: 'Secure Payments',
                      description: 'Escrow system protection',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildCompactFeatureCard(
                      icon: Icons.description,
                      title: 'Smart Contracts',
                      description: 'Digital signing templates',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildCompactFeatureCard(
                      icon: Icons.trending_up,
                      title: 'Analytics',
                      description: 'Real-time tracking',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompactFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.lightBrown.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightBrown.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.accentBrown.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 24,
              color: AppTheme.accentBrown,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.lora(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.accentBrown,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: GoogleFonts.lora(
              fontSize: 12,
              color: AppTheme.lightBrown,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      color: AppTheme.lightBrown.withOpacity(0.1),
      child: Column(
        children: [
          Text(
            "Trusted in Kenya",
            style: GoogleFonts.lora(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.accentBrown,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildStatItem('500+', 'Creators')),
              Expanded(child: _buildStatItem('100+', 'Brands')),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildStatItem('1000+', 'Campaigns')),
              Expanded(child: _buildStatItem('98%', 'Satisfaction')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: GoogleFonts.lora(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.accentBrown,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.lora(
            fontSize: 14,
            color: AppTheme.lightBrown,
          ),
        ),
      ],
    );
  }

  Widget _buildCTASection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        children: [
          Text(
            'Ready to Get Started?',
            style: GoogleFonts.lora(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.accentBrown,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Text(
              'Join brands and creators building authentic partnerships.',
              style: GoogleFonts.lora(
                fontSize: 16,
                color: AppTheme.lightBrown,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InfluencerPortalPage()),
                  );
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentBrown,
                foregroundColor: AppTheme.primaryWhite,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Start Your Journey',
                style: GoogleFonts.lora(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppTheme.lightBrown.withOpacity(0.2))),
        color: AppTheme.primaryWhite,
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            'InfluencerConnect',
            style: GoogleFonts.lora(
              fontWeight: FontWeight.bold,
              color: AppTheme.accentBrown,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Bridging the gap between brands and creators',
            style: GoogleFonts.lora(
              color: AppTheme.lightBrown,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: Text('About Us',
                    style: GoogleFonts.lora(color: AppTheme.lightBrown)),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Contact',
                    style: GoogleFonts.lora(color: AppTheme.lightBrown)),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Privacy',
                    style: GoogleFonts.lora(color: AppTheme.lightBrown)),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Terms',
                    style: GoogleFonts.lora(color: AppTheme.lightBrown)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            '© 2024 InfluencerConnect',
            style: GoogleFonts.lora(
              color: AppTheme.lightBrown,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}