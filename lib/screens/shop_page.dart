import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../models/catalog.dart';
import '../state/shop_store.dart';
import '../widgets/luxe_header.dart';
import '../widgets/product_card.dart';
import '../widgets/shop_picture.dart';

/// The page shown in the design: greeting, categories, offer banner and the
/// product grid. (The search bar was removed on purpose.)
class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  void _closeShop(BuildContext context) {
    activeTab.value = 0; // start on the Shop tab next time
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LuxeHeader(onClose: () => _closeShop(context)),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 6, 20, 20),
            children: [
              const Text(
                'Hello,beautiful!!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: kInk,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Find Your Perfect Style',
                style: TextStyle(fontSize: 16, color: kMuted),
              ),
              const SizedBox(height: 24),

              // ---- Categories row ----
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: kInk,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: shopCategories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (_, index) =>
                      CategoryTile(category: shopCategories[index]),
                ),
              ),
              const SizedBox(height: 22),

              // ---- Offer banner ----
              const OfferBanner(),
              const SizedBox(height: 24),

              // ---- Product grid ----
              const Text(
                'Just For You',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: kInk,
                ),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: shopProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.62,
                ),
                itemBuilder: (_, index) =>
                    ProductCard(product: shopProducts[index]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Picture + label for one category. Opens that category's product list.
class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, required this.category, this.width = 76});

  final ShopCategory category;
  final double width;

  void _open(BuildContext context) {
    Navigator.of(context).pushNamed('/category', arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => _open(context),
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                width: width,
                child: ShopPicture(
                  picture: category.picture,
                  radius: 10,
                  iconSize: 28,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: kInk,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Big "sale" strip between the categories and the products.
class OfferBanner extends StatelessWidget {
  const OfferBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF3E4F7), Color(0xFFD4C3DC), Color(0xFFF7D9C8)],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'FESTIVE SALE',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                    color: kInk,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Up to 50% OFF',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: kInk,
                  ),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () => activeTab.value = 2, // open Categories tab
                  style: FilledButton.styleFrom(
                    backgroundColor: kInk,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'Shop Now',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const SizedBox(
            width: 92,
            child: Icon(
              Icons.checkroom,
              size: 72,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
