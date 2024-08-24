class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description; // Add this line
  int quantity; // Make sure this is mutable

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description, // And this line
    this.quantity = 1, // Initialize with a default quantity of 1
  });

}
