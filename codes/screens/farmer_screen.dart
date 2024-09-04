// ignore_for_file: sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class FarmerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Dashboard',
          style: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
        backgroundColor: Colors.green[400],
      ),
      body: Column(
        children: <Widget>[

      Container(
            height: 200,
            child: PageView(
              children: <Widget>[
                _buildPriceCard('Wheat', '₹2,000 per quintal', Colors.blueAccent),
                _buildPriceCard('Rice', '₹3,500 per quintal', Colors.orangeAccent),
                _buildPriceCard('Corn', '₹1,800 per quintal', Colors.amberAccent),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.chat, color: Colors.green),
                  title: const Text('Chat with Storehouses',
                    style:TextStyle(
                      fontFamily: "roboto",
                      fontSize:20,
                    ),
                  ),
                  onTap: () {
                    // Navigate to chat screen
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.call, color: Colors.green),
                  title: const Text('Call with Storehouse',
                    style:TextStyle(
                      fontFamily: "roboto",
                      fontSize:20,
                    ),
                  ),
                  onTap: () {
                    // Navigate to resources screen
                  },
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceCard(String title, String price, Color color) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: color,
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(price, style: const TextStyle(fontSize: 18, color: Colors.white70)),
        ],
      ),
    );
  }
}
