import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart'; // Make sure this path is correct
import '../cart/cart_item.dart'; // Make sure this path is correct
import '../cart/cart_checkout.dart'; // <-- 1. ADD THIS IMPORT

// --- SCREEN WIDGET ---

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // --- 1. READ FROM PROVIDER ---
    final cart = context.watch<CartProvider>();
    final cartItems = cart.items.values.toList(); // Get the list of items

    // --- 2. GET TOTALS FROM PROVIDER ---
    final double productSubtotal = cart.subtotal;
    final double total = cart.total;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () {
            Navigator.of(context).pop(); // Re-enabled this
          },
        ),
        title: const Text(
          'Your Cart',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // --- 3. The List of Cart Items (from Provider) ---
          Expanded(
            child: cartItems.isEmpty
                ? const Center(
                    child: Text(
                      'Your cart is empty.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: cartItems.length,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      // --- 4. CALL PROVIDER METHODS ---
                      return _buildCartItemCard(
                        // Pass context to this helper
                        context,
                        item: item,
                        // Use context.read() inside callbacks
                        onIncrement: () =>
                            context.read<CartProvider>().incrementItem(item.id),
                        onDecrement: () =>
                            context.read<CartProvider>().decrementItem(item.id),
                        onToggle: () => context
                            .read<CartProvider>()
                            .toggleItemSelection(item.id),
                        onRemove: () =>
                            context.read<CartProvider>().removeItem(item.id),
                      );
                    },
                  ),
          ),

          // --- 5. The Summary (from Provider) ---
          if (cartItems.isNotEmpty)
            _buildSummarySection(
              // Pass context to this helper
              context,
              productSubtotal: productSubtotal,
              total: total,
            ),
        ],
      ),
    );
  }

  /// Helper Widget: Builds a single cart item card
  Widget _buildCartItemCard(
    BuildContext context, // Pass context
    {
    required CartItem item,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
    required VoidCallback onToggle,
    required VoidCallback onRemove, // Added for swipe
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      // --- BONUS: Swipe to delete ---
      child: Dismissible(
        key: Key(item.id), // Unique key is important
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => onRemove(),
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20.0),
          decoration: BoxDecoration(
            color: Colors.red[700],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: Card(
          // ... (Your card styling is perfect)
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // --- Image ---
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    // <-- Use Image.asset
                    item.product.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, stack) =>
                        const Icon(Icons.broken_image), // Good practice
                  ),
                ),
                const SizedBox(width: 12),

                // --- Info (Title, Price, etc.) ---
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.product.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$ ${item.totalPrice.toStringAsFixed(2)}', // From CartItem getter
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // --- 6. UPDATED this to use our CartItem model ---
                      Text(
                        'Size: ${item.selectedSize} | Color: ${item.selectedColor.value.toRadixString(16)}', // Example
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // --- Checkbox and Quantity ---
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Checkbox(
                      value: item.isSelected, // From CartItem
                      onChanged: (val) => onToggle(),
                      activeColor: Colors.green[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // --- Quantity Selector ---
                    Container(
                      // ... (Your styling is perfect)
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, size: 14),
                            onPressed: onDecrement,
                            visualDensity: VisualDensity.compact,
                            splashRadius: 16,
                          ),
                          Text(
                            item.quantity.toString(), // From CartItem
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, size: 14),
                            onPressed: onIncrement,
                            visualDensity: VisualDensity.compact,
                            splashRadius: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Helper Widget: Builds the bottom summary section
  Widget _buildSummarySection(
    BuildContext context, // <-- FIX: Pass context
    {
    required double productSubtotal,
    required double total,
  }) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        // FIX: Now context is defined
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(color: Colors.grey[200]!, width: 1.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            // ... (Product price row)
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Product price',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                '\$ ${productSubtotal.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            // ... (Shipping row)
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shipping',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const Text(
                'Freeship',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(),
          ),
          Row(
            // ... (Subtotal row)
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$ ${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            // ... (Checkout button)
            width: double.infinity,
            child: FilledButton(
              // --- 2. ADD NAVIGATION LOGIC ---
              onPressed: () {
                // Only proceed if there are items to check out
                if (total > 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CheckoutScreen(),
                    ),
                  );
                } else {
                  // Optional: Show a message if cart is empty or no items selected
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select an item to checkout.'),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF333333),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              child: const Text(
                'Proceed to checkout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}