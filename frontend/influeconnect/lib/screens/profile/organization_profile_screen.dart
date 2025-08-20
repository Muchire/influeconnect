// lib/screens/profile/organization_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/organization_provider.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/loading_button.dart';

class OrganizationProfileScreen extends StatefulWidget {
  @override
  _OrganizationProfileScreenState createState() => _OrganizationProfileScreenState();
}

class _OrganizationProfileScreenState extends State<OrganizationProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();
  final _tiktokController = TextEditingController();
  final _instagramController = TextEditingController();
  final _threadsController = TextEditingController();
  final _xController = TextEditingController();
  final _linkedinController = TextEditingController();
  final _sectorController = TextEditingController();

  String? _selectedSector;
  final List<String> _sectors = [
    'Fashion',
    'Beauty',
    'Technology',
    'Food & Beverage',
    'Travel',
    'Fitness',
    'Lifestyle',
    'Gaming',
    'Education',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _loadOrganizationData();
  }

  void _loadOrganizationData() async {
    final orgProvider = Provider.of<OrganizationProvider>(context, listen: false);
    await orgProvider.loadOrganizationProfile();
    
    if (orgProvider.organization != null) {
      final org = orgProvider.organization!;
      _nameController.text = org['name'] ?? '';
      _phoneController.text = org['phone_number'] ?? '';
      _countryController.text = org['country'] ?? '';
      _tiktokController.text = org['social_tiktok'] ?? '';
      _instagramController.text = org['social_instagram'] ?? '';
      _threadsController.text = org['social_threads'] ?? '';
      _xController.text = org['social_x'] ?? '';
      _linkedinController.text = org['social_linkedin'] ?? '';
      _sectorController.text = org['sector'] ?? '';
      _selectedSector = org['sector'];
    }
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final orgProvider = Provider.of<OrganizationProvider>(context, listen: false);
      
      final success = await orgProvider.createOrganization(
        name: _nameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        country: _countryController.text.trim(),
        socialTiktok: _tiktokController.text.trim(),
        socialInstagram: _instagramController.text.trim(),
        socialThreads: _threadsController.text.trim(),
        socialX: _xController.text.trim(),
        socialLinkedin: _linkedinController.text.trim(),
        sector: _selectedSector,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile saved successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(orgProvider.errorMessage ?? 'Failed to save profile'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _countryController.dispose();
    _tiktokController.dispose();
    _instagramController.dispose();
    _threadsController.dispose();
    _xController.dispose();
    _linkedinController.dispose();
    _sectorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Organization Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Organization Details',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 20),
              
              CustomTextField(
                controller: _nameController,
                labelText: 'Organization Name *',
                prefixIcon: Icons.business,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter organization name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              
              CustomTextField(
                controller: _phoneController,
                labelText: 'Phone Number',
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              
              CustomTextField(
                controller: _countryController,
                labelText: 'Country',
                prefixIcon: Icons.location_on,
              ),
              SizedBox(height: 16),
              
              // Sector Dropdown
              DropdownButtonFormField<String>(
                value: _selectedSector,
                decoration: InputDecoration(
                  labelText: 'Sector',
                  prefixIcon: Icon(Icons.category),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: _sectors.map((sector) {
                  return DropdownMenuItem(
                    value: sector,
                    child: Text(sector),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSector = value;
                  });
                },
              ),
              SizedBox(height: 24),
              
              Text(
                'Social Media Links',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 16),
              
              CustomTextField(
                controller: _instagramController,
                labelText: 'Instagram',
                prefixIcon: Icons.camera_alt,
              ),
              SizedBox(height: 12),
              
              CustomTextField(
                controller: _tiktokController,
                labelText: 'TikTok',
                prefixIcon: Icons.videocam,
              ),
              SizedBox(height: 12),
              
              CustomTextField(
                controller: _threadsController,
                labelText: 'Threads',
                prefixIcon: Icons.chat,
              ),
              SizedBox(height: 12),
              
              CustomTextField(
                controller: _xController,
                labelText: 'X (Twitter)',
                prefixIcon: Icons.comment,
              ),
              SizedBox(height: 12),
              
              CustomTextField(
                controller: _linkedinController,
                labelText: 'LinkedIn',
                prefixIcon: Icons.business_center,
              ),
              SizedBox(height: 30),
              
              Consumer<OrganizationProvider>(
                builder: (context, orgProvider, child) {
                  return LoadingButton.fullWidth(
                    onPressed: _saveProfile,
                    isLoading: orgProvider.isLoading,
                    child: Text(
                      'Save Profile',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}