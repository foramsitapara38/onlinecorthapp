import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../models/catalog.dart';
import '../widgets/luxe_header.dart';
import '../widgets/shop_picture.dart';

/// Second bottom tab: every category in one grid. Tapping one opens the list
/// of products inside that category.
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LuxeHeader(showClose: false),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 16),
          child: Text(
            'Categories',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: kInk,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            itemCount: shopCategories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 14,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (_, index) {
              final category = shopCategories[index];
              return InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => Navigator.of(context).pushNamed(
                  '/category',
                  arguments: category,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ShopPicture(
                        picture: category.picture,
                        radius: 12,
                        iconSize: 44,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      category.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: kInk,
                      ),
                    ),
                    Text(
                      category.tagline,
                      style: const TextStyle(fontSize: 12, color: kMuted),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
