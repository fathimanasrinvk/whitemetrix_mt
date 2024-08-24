import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';

class ScratchCard extends StatelessWidget {
  final VoidCallback onAddToCart;

  ScratchCard({required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Scratcher(
      brushSize: 50,
      threshold: 50,
      color: Colors.grey,
      onThreshold: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Congratulations! You scratched off the card!'),
          ),
        );
      },
      child: Container(
        height: 200,
        width: 300,
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://media.istockphoto.com/id/1204235743/photo/stylish-fashionable-woman-with-orange-round-bag.webp?b=1&s=612x612&w=0&k=20&c=KG95k0zw49LTxC7uxyyKCw88GhaybjhVIxRZjBVbgak=',
              height: 80,
            ),
            Text(
              "HAND BAG",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "₹0.00",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                onAddToCart();
              },
              child: Text("Add to Cart"),
            ),
          ],
        ),
      ),
    );
  }
}