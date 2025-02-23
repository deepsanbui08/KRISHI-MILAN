import 'package:flutter/material.dart';
import 'farmer_screen.dart';
import 'farmer_registration_page.dart';

class FarmerLoginPage extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login(BuildContext context) {
    if (_phoneController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FarmerScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Phone or Password cannot be empty')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Farmer Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(controller: _phoneController, decoration: InputDecoration(labelText: 'Phone')),
            TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            ElevatedButton(onPressed: () => _login(context), child: Text('Login')),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerRegistrationPage()));
              },
              child: Text('New User? Register'),
            ),
          ],
        ),
      ),
    );
  }
}
