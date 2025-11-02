import 'package:flutter/material.dart';
import '../search/filter_tf.dart';
import '../product/product_detail.dart';

// --- 1. YOUR PRODUCT MODEL (Unchanged) ---
class Product {
  final int id;
  final String title;
  final String imageUrl;
  final double price;
  final double? oldPrice;
  final double rating;
  final int reviewCount;

  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.oldPrice,
    required this.rating,
    required this.reviewCount,
  });
}

// --- 2. YOUR PRODUCT GRID SCREEN (With navigation added) ---
class ProductGridScreen extends StatefulWidget {
  final String category;

  const ProductGridScreen({super.key, required this.category});

  @override
  State<ProductGridScreen> createState() => _ProductGridScreenState();
}

class _ProductGridScreenState extends State<ProductGridScreen> {
  // Your existing product list (make sure 'assets/images/...' are in your pubspec.yaml)
  final List<Product> _products = [
    Product(id: 1, title: 'Linen Dress', imageUrl: 'assets/images/card1.png', price: 52.00, oldPrice: 60.00, rating: 4.5, reviewCount: 46),
    Product(id: 2, title: 'Fitted Waist Dress', imageUrl: 'assets/images/card2.png', price: 47.99, rating: 4.0, reviewCount: 62),
    Product(id: 3, title: 'Maxi Dress', imageUrl: 'assets/images/card3.png', price: 68.00, rating: 4.8, reviewCount: 96),
    Product(id: 4, title: 'Front Tie Mini Dress', imageUrl: 'assets/images/card4.png', price: 59.00, rating: 4.2, reviewCount: 20),
    Product(id: 5, title: 'Ohara Dress', imageUrl: 'assets/images/card1.png', price: 85.00, rating: 4.9, reviewCount: 142),
    Product(id: 6, title: 'Tie Back Mini Dress', imageUrl: 'assets/images/card2.png', price: 67.00, rating: 4.6, reviewCount: 38),
    Product(id: 7, title: 'Leaves Gown Dress', imageUrl: 'assets/images/card3.png', price: 64.00, rating: 4.3, reviewCount: 56),
    Product(id: 8, title: 'Off Shoulder Dress', imageUrl: 'assets/images/card4.png', price: 78.99, rating: 4.7, reviewCount: 52),
  ];

  final Set<int> _likedProductIds = {};

  void _toggleLike(int productId) {
    setState(() {
      if (_likedProductIds.contains(productId)) {
        _likedProductIds.remove(productId);
      } else {
        _likedProductIds.add(productId);
      }
    });
  }

  void _openFilter() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const FilterBottomSheet(), // Using placeholder
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.category,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Found\n152 Results',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                GestureDetector(
                  onTap: _openFilter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Filter',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down, color: Colors.grey[700], size: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Product Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 0.65,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                final isLiked = _likedProductIds.contains(product.id);
                
                return GestureDetector(
                  //
                  // *** THIS IS THE NAVIGATION LOGIC ***
                  //
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product: product),
                      ),
                    );
                  },
                  //
                  // *** END OF NAVIGATION LOGIC ***
                  //
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.asset(
                              product.imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200,
                              // Handle image errors gracefully
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 200,
                                  color: Colors.grey[200],
                                  child: Icon(Icons.broken_image, color: Colors.grey[400]),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  isLiked ? Icons.favorite : Icons.favorite_border,
                                  color: isLiked ? Colors.red : Colors.black,
                                  size: 20,
                                ),
                                onPressed: () => _toggleLike(product.id),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '\$ ${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (product.oldPrice != null) ...[
                            const SizedBox(width: 8),
                            Text(
                              '\$ ${product.oldPrice!.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${product.rating} (${product.reviewCount})',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}