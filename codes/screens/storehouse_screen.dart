import 'package:flutter/material.dart';

class StorehouseScreen extends StatelessWidget {
  const StorehouseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Storehouse Management',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 30,
        )),
        backgroundColor: Colors.green[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Card(
              color: Colors.lightGreen,
              child: ListTile(
                leading: const Icon(Icons.inventory, color: Colors.white),
                title: const Text('Manage Inventory', style: TextStyle(color: Colors.white,
                fontSize: 20,
                ),
                ),
                onTap: () {
                  // Navigate to inventory management screen
                },
              ),
            ),
            Card(
              color: Colors.lightGreen,
              child: ListTile(
                leading: const Icon(Icons.chat, color: Colors.white),
                title: const Text('Chat with Farmers',
                  style: TextStyle(color: Colors.white,
                  fontSize: 20,
                  ),

                ),
                onTap: () {
                  // Navigate to chat screen
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
