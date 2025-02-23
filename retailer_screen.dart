import 'package:flutter/material.dart';
import 'product_list.dart';  // Import the ProductListScreen

class RetailerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Dashboard',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the ProductListScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductListScreen(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'View Products',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
