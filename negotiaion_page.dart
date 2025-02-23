import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'chatpage.dart'; // Import the ChatPage

class NegotiationPage extends StatelessWidget {
  // Sample list of retailers
  final List<Map<String, String>> retailers = [
    {'name': 'Retailer A', 'phone': '1234567890'},
    {'name': 'Retailer B', 'phone': '0987654321'},
    {'name': 'Retailer C', 'phone': '1122334455'},
  ];

  // Function to initiate a phone call
  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  // Function to navigate to a chat page
  void _openChat(BuildContext context, String retailerName) {
    // Navigate to ChatPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(retailerName: retailerName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Negotiation with Retailers'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: ListView.builder(
        itemCount: retailers.length,
        itemBuilder: (context, index) {
          final retailer = retailers[index];
          return ListTile(
            title: Text(retailer['name']!),
            subtitle: Text('Phone: ${retailer['phone']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.chat),
                  onPressed: () {
                    _openChat(context, retailer['name']!);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {
                    _makePhoneCall(retailer['phone']!);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
