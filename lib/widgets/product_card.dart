import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../models/catalog.dart';
import '../state/shop_store.dart';
import 'shop_picture.dart';

/// Where the little heart sits on a product card.
enum HeartPlacement {
  /// Floating on the picture - used by the home grid.
  onPhoto,

  /// Next to the product name - used by the wishlist.
  besideName,
}

/// One product in a grid: picture, wishlist heart, name and price.
/// Tapping anywhere but the heart opens the product page.
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.heart = HeartPlacement.onPhoto,
    this.priceColor = kPrice,
    this.showOldPrice = true,
  });

  final Product product;
  final HeartPlacement heart;

  /// Prices are pink on the shop grids and black on the wishlist.
  final Color priceColor;

  /// The wishlist only shows one clean price.
  final bool showOldPrice;

  void _open(BuildContext context) {
    Navigator.of(context).pushNamed('/product', arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    final nameBesideHeart = heart == HeartPlacement.besideName;

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
                if (!nameBesideHeart)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: _HeartButton(product: product, onPhoto: true),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          if (nameBesideHeart) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Flexible (not Expanded) so the heart stays glued to the
                // name, while long names still fade with an ellipsis.
                Flexible(
                  child: Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: kInk,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                _HeartButton(product: product, onPhoto: false),
              ],
            ),
            const SizedBox(height: 4),
          ] else
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
          Row(
            children: [
              Text(
                rupees(product.price),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: priceColor,
                ),
              ),
              if (showOldPrice && product.oldPrice != null) ...[
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

/// Small heart that adds or removes the product from the wishlist.
/// [onPhoto] gives it the white round background used over pictures.
class _HeartButton extends StatelessWidget {
  const _HeartButton({required this.product, required this.onPhoto});

  final Product product;
  final bool onPhoto;

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
            padding: onPhoto ? const EdgeInsets.all(5) : EdgeInsets.zero,
            decoration: onPhoto
                ? BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.92),
                    shape: BoxShape.circle,
                  )
                : null,
            child: Icon(
              liked ? Icons.favorite : Icons.favorite_border,
              size: onPhoto ? 18 : 19,
              color: liked ? kInk : kMuted,
            ),
          ),
        );
      },
    );
  }
}
