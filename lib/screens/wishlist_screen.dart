import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../state/shop_store.dart';
import '../widgets/luxe_header.dart';
import '../widgets/product_card.dart';

/// First bottom tab: everything the user tapped the heart on.
///
/// Layout matches the design: LUXE + X on top, then a back arrow with the
/// centred "Wishlist" title, then a two column grid of saved products.
class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  /// X closes the shop, exactly like on the home page.
  void _closeShop(BuildContext context) {
    activeTab.value = 0;
    Navigator.of(context).pushReplacementNamed('/login');
  }

  /// Back arrow returns to the Shop tab.
  void _goBack() {
    activeTab.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    final store = ShopStore.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LuxeHeader(onClose: () => _closeShop(context)),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 20, 16),
          child: Row(
            children: [
              IconButton(
                onPressed: _goBack,
                icon: const Icon(Icons.arrow_back),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'Wishlist',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: kInk,
                    ),
                  ),
                ),
              ),
              // Same width as the arrow, so the title stays truly centred.
              const SizedBox(width: 48),
            ],
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
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (_, index) => ProductCard(
                  product: liked[index],
                  heart: HeartPlacement.besideName,
                  priceColor: kInk, // black price, as in the design
                  showOldPrice: false,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
