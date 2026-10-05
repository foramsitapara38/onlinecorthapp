import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../state/shop_store.dart';

/// The colourful bottom bar from the design. Every icon switches the home
/// shell to another page, and the bag icon carries a live item-count badge.
class ShopNavBar extends StatelessWidget {
  const ShopNavBar({super.key, required this.current, required this.onSelect});

  final int current;
  final ValueChanged<int> onSelect;

  static const List<_NavItem> _items = [
    _NavItem(
      label: 'Home',
      color: Color(0xFFF4772E),
      icon: Icons.home_outlined,
      activeIcon: Icons.home_filled,
    ),
    _NavItem(
      label: 'Wishlist',
      color: Color(0xFF8E4EC6),
      icon: Icons.favorite_border,
      activeIcon: Icons.favorite,
    ),
    _NavItem(
      label: 'Categories',
      color: Color(0xFF6D5BD0),
      icon: Icons.grid_view_outlined,
      activeIcon: Icons.grid_view_rounded,
    ),
    _NavItem(
      label: 'Bag',
      color: Color(0xFFE8467C),
      icon: Icons.shopping_bag_outlined,
      activeIcon: Icons.shopping_bag,
    ),
    _NavItem(
      label: 'Profile',
      color: Color(0xFF2F6FED),
      icon: Icons.person_outline,
      activeIcon: Icons.person,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            for (var i = 0; i < _items.length; i++)
              Expanded(
                child: _NavBarButton(
                  item: _items[i],
                  index: i,
                  selected: current == i,
                  onTap: () => onSelect(i),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavBarButton extends StatelessWidget {
  const _NavBarButton({
    required this.item,
    required this.index,
    required this.selected,
    required this.onTap,
  });

  final _NavItem item;
  final int index;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? item.color : item.color.withValues(alpha: 0.45);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  selected ? item.activeIcon : item.icon,
                  size: 24,
                  color: color,
                ),
                if (index == 3) const _BagBadge(),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pink bubble showing how many items are in the bag.
class _BagBadge extends StatelessWidget {
  const _BagBadge();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ShopStore.instance,
      builder: (context, _) {
        final count = ShopStore.instance.bagCount;
        if (count == 0) return const SizedBox.shrink();

        return Positioned(
          right: -8,
          top: -6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              color: kPrice,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$count',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.label,
    required this.color,
    required this.icon,
    required this.activeIcon,
  });

  final String label;
  final Color color;
  final IconData icon;
  final IconData activeIcon;
}
