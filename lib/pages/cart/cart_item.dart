import 'package:flutter/material.dart';
import '../product/product_grid.dart';

class CartItem {
  final String id; 
  final Product product;
  final String selectedSize;
  final Color selectedColor;
  int quantity;
  bool isSelected; 

  CartItem({
    required this.id,
    required this.product,
    required this.selectedSize,
    required this.selectedColor,
    this.quantity = 1,
    this.isSelected = true, 
  });

 
  void increment() {
    quantity++;
  }

  void decrement() {
    if (quantity > 1) {
      quantity--;
    }
  }

  double get totalPrice => product.price * quantity;
}