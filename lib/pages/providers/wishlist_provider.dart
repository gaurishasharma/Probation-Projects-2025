import 'package:flutter/material.dart';
import 'dart:collection'; // For UnmodifiableSetView

class WishlistProvider with ChangeNotifier {
  // Use a Set to store the IDs.
  // A Set is fast for checking if an item already exists.
  final Set<int> _wishlistProductIds = {};

  // Public getter to view the set of liked IDs
  UnmodifiableSetView<int> get items => UnmodifiableSetView(_wishlistProductIds);

  // Helper method to quickly check if a product is in the wishlist
  bool isLiked(int productId) {
    return _wishlistProductIds.contains(productId);
  }

  // The main logic: add or remove a product ID
  void toggleWishlist(int productId) {
    if (_wishlistProductIds.contains(productId)) {
      _wishlistProductIds.remove(productId);
    } else {
      _wishlistProductIds.add(productId);
    }
    
    // This is the most important part!
    // It tells all listening widgets (like your detail screen) to rebuild.
    notifyListeners();
  }
}