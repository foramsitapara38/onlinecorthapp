import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../state/shop_store.dart';
import '../widgets/luxe_header.dart';

/// Last bottom tab: the user's account, short-cuts and the logout button.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _logout(BuildContext context) {
    activeTab.value = 0;
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      children: [
        const LuxeHeader(showClose: false),
        const SizedBox(height: 8),
        const Row(
          children: [
            CircleAvatar(
              radius: 34,
              backgroundColor: kAccent,
              child: Icon(Icons.person, size: 38, color: Colors.white),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Beautiful User',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: kInk,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'hello@luxe.app',
                    style: TextStyle(fontSize: 14, color: kMuted),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        _Shortcut(
          icon: Icons.receipt_long_outlined,
          title: 'My Orders',
          onTap: () {},
        ),
        _Shortcut(
          icon: Icons.favorite_border,
          title: 'Wishlist',
          onTap: () => activeTab.value = 1,
        ),
        _Shortcut(
          icon: Icons.shopping_bag_outlined,
          title: 'My Bag',
          onTap: () => activeTab.value = 3,
        ),
        _Shortcut(
          icon: Icons.grid_view_outlined,
          title: 'Browse Categories',
          onTap: () => activeTab.value = 2,
        ),
        _Shortcut(
          icon: Icons.location_on_outlined,
          title: 'Saved Addresses',
          onTap: () {},
        ),
        _Shortcut(
          icon: Icons.settings_outlined,
          title: 'Settings',
          onTap: () {},
        ),
        const SizedBox(height: 24),
        OutlinedButton.icon(
          onPressed: () => _logout(context),
          style: OutlinedButton.styleFrom(
            foregroundColor: kPrice,
            side: const BorderSide(color: kPrice),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          icon: const Icon(Icons.logout, size: 18),
          label: const Text(
            'Logout',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}

/// One tappable row in the profile list.
class _Shortcut extends StatelessWidget {
  const _Shortcut({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: Icon(icon, color: kInk, size: 22),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: kInk,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: kMuted),
    );
  }
}
