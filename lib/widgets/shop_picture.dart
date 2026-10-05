import 'package:flutter/material.dart';

import '../models/catalog.dart';

/// Draws the picture of a product or category.
///
/// Uses the photo when [ItemImage.imageUrl] exists, otherwise falls back to a
/// gradient tile with a clothing icon so the layout always looks finished.
class ShopPicture extends StatelessWidget {
  const ShopPicture({
    super.key,
    required this.picture,
    this.radius = 10,
    this.iconSize = 34,
  });

  final ItemImage picture;
  final double radius;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final url = picture.imageUrl;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: picture.gradient,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: (url == null || url.isEmpty)
          ? Center(
              child: Icon(
                picture.icon,
                size: iconSize,
                color: Colors.white.withValues(alpha: 0.92),
              ),
            )
          : Image.network(
              url,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stack) => Center(
                child: Icon(
                  picture.icon,
                  size: iconSize,
                  color: Colors.white.withValues(alpha: 0.92),
                ),
              ),
            ),
    );
  }
}
