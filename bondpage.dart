import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting the date

class ChatPage extends StatefulWidget {
  final String retailerName;

  ChatPage({required this.retailerName});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  List<String> _messages = [];
  double? confirmedPrice;

  // Function to send a message
  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(_messageController.text);
      });
      _messageController.clear();
    }
  }

  // Function to confirm the price
  void _confirmPrice() {
    final price = double.tryParse(_priceController.text);
    if (price != null) {
      setState(() {
        confirmedPrice = price;
        _priceController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Price confirmed: ${confirmedPrice!.toStringAsFixed(2)}')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid price')),
      );
    }
  }

  // Function to submit the price and finalize the negotiation
  void _submitAgreement() {
    if (confirmedPrice != null) {
      // Navigate to BondPage with agreement details
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BondPage(
            retailerName: widget.retailerName,
            price: confirmedPrice!,
            date: DateTime.now(),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please confirm the price before submitting')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.retailerName}'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Confirm Price (per kg)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _confirmPrice,
                      child: Text('Confirm Price'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _submitAgreement,
                  child: Text('Submit Agreement'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// BondPage to display the agreement details
class BondPage extends StatelessWidget {
  final String retailerName;
  final double price;
  final DateTime date;

  BondPage({
    required this.retailerName,
    required this.price,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat.yMMMMd().format(date); // Format the date

    return Scaffold(
      appBar: AppBar(
        title: Text('Agreement Bond'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bond Agreement',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Retailer: $retailerName',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Agreed Price: ₹${price.toStringAsFixed(2)} per kg',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Date of Agreement: $formattedDate',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            Text(
              'Other Terms and Conditions:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '- The agreement is binding between both parties.\n'
                  '- Payment should be made within the agreed timeline.\n'
                  '- Both parties agree to the terms of the negotiation.',
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to previous screen
                },
                child: Text('Done'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
