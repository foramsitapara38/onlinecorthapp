import 'package:flutter/material.dart';

/// How a product or category is pictured.
///
/// When [imageUrl] is filled in the photo is downloaded from the internet.
/// When it is null we draw a soft gradient with a clothing icon instead, so
/// the app never shows a broken or empty box.
class ItemImage {
  const ItemImage({
    this.imageUrl,
    required this.icon,
    required this.gradient,
  });

  final String? imageUrl;
  final IconData icon;
  final List<Color> gradient;
}

/// Anything that can be shown in a card (a category or a product).
abstract class ShopItem {
  const ShopItem({
    required this.id,
    required this.name,
    required this.picture,
  });

  final String id;
  final String name;
  final ItemImage picture;
}

/// One of the four sections on the home page: Dresses, Tops, Western, Saree.
class ShopCategory extends ShopItem {
  const ShopCategory({
    required super.id,
    required super.name,
    required super.picture,
    this.tagline = '',
  });

  final String tagline;
}

/// A single item that can be bought.
class Product extends ShopItem {
  const Product({
    required super.id,
    required super.name,
    required super.picture,
    required this.categoryId,
    required this.price,
    required this.description,
    this.oldPrice,
  });

  final String categoryId;
  final int price;
  final int? oldPrice;
  final String description;
}

/// 2999 -> "2,999" and 12999 -> "12,999" (Indian number grouping).
String grouped(int amount) {
  final digits = amount.toString();
  if (digits.length <= 3) return digits;

  final lastThree = digits.substring(digits.length - 3);
  final rest = digits.substring(0, digits.length - 3);
  final head = rest.replaceAll(RegExp(r'\B(?=(\d{2})+(?!\d))'), ',');
  return '$head,$lastThree';
}

/// "₹2,999" - used everywhere a price is displayed.
String rupees(int amount) => '₹${grouped(amount)}';

const List<ShopCategory> shopCategories = [
  ShopCategory(
    id: 'dresses',
    name: 'Dresses',
    tagline: 'Party & festive',
    picture: ItemImage(
      icon: Icons.checkroom,
      gradient: [Color(0xFFF7C8D8), Color(0xFFE27BA6)],
    ),
  ),
  ShopCategory(
    id: 'tops',
    name: 'Tops',
    tagline: 'Everyday picks',
    picture: ItemImage(
      icon: Icons.dry_cleaning,
      gradient: [Color(0xFFD9CDF3), Color(0xFF9B7BE0)],
    ),
  ),
  ShopCategory(
    id: 'western',
    name: 'Western',
    tagline: 'Jeans, shirts & more',
    picture: ItemImage(
      icon: Icons.local_mall,
      gradient: [Color(0xFFCBE1F7), Color(0xFF7FA9E8)],
    ),
  ),
  ShopCategory(
    id: 'saree',
    name: 'Saree',
    tagline: 'Silk & cotton',
    picture: ItemImage(
      icon: Icons.diamond,
      gradient: [Color(0xFFC6EEDD), Color(0xFF5CBFA0)],
    ),
  ),
];

const List<Product> shopProducts = [
  Product(
    id: 'p1',
    name: 'Royal Floral Dress',
    categoryId: 'dresses',
    price: 2999,
    oldPrice: 3999,
    description:
        'A flowy floral midi with a fitted waist - made for dinners and festive evenings.',
    picture: ItemImage(
      icon: Icons.checkroom,
      gradient: [Color(0xFFF9D2DE), Color(0xFFE27BA6)],
    ),
  ),
  Product(
    id: 'p2',
    name: 'White Puff Top',
    categoryId: 'tops',
    price: 799,
    oldPrice: 999,
    description:
        'Soft cotton top with puff sleeves. Pairs with jeans, skirts and sarees alike.',
    picture: ItemImage(
      icon: Icons.dry_cleaning,
      gradient: [Color(0xFFEDEAF7), Color(0xFFB9A7E6)],
    ),
  ),
  Product(
    id: 'p3',
    name: 'Denim Jacket',
    categoryId: 'western',
    price: 1499,
    oldPrice: 1999,
    description:
        'Classic light-wash denim jacket with a relaxed fit and metal buttons.',
    picture: ItemImage(
      icon: Icons.local_mall,
      gradient: [Color(0xFFD3E4F6), Color(0xFF6E9BD8)],
    ),
  ),
  Product(
    id: 'p4',
    name: 'Silk Saree - Emerald',
    categoryId: 'saree',
    price: 3499,
    description:
        'Hand-finished silk saree with a golden border and matching blouse piece.',
    picture: ItemImage(
      icon: Icons.diamond,
      gradient: [Color(0xFFCDEEE0), Color(0xFF48A886)],
    ),
  ),
  Product(
    id: 'p5',
    name: 'Linen Shirt',
    categoryId: 'western',
    price: 1199,
    description: 'Breathable pure linen shirt, cut straight for an easy fit.',
    picture: ItemImage(
      icon: Icons.dry_cleaning,
      gradient: [Color(0xFFF3E7D5), Color(0xFFD2AF7E)],
    ),
  ),
  Product(
    id: 'p6',
    name: 'Pleated Skirt',
    categoryId: 'western',
    price: 1299,
    oldPrice: 1599,
    description: 'Mid-length pleated skirt that moves beautifully while walking.',
    picture: ItemImage(
      icon: Icons.style,
      gradient: [Color(0xFFFCE3D6), Color(0xFFEFA382)],
    ),
  ),
  Product(
    id: 'p7',
    name: 'Cotton Kurti Top',
    categoryId: 'tops',
    price: 949,
    description: 'Everyday kurti top in soft cotton with subtle thread work.',
    picture: ItemImage(
      icon: Icons.style,
      gradient: [Color(0xFFD6F0EE), Color(0xFF69B7B1)],
    ),
  ),
  Product(
    id: 'p8',
    name: 'Chiffon Saree - Rose',
    categoryId: 'saree',
    price: 2799,
    oldPrice: 3299,
    description: 'Weightless chiffon saree with a delicate floral print.',
    picture: ItemImage(
      icon: Icons.diamond,
      gradient: [Color(0xFFFADCE6), Color(0xFFE273A0)],
    ),
  ),
  Product(
    id: 'p9',
    name: 'Party Gown',
    categoryId: 'dresses',
    price: 4299,
    description: 'Floor-length gown with a flared hem and a shimmer finish.',
    picture: ItemImage(
      icon: Icons.auto_awesome,
      gradient: [Color(0xFFE5DAF6), Color(0xFF8E6BD6)],
    ),
  ),
  Product(
    id: 'p10',
    name: 'Printed Crop Top',
    categoryId: 'tops',
    price: 649,
    description: 'Fun printed crop top in stretch cotton for casual days out.',
    picture: ItemImage(
      icon: Icons.dry_cleaning,
      gradient: [Color(0xFFFFE7CF), Color(0xFFF2A055)],
    ),
  ),
];
