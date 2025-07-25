import 'package:flutter/material.dart';
import 'package:salon_app/screens/salon_details.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Salon Signup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: const InputDecoration(labelText: 'Salon Name')),
            TextField(decoration: const InputDecoration(labelText: 'Email')),
            TextField(decoration: const InputDecoration(labelText: 'Password')),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SalonDetailsScreen()));
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}