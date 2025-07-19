import 'package:flutter/material.dart';

class SaloonCard extends StatelessWidget {
  final String name;
  final String address;
  final String hours;
  final VoidCallback onTap;

  const SaloonCard({
    required this.name,
    required this.address,
    required this.hours,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage('https://via.placeholder.com/50'), // Replace with salon image URL
        ),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(hours),
            Text('🌐 $address'),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}