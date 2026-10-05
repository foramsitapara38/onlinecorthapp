import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../models/catalog.dart';
import '../widgets/product_card.dart';

/// A single category's product list, opened from a category tile.
/// It reads the category that was passed through the '/category' route.
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final category = args is ShopCategory ? args : shopCategories.first;
    final items = shopProducts
        .where((p) => p.categoryId == category.id)
        .toList(growable: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 20, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: Text(
                      category.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: kInk,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Text(
                category.tagline,
                style: const TextStyle(fontSize: 14, color: kMuted),
              ),
            ),
            Expanded(
              child: items.isEmpty
                  ? const _EmptyBox(
                      icon: Icons.checkroom,
                      message: 'Nothing here yet.',
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      itemCount: items.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 18,
                            crossAxisSpacing: 14,
                            childAspectRatio: 0.62,
                          ),
                      itemBuilder: (_, index) =>
                          ProductCard(product: items[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Friendly placeholder used when a page has nothing to show.
class _EmptyBox extends StatelessWidget {
  const _EmptyBox({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 54, color: kMuted),
          const SizedBox(height: 12),
          Text(
            message,
            style: const TextStyle(fontSize: 15, color: kMuted),
          ),
        ],
      ),
    );
  }
}
