import 'package:flutter/material.dart';
import 'checkout.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final List<Map<String, dynamic>> products = [
    {'name': 'Onion (Big)', 'wholesalePrice': 53, 'retailPrice': '61-67'},
    {'name': 'Tomato', 'wholesalePrice': 25, 'retailPrice': '29-32'},
    {'name': 'Green Chilli', 'wholesalePrice': 42, 'retailPrice': '48-53'},
    {'name': 'Potato', 'wholesalePrice': 40, 'retailPrice': '46-51'},
    {'name': 'Cabbage', 'wholesalePrice': 24, 'retailPrice': '28-30'},
    {'name': 'Brinjal', 'wholesalePrice': 38, 'retailPrice': '44-48'},
    {'name': 'Ginger', 'wholesalePrice': 128, 'retailPrice': '147-163'},
  ];

  final List<Map<String, dynamic>> _cartItems = [];

  void _addToCart(String name, int price, int quantity) {
    if (_cartItems.any((item) => item['name'] == name)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$name is already in the cart')),
      );
      return;
    }
    setState(() {
      _cartItems.add({
        'name': name,
        'quantity': quantity,
        'price': price,
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$name added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Price List',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.orangeAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cartItems: _cartItems),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
              name: product['name'],
              wholesalePrice: product['wholesalePrice'],
              retailPrice: product['retailPrice'],
              onAddToCart: (name, price, quantity) {
                _addToCart(name, price, quantity);
              },
            );
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final String name;
  final int wholesalePrice;
  final String retailPrice;
  final Function(String name, int price, int quantity) onAddToCart;

  ProductCard({
    required this.name,
    required this.wholesalePrice,
    required this.retailPrice,
    required this.onAddToCart,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int _quantity = 1;
  bool _isWholesaleSelected = false;

  void _updateQuantity(int change) {
    if (_isWholesaleSelected) {
      // Ensure minimum quantity of 10 kg for wholesale
      if (_quantity + change >= 10 || change < 0 && _quantity > 1) {
        setState(() {
          _quantity += change;
        });
      }
    } else {
      // No restriction on quantity for retail
      setState(() {
        _quantity += change;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Wholesale:',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text('₹${widget.wholesalePrice}'),
                    Checkbox(
                      value: _isWholesaleSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          _isWholesaleSelected = value ?? false;
                          // Ensure quantity meets wholesale requirement if applicable
                          if (_isWholesaleSelected && _quantity < 10) {
                            _quantity = 10; // Set to minimum required quantity
                          }
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Retail:',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text('₹${widget.retailPrice}'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        _updateQuantity(-1);
                      },
                    ),
                    Text('$_quantity kg'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _updateQuantity(1);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    widget.onAddToCart(
                      widget.name,
                      _isWholesaleSelected ? widget.wholesalePrice : int.parse(widget.retailPrice.split('-').first),
                      _quantity,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  CartPage({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: cartItems.isEmpty
          ? Center(
        child: const Text('No items in the cart'),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return CartItemCard(
                    name: item['name'],
                    quantity: item['quantity'],
                    price: item['price'],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Proceed to Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItemCard extends StatelessWidget {
  final String name;
  final int quantity;
  final int price;

  CartItemCard({
    required this.name,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('Quantity: $quantity kg'),
                  Text('Price: ₹$price per kg'),
                  const SizedBox(height: 8),
                  Text('Total: ₹${price * quantity}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
