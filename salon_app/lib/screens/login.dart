import 'package:flutter/material.dart';
import 'package:salon_app/screens/signup.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Salon Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: const InputDecoration(labelText: 'Email')),
            TextField(decoration: const InputDecoration(labelText: 'Password')),
            ElevatedButton(
              onPressed: () {
                // Implement login logic
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupScreen()));
              },
              child: const Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}