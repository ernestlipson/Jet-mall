import 'package:flutter/material.dart';

/// Settings page for account and app settings
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader(context, 'Account'),
          _buildListItem(
            icon: Icons.person_outline,
            title: 'Personal Information',
            onTap: () {},
          ),
          _buildListItem(
            icon: Icons.favorite_border,
            title: 'My Favorites',
            onTap: () {},
          ),
          _buildListItem(
            icon: Icons.location_on_outlined,
            title: 'Shipping Addresses',
            onTap: () {},
          ),
          _buildDivider(),
          _buildSectionHeader(context, 'App Settings'),
          _buildListItem(
            icon: Icons.notifications_none,
            title: 'Notifications',
            onTap: () {},
          ),
          _buildListItem(
            icon: Icons.language,
            title: 'Language',
            subtitle: 'English',
            onTap: () {},
          ),
          _buildListItem(
            icon: Icons.color_lens_outlined,
            title: 'Theme',
            subtitle: 'Light',
            onTap: () {},
          ),
          _buildDivider(),
          _buildSectionHeader(context, 'More'),
          _buildListItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {},
          ),
          _buildListItem(
            icon: Icons.info_outline,
            title: 'About',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 40,
      thickness: 1,
    );
  }
}
