import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../models/catalog.dart';
import '../state/shop_store.dart';
import '../widgets/luxe_header.dart';
import '../widgets/shop_picture.dart';

/// Third bottom tab: the shopping bag with quantities and the bill.
class BagScreen extends StatelessWidget {
  const BagScreen({super.key});

  void _checkout(BuildContext context) {
    final store = ShopStore.instance;
    store.clearBag();

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          backgroundColor: kInk,
          content: Text('Order placed! Your style is on the way 🎉'),
        ),
      );
  }

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
            'My Bag',
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
              final items = store.bagProducts;
              if (items.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 54,
                        color: kMuted,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Your bag is empty.',
                        style: TextStyle(fontSize: 15, color: kMuted),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (_, index) =>
                          _BagRow(product: items[index]),
                    ),
                  ),
                  _BillBar(onCheckout: () => _checkout(context)),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

/// One line in the bag: picture, name, price and the -/+ quantity control.
class _BagRow extends StatelessWidget {
  const _BagRow({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final store = ShopStore.instance;

    return Row(
      children: [
        SizedBox(
          width: 64,
          height: 78,
          child: ShopPicture(picture: product.picture, radius: 8, iconSize: 24),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: kInk,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                rupees(product.price),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: kPrice,
                ),
              ),
            ],
          ),
        ),
        ListenableBuilder(
          listenable: store,
          builder: (context, _) {
            final qty = store.quantityOf(product);
            return Row(
              children: [
                _QtyButton(
                  icon: Icons.remove,
                  onTap: () => store.decreaseQuantity(product),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '$qty',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                _QtyButton(
                  icon: Icons.add,
                  onTap: () => store.addToBag(product),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16, color: kInk),
      ),
    );
  }
}

/// Total amount + checkout button at the bottom of the bag.
class _BillBar extends StatelessWidget {
  const _BillBar({required this.onCheckout});

  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    final store = ShopStore.instance;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          return Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(fontSize: 13, color: kMuted),
                    ),
                    Text(
                      rupees(store.bagTotal),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: kInk,
                      ),
                    ),
                  ],
                ),
              ),
              FilledButton(
                onPressed: onCheckout,
                style: FilledButton.styleFrom(
                  backgroundColor: kAccent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
