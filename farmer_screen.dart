import 'package:flutter/material.dart';
// Make sure to import the NegotiationPage
import 'negotiaion_page.dart';

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});
}

class FarmerScreen extends StatefulWidget {
  @override
  _FarmerScreenState createState() => _FarmerScreenState();
}

class _FarmerScreenState extends State<FarmerScreen> {
  // Sample list of crops
  final List<Product> products = [
    Product(name: 'Wheat', price: 25.0),
    Product(name: 'Rice', price: 30.0),
    Product(name: 'Maize', price: 20.0),
    Product(name: 'Potatoes', price: 15.0),
  ];

  Product? _selectedProduct;
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // List to store multiple selected crops with their quantity and price
  List<Map<String, dynamic>> selectedItems = [];

  // Function to add selected crop with quantity and price to the list
  void _addItem() {
    if (_selectedProduct != null &&
        _quantityController.text.isNotEmpty &&
        _priceController.text.isNotEmpty) {
      final quantity = int.tryParse(_quantityController.text);
      final price = double.tryParse(_priceController.text);

      if (quantity != null && price != null) {
        setState(() {
          selectedItems.add({
            'crop': _selectedProduct!.name,
            'quantity': quantity,
            'price': price,
          });
        });

        // Clear the fields after adding
        _quantityController.clear();
        _priceController.clear();
        _selectedProduct = null;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter valid quantity and price')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a crop and enter quantity and price')),
      );
    }
  }

  // Function to submit all the selected items
  void _submitItems() {
    if (selectedItems.isNotEmpty) {
      // Navigate to the negotiation page with the selected items
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NegotiationPage(),
        ),
      );

      // Clear the list after submission
      setState(() {
        selectedItems.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No items to submit')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Dashboard'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Select Crop, Enter Quantity, and Price',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            DropdownButton<Product>(
              hint: Text('Select Crop'),
              value: _selectedProduct,
              onChanged: (Product? newValue) {
                setState(() {
                  _selectedProduct = newValue;
                });
              },
              items: products.map((Product product) {
                return DropdownMenuItem<Product>(
                  value: product,
                  child: Text(product.name),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity (kg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Price (per kg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addItem,
              child: Text('Add Crop'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: selectedItems.length,
                itemBuilder: (context, index) {
                  final item = selectedItems[index];
                  return ListTile(
                    title: Text(
                        '${item['crop']} - Quantity: ${item['quantity']} kg - Price: ${item['price']} per kg'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          selectedItems.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitItems,
              child: Text('Submit All Items'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
