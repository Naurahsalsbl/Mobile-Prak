import 'package:flutter/material.dart';
import 'package:MobilePrak/core/constants/app_constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: AppConstants.gradientBlue,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.3),
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: const Icon(Icons.person, color: Colors.white, size: 50),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Admin D4TI',
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Administrator',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  _buildInfoCard(context),
                  const SizedBox(height: 16),
                  _buildMenuCard(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.blue.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Informasi Akun', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _profileItem(Icons.email_outlined, 'Email', 'admin@d4ti.ac.id'),
          const Divider(height: 24),
          _profileItem(Icons.phone_outlined, 'Telepon', '+62 812-3456-7890'),
          const Divider(height: 24),
          _profileItem(Icons.location_on_outlined, 'Alamat', 'Kampus D4TI, Surabaya'),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.blue.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          _menuItem(Icons.settings_outlined, 'Pengaturan', Colors.blue),
          const Divider(height: 1),
          _menuItem(Icons.lock_outline, 'Ubah Password', Colors.orange),
          const Divider(height: 1),
          _menuItem(Icons.help_outline, 'Bantuan', Colors.green),
          const Divider(height: 1),
          _menuItem(Icons.logout, 'Keluar', Colors.red),
        ],
      ),
    );
  }

  Widget _profileItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue, size: 20),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }

  Widget _menuItem(IconData icon, String title, Color color) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
      onTap: () {},
    );
  }
}