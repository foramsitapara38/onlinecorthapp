import 'package:flutter/material.dart';

import '../models/address.dart';
import '../models/catalog.dart';

/// The app's small in-memory "brain": what the user liked and what is in the
/// bag. One shared instance is used by every screen, so tapping a heart on the
/// home page instantly shows up on the wishlist page.
class ShopStore extends ChangeNotifier {
  ShopStore._();

  static final ShopStore instance = ShopStore._();

  final Set<String> _likedIds = <String>{};
  final Map<String, int> _bag = <String, int>{}; // productId -> quantity

  bool isLiked(Product product) => _likedIds.contains(product.id);

  int quantityOf(Product product) => _bag[product.id] ?? 0;

  /// Total number of items in the bag (shown as the badge on the bottom bar).
  int get bagCount => _bag.values.fold(0, (total, qty) => total + qty);

  int get bagTotal =>
      bagProducts.fold(0, (sum, p) => sum + p.price * quantityOf(p));

  List<Product> get wishlistProducts =>
      shopProducts.where(isLiked).toList(growable: false);

  List<Product> get bagProducts => shopProducts
      .where((p) => _bag.containsKey(p.id))
      .toList(growable: false);

  void toggleWishlist(Product product) {
    if (isLiked(product)) {
      _likedIds.remove(product.id);
    } else {
      _likedIds.add(product.id);
    }
    notifyListeners();
  }

  void addToBag(Product product) {
    _bag[product.id] = quantityOf(product) + 1;
    notifyListeners();
  }

  void decreaseQuantity(Product product) {
    final current = quantityOf(product);
    if (current <= 1) {
      _bag.remove(product.id);
    } else {
      _bag[product.id] = current - 1;
    }
    notifyListeners();
  }

  void clearBag() {
    _bag.clear();
    notifyListeners();
  }
}

/// Lets any page ask the home shell to open one of its bottom tabs.
/// 0 = Shop, 1 = Wishlist, 2 = Categories, 3 = Bag, 4 = Profile.
final ValueNotifier<int> activeTab = ValueNotifier<int>(0);

/// The delivery address saved from the Select Address page.
/// null means "we still need an address" - the bag checks this before
/// placing an order.
final ValueNotifier<Address?> savedAddress = ValueNotifier<Address?>(null);
