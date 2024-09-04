// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class RetailerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retailer Dashboard',
        style:TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 30,
        )),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.shopping_basket),
            title: const Text('View Products',
            style:TextStyle(
              fontSize:20,

            )),
            onTap: () {
              // Navigate to product listing screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Place Orders',
            style:TextStyle(
              fontSize:20,
            )),
            onTap: () {
              // Navigate to order placement screen
            },
          ),
        ],
      ),
    );
  }
}
