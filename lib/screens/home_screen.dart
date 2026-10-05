import 'package:flutter/material.dart';

import '../state/shop_store.dart';
import '../widgets/shop_nav_bar.dart';
import 'bag_screen.dart';
import 'categories_screen.dart';
import 'profile_screen.dart';
import 'shop_page.dart';
import 'wishlist_screen.dart';

/// Bottom-navigation shell for the shop.
///
/// It keeps the five pages alive and swaps between them, so tapping a bottom
/// icon (or a button inside another page) opens the right page instantly.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// 0 Shop, 1 Wishlist, 2 Categories, 3 Bag, 4 Profile.
  static const List<Widget> _pages = [
    ShopPage(),
    WishlistScreen(),
    CategoriesScreen(),
    BagScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: activeTab,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: IndexedStack(index: activeTab.value, children: _pages),
          ),
          bottomNavigationBar: ShopNavBar(
            current: activeTab.value,
            onSelect: (index) => activeTab.value = index,
          ),
        );
      },
    );
  }
}
