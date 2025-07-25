import 'package:flutter/material.dart';
import 'package:salon_app/screens/set_employees.dart';

class SalonDetailsScreen extends StatelessWidget {
  const SalonDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Salon Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: const InputDecoration(labelText: 'Address')),
            TextField(decoration: const InputDecoration(labelText: 'Contact')),
            TextField(decoration: const InputDecoration(labelText: 'Hours')),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SetEmployeesScreen()));
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}