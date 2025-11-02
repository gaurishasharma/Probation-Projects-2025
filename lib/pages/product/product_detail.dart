import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import '../cart/cart.dart';
import 'product_grid.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {


  int _selectedColorIndex = 0; 
  String _selectedSize = 'M'; 
  bool _isDescriptionExpanded = true;
  bool _isReviewsExpanded = true;
  bool _isSimilarExpanded = true;


  final List<Color> _colors = [
    const Color(0xFFF5E3D3), 
    const Color(0xFF2C2C2C), 
    const Color(0xFFE34343),
  ];

  final List<String> _sizes = ['S', 'M', 'L'];


  final List<Product> _similarProducts = [
    Product(id: 9, title: 'Rise Crop Hoodie', imageUrl: 'assets/images/card1.png', price: 48.00, oldPrice: null, rating: 4.5, reviewCount: 30),
    Product(id: 10, title: 'Clynx Crop Top', imageUrl: 'assets/images/card2.png', price: 39.99, oldPrice: null, rating: 4.2, reviewCount: 22),
    Product(id: 11, title: 'Sport Jacket', imageUrl: 'assets/images/card3.png', price: 67.00, oldPrice: null, rating: 4.6, reviewCount: 45),
  ];

  @override
  Widget build(BuildContext context) {

    final wishlist = context.watch<WishlistProvider>();
    final bool isLiked = wishlist.isLiked(widget.product.id);

    return Scaffold(
      bottomNavigationBar: _buildBottomAppBar(context),
      body: CustomScrollView(
        slivers: [
         
          SliverAppBar(
            pinned: true, 
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
            
              IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.black,
                  size: 24,
                ),
                onPressed: () {
                  
                  context
                      .read<WishlistProvider>()
                      .toggleWishlist(widget.product.id);
                },
              ),
              
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, size: 24),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
              ),
            ],
          ),

      
          SliverList(
            delegate: SliverChildListDelegate(
              [
                
                Container(
                  height: 300,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0), 
                    child: Image.asset(
                      widget.product.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (ctx, err, stack) =>
                          const Icon(Icons.broken_image, size: 40),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

              
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                          
                                Text(
                                  widget.product.title,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                        
                                _buildRatingRow(
                                  widget.product.rating.toString(),
                                  "(${widget.product.reviewCount})",
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                
                          Text(
                            "\$ ${widget.product.price.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                    
                      Row(
                        children: [
                          // Color
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Color', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 8),
                                Row(
                                  children: List.generate(_colors.length, (index) {
                                    return _buildColorSwatch(index);
                                  }),
                                ),
                              ],
                            ),
                          ),
                          // Size
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Size', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 8),
                                Row(
                                  children: List.generate(_sizes.length, (index) {
                                    return _buildSizeChip(_sizes[index]);
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Divider(color: Colors.grey[200]),

                    
                      _buildCollapsibleSection(
                        title: 'Description',
                        isExpanded: _isDescriptionExpanded,
                        onToggle: () {
                          setState(() { _isDescriptionExpanded = !_isDescriptionExpanded; });
                        },
                        content: Text(
                          'Sportswear is no longer under culture, it is no longer indie or cobbled together as it once was. Also, just because it’s a set doesn’t mean it’ll fit and style. Just need to size down. Read more',
                          style: TextStyle(color: Colors.grey[700], height: 1.5),
                        ),
                      ),
                      Divider(color: Colors.grey[200]),

                    
                      _buildCollapsibleSection(
                        title: 'Reviews',
                        isExpanded: _isReviewsExpanded,
                        onToggle: () {
                          setState(() { _isReviewsExpanded = !_isReviewsExpanded; });
                        },
                        content: _buildReviewsContent(),
                      ),
                      Divider(color: Colors.grey[200]),

                      
                      _buildCollapsibleSection(
                        title: 'Similar Product',
                        isExpanded: _isSimilarExpanded,
                        onToggle: () {
                          setState(() { _isSimilarExpanded = !_isSimilarExpanded; });
                        },
                        content: _buildSimilarProductsList(),
                      ),
                      const SizedBox(height: 100), 
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }




  Widget _buildBottomAppBar(BuildContext context) {
    return Container(
    
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      
      color: Theme.of(context).scaffoldBackgroundColor.withAlpha(240),
      child: FilledButton.icon(
        icon: const Icon(Icons.shopping_bag_outlined, size: 20),
        label: const Text(
          'Add To Cart',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
    
        onPressed: () {
       
          final cart = context.read<CartProvider>();
          
     
          final selectedColor = _colors[_selectedColorIndex];
          final selectedSize = _selectedSize;
      
          cart.addItem(widget.product, selectedSize, selectedColor);

 
          ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hide old ones
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green[700],
              content: Text('${widget.product.title} added to cart!'),
              duration: const Duration(seconds: 2),
              action: SnackBarAction(
                label: 'VIEW CART',
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
              ),
            ),
          );
        },
        style: FilledButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }

  Widget _buildCollapsibleSection({
    required String title,
    required Widget content,
    required bool isExpanded,
    required VoidCallback onToggle,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onToggle,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        ),
 
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: ConstrainedBox(
            constraints: BoxConstraints(
        
              maxHeight: isExpanded ? double.infinity : 0,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: content,
            ),
          ),
        ),
      ],
    );
  }

 
  Widget _buildSimilarProductsList() {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _similarProducts.length,
        itemBuilder: (context, index) {
          final product = _similarProducts[index];
         
          return Container(
            width: 130, 
            margin: const EdgeInsets.only(right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    width: 130,
                    height: 130,
                    errorBuilder: (ctx, err, stack) =>
                        const Icon(Icons.broken_image),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$ ${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildReviewsContent() {
    return Column(
      children: [
   
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '4.9',
              style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'out of 5',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                _buildRatingRow("4.9", "(462 reviews)"),
              ],
            )
          ],
        ),
        const SizedBox(height: 16),
        _buildRatingBar('5', 380, 462),
        _buildRatingBar('4', 60, 462),
        _buildRatingBar('3', 12, 462),
        _buildRatingBar('2', 5, 462),
        _buildRatingBar('1', 5, 462),
        const SizedBox(height: 16),

        _buildSingleReview('Jennifer Rose', '5 days ago', 'I love it, no notes! Never worried. Helped me out with adding an additional item to my order. Thanks'),
        _buildSingleReview('Kelly Rihona', '7 days ago', 'I’m very happy with my order, it was delivered on and good quality. Recommended'),
      ],
    );
  }

  Widget _buildSingleReview(String name, String date, String review) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
              
                backgroundColor: Colors.grey,
                radius: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    _buildRatingRow("5.0", ""), // Static 5 stars
                  ],
                ),
              ),
              Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review,
            style: const TextStyle(color: Colors.black87, height: 1.4),
          ),
        ],
      ),
    );
  }


  Widget _buildRatingBar(String star, int count, int total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Row(
            children: [
              Text(star, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const Icon(Icons.star, color: Colors.grey, size: 14),
            ],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: count / total,
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                minHeight: 8,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(count.toString(), style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildRatingRow(String rating, String count) {
 
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 16),
        const Icon(Icons.star, color: Colors.amber, size: 16),
        const Icon(Icons.star, color: Colors.amber, size: 16),
        const Icon(Icons.star, color: Colors.amber, size: 16),
        const Icon(Icons.star_half, color: Colors.amber, size: 16),
        const SizedBox(width: 8),
        Text(
          '$rating $count',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

 
  Widget _buildColorSwatch(int index) {
    final color = _colors[index];
    final bool isSelected = _selectedColorIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() { _selectedColorIndex = index; });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8.0),
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
          ),
        
          boxShadow: isSelected ? [
            BoxShadow(
              color: color,
              blurRadius: 3,
              spreadRadius: 3,
            )
          ] : [],
        ),
      ),
    );
  }

 
  Widget _buildSizeChip(String size) {
    final bool isSelected = _selectedSize == size;
    return GestureDetector(
      onTap: () {
        setState(() { _selectedSize = size; });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8.0),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Center(
          child: Text(
            size,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}