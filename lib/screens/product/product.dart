import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product["name"]),
        actions: [
          IconButton(
            onPressed: () {
              _openCart(context);
            },
            icon: Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () {
              _addToFavorites(context);
            },
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(product["photo"]),
            SizedBox(height: 20),
            Text(
              product["name"],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Price: ${product["price"]} ₺",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _addToCart(context);
              },
              child: Text("Add to Cart"),
            ),
          ],
        ),
      ),
    );
  }

  void _addToCart(BuildContext context) {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Added to Cart"),
        content: Text("Product has been added to your cart."),
        actions: [
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).push("/cart");
            },
            child: Text("Go to Cart"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _openCart(BuildContext context) {

    GoRouter.of(context).push("/cart");
  }

  void _addToFavorites(BuildContext context) {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Added to Favorites"),
        content: Text("Product has been added to your favorites."),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
