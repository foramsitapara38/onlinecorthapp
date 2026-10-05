import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../models/catalog.dart';
import '../state/shop_store.dart';
import '../widgets/shop_picture.dart';

/// One product in full: big picture, price, sizes and the Add to Bag button.
/// Reads its product from the '/product' route arguments.
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  static const List<String> _sizes = ['S', 'M', 'L', 'XL'];

  String _size = 'M';

  void _addBag(Product product) {
    final navigator = Navigator.of(context);
    ShopStore.instance.addToBag(product);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: kInk,
          content: Text('${product.name} added to bag'),
          action: SnackBarAction(
            label: 'VIEW BAG',
            textColor: kAccent,
            onPressed: () {
              activeTab.value = 3; // open the Bag tab
              navigator.popUntil((route) => route.isFirst);
            },
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final product = args is Product ? args : shopProducts.first;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back),
                ),
                const Expanded(
                  child: Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: kInk,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 320,
                        width: double.infinity,
                        child: ShopPicture(
                          picture: product.picture,
                          radius: 16,
                          iconSize: 90,
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: ListenableBuilder(
                          listenable: ShopStore.instance,
                          builder: (context, _) {
                            final liked = ShopStore.instance.isLiked(product);
                            return IconButton(
                              onPressed: () =>
                                  ShopStore.instance.toggleWishlist(product),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white.withValues(alpha: 0.92),
                              ),
                              icon: Icon(
                                liked ? Icons.favorite : Icons.favorite_border,
                                color: liked ? kPrice : kInk,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: kInk,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        rupees(product.price),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: kPrice,
                        ),
                      ),
                      if (product.oldPrice != null) ...[
                        const SizedBox(width: 10),
                        Text(
                          rupees(product.oldPrice!),
                          style: const TextStyle(
                            fontSize: 15,
                            color: kMuted,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: kInk,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: kMuted,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Select Size',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: kInk,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      for (final size in _sizes)
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ChoiceChip(
                            label: Text(size),
                            selected: _size == size,
                            onSelected: (_) => setState(() => _size = size),
                            selectedColor: kAccent,
                            backgroundColor: Colors.grey.shade100,
                            side: BorderSide.none,
                            labelStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: _size == size ? kInk : kMuted,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton.icon(
                  onPressed: () => _addBag(product),
                  style: FilledButton.styleFrom(
                    backgroundColor: kAccent,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  icon: const Icon(Icons.shopping_bag_outlined, size: 20),
                  label: const Text(
                    'Add to Bag',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
