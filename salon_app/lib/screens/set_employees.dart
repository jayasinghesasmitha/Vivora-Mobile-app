import 'package:flutter/material.dart';

class SetEmployeesScreen extends StatelessWidget {
  const SetEmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set Employees')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: const InputDecoration(labelText: 'Employee Name')),
            TextField(decoration: const InputDecoration(labelText: 'Role')),
            ElevatedButton(
              onPressed: () {
                // Implement add employee logic
              },
              child: const Text('Add Employee'),
            ),
          ],
        ),
      ),
    );
  }
}