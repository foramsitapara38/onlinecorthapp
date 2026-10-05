import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../models/catalog.dart';
import '../state/shop_store.dart';
import 'shop_picture.dart';

/// One product inside a grid: picture, wishlist heart, name and price.
/// Tapping it opens the product page.
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  void _open(BuildContext context) {
    Navigator.of(context).pushNamed('/product', arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => _open(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ShopPicture(picture: product.picture),
                Positioned(top: 6, right: 6, child: _HeartButton(product: product)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: kInk,
            ),
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              Text(
                rupees(product.price),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: kPrice,
                ),
              ),
              if (product.oldPrice != null) ...[
                const SizedBox(width: 6),
                Text(
                  rupees(product.oldPrice!),
                  style: const TextStyle(
                    fontSize: 12,
                    color: kMuted,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

/// Small round heart that adds or removes the product from the wishlist.
class _HeartButton extends StatelessWidget {
  const _HeartButton({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final store = ShopStore.instance;

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final liked = store.isLiked(product);
        return GestureDetector(
          onTap: () => store.toggleWishlist(product),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.white.withValues(alpha: 0.92),
              shape: BoxShape.circle,
            ),
            child: Icon(
              liked ? Icons.favorite : Icons.favorite_border,
              size: 18,
              color: liked ? kPrice : kInk,
            ),
          ),
        );
      },
    );
  }
}
