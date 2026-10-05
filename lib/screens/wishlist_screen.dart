import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../state/shop_store.dart';
import '../widgets/luxe_header.dart';
import '../widgets/product_card.dart';

/// First bottom tab: everything the user tapped the heart on.
class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = ShopStore.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LuxeHeader(showClose: false),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 16),
          child: Text(
            'My Wishlist',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: kInk,
            ),
          ),
        ),
        Expanded(
          child: ListenableBuilder(
            listenable: store,
            builder: (context, _) {
              final liked = store.wishlistProducts;
              if (liked.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.favorite_border, size: 54, color: kMuted),
                      SizedBox(height: 12),
                      Text(
                        'No favourites yet.\nTap the ♡ on any product to save it.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: kMuted),
                      ),
                    ],
                  ),
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                itemCount: liked.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.62,
                ),
                itemBuilder: (_, index) => ProductCard(product: liked[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
