import 'package:flutter/material.dart';

class SalonProfile extends StatelessWidget {
  final String salonName;

  const SalonProfile({required this.salonName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(salonName)),
      body: Center(child: Text('Profile for $salonName')),
    );
  }
}