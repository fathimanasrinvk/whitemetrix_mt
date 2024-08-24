import 'package:flutter/material.dart';
import '../../../model/product_model.dart';
class ProductProvider extends ChangeNotifier {
  List<Product> _products = [
    Product(id: '1', name: 'Dreamstick Cream Blush', price: 29.99, imageUrl: 'assets/images/pr1.png', description: 'DreamStick™️ - a clean lightweight, cream bronzing multi-stick formulated with skin-loving ingredients, designed for an all-over, sun-kissed bronzed glow. Available in two shades.'),
    Product(id: '2', name: 'Product 2', price: 49.99, imageUrl: 'assets/images/pr2.png', description: ''),
    Product(id: '3', name: 'Product 3', price: 19.99, imageUrl: 'assets/images/pr3.png', description: ''),
    Product(id: '1', name: 'Product 1', price: 29.99, imageUrl: 'assets/images/pr1.png', description: ''),
    Product(id: '2', name: 'Product 2', price: 49.99, imageUrl: 'assets/images/pr2.png', description: ''),
    Product(id: '3', name: 'Product 3', price: 19.99, imageUrl: 'assets/images/pr3.png', description: ''),
    Product(id: '1', name: 'Product 1', price: 29.99, imageUrl: 'assets/images/pr1.png', description: ''),
    Product(id: '2', name: 'Product 2', price: 49.99, imageUrl: 'assets/images/pr2.png', description: ''),
    Product(id: '3', name: 'Product 3', price: 19.99, imageUrl: 'assets/images/pr3.png', description: ''),
    Product(id: '1', name: 'Product 1', price: 29.99, imageUrl: 'assets/images/pr1.png', description: ''),
    Product(id: '2', name: 'Product 2', price: 49.99, imageUrl: 'assets/images/pr2.png', description: ''),
    Product(id: '3', name: 'Product 3', price: 19.99, imageUrl: 'assets/images/pr3.png', description: ''),
    Product(id: '2', name: 'Product 2', price: 49.99, imageUrl: 'assets/images/pr2.png', description: ''),
    Product(id: '3', name: 'Product 3', price: 19.99, imageUrl: 'assets/images/pr3.png', description: ''),
    Product(id: '1', name: 'Product 1', price: 29.99, imageUrl: 'assets/images/pr1.png', description: ''),
    Product(id: '2', name: 'Product 2', price: 49.99, imageUrl: 'assets/images/pr2.png', description: ''),
    Product(id: '3', name: 'Product 3', price: 19.99, imageUrl: 'assets/images/pr3.png', description: ''),
    Product(id: '1', name: 'Product 1', price: 29.99, imageUrl: 'assets/images/pr1.png', description: ''),
    Product(id: '2', name: 'Product 2', price: 49.99, imageUrl: 'assets/images/pr2.png', description: ''),
    Product(id: '3', name: 'Product 3', price: 19.99, imageUrl: 'assets/images/pr3.png', description: ''),
  ];

  // List of products in the cart
  List<Product> _cart = [];

  // Getter to access the list of products
  List<Product> get products => _products;

  // Getter to access the cart
  List<Product> get cart => _cart;

  // Calculate the total price of the items in the cart
  double get totalPrice =>
      _cart.fold(0.0, (sum, item) => sum + item.price * item.quantity);

  // Method to add a product to the cart
  void addToCart(Product product) {
    // Check if the product is already in the cart
    final index = _cart.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      // If the product is already in the cart, increase the quantity
      _cart[index].quantity++;
    } else {
      // If the product is not in the cart, add it with a quantity of 1
      _cart.add(Product(
        id: product.id,
        name: product.name,
        price: product.price,
        quantity: 1,
        imageUrl: product.imageUrl, description: product.description,
      ));
    }
    notifyListeners();
  }

  // Method to remove a product from the cart
  void removeFromCart(Product product) {
    _cart.removeWhere((item) => item.id == product.id);
    notifyListeners();
  }


  // Method to clear the cart after a successful purchase
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

}
