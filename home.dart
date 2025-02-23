import 'package:flutter/material.dart';
import 'farmer_login.dart';
import 'retailer_login.dart';
import 'consumer_login.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Krishi Milan',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28,
        ),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: SingleChildScrollView(  // Wrap the entire body in a SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 40),
              const Text(
                'Welcome to Krishi Milan',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Connecting Farmers, Retailers, and Consumers',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 40),

              // Role Selection
              Column(
                children: <Widget>[
                  _buildRoleCard(
                    context,
                    'Farmer',
                    'assets/farmer.jpg',
                    Colors.orangeAccent,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FarmerLoginPage()),
                      );
                    },
                  ),
                  _buildRoleCard(
                    context,
                    'Retailer',
                    'assets/retailer.png',
                    Colors.blueAccent,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RetailerLoginPage()),
                      );
                    },
                  ),
                  _buildRoleCard(
                    context,
                    'Consumer',
                    'assets/consumer.jpg',
                    Colors.greenAccent,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ConsumerLoginPage()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context, String role, String imagePath, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color),
        ),
        child: Row(
          children: <Widget>[
            Image.asset(imagePath, height: 60, width: 60),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                role,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            Icon(Icons.arrow_forward, color: color),
          ],
        ),
      ),
    );
  }
}


