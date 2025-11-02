import 'package:flutter/material.dart';
import 'dart:collection';
import '../product/product_grid.dart'; // Adjust path
import '../cart/cart_item.dart'; // Adjust path

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  UnmodifiableMapView<String, CartItem> get items => UnmodifiableMapView(_items);

  // --- 1. GETTERS (Moved from your screen) ---

  // Calculates the subtotal of *selected* items
  double get subtotal {
    double subtotal = 0.0;
    _items.forEach((key, cartItem) {
      if (cartItem.isSelected) {
        subtotal += cartItem.totalPrice;
      }
    });
    return subtotal;
  }

  // Calculates the final total
  double get total {
    double shipping = 0.0; // "Freeship"
    return subtotal + shipping;
  }

  // Gets the total number of items
  int get itemCount {
    int count = 0;
    _items.forEach((key, cartItem) {
      count += cartItem.quantity;
    });
    return count;
  }

  // --- 2. METHODS (Moved from your screen) ---

  void addItem(Product product, String size, Color color) {
    final String id = '${product.id}_${size}_${color.value}';

    if (_items.containsKey(id)) {
      _items.update(id, (existingItem) {
        existingItem.increment();
        return existingItem;
      });
    } else {
      _items.putIfAbsent(
        id,
        () => CartItem(
          id: id,
          product: product,
          selectedSize: size,
          selectedColor: color,
        ),
      );
    }
    notifyListeners();
  }

  // New method for the '+' button
  void incrementItem(String id) {
    if (_items.containsKey(id)) {
      _items[id]!.increment();
      notifyListeners();
    }
  }

  // New method for the '-' button
  void decrementItem(String id) {
    if (_items.containsKey(id)) {
      _items[id]!.decrement();
      notifyListeners();
    }
  }

  // New method for the checkbox
  void toggleItemSelection(String id) {
    if (_items.containsKey(id)) {
      _items[id]!.isSelected = !_items[id]!.isSelected;
      notifyListeners();
    }
  }

  // New method to completely remove an item
  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }
}