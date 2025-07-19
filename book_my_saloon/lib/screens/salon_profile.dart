import 'package:flutter/material.dart';
import 'booking_screen.dart';

class SalonProfile extends StatefulWidget {
  final String salonName;

  const SalonProfile({required this.salonName, Key? key}) : super(key: key);

  @override
  _SalonProfileState createState() => _SalonProfileState();
}

class _SalonProfileState extends State<SalonProfile> {
  Map<String, bool> selectedServices = {
    "Hair Cutting and Shaving": false,
    "Oil Massage": false,
    "Beard Trimming": false,
  };

  Map<String, int> servicePrices = {
    "Hair Cutting and Shaving": 100,
    "Oil Massage": 200,
    "Beard Trimming": 300,
  };

  Map<String, int> serviceDurations = {
    "Hair Cutting and Shaving": 60,   // minutes
    "Oil Massage": 120,
    "Beard Trimming": 180,
  };

  int get totalCost => selectedServices.entries
      .where((e) => e.value)
      .map((e) => servicePrices[e.key]!)
      .fold(0, (a, b) => a + b);

  int get totalDuration => selectedServices.entries
      .where((e) => e.value)
      .map((e) => serviceDurations[e.key]!)
      .fold(0, (a, b) => a + b);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Center(
                child: Text(
                  "VIVORA",
                  style: TextStyle(
                    fontFamily: 'VivoraFont',
                    fontSize: 28,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Image.asset(
                    'images/placeholder.png',
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.salonName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      const Row(
                        children: [
                          Icon(Icons.location_on, size: 16),
                          SizedBox(width: 4),
                          Text("Colombo"),
                        ],
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'images/salon_image.jpg', // Replace with actual salon image
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              const Text("Services",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...selectedServices.keys.map((service) {
                return CheckboxListTile(
                  title: Text(service),
                  subtitle: Text('Rs ${servicePrices[service]}'),
                  value: selectedServices[service],
                  onChanged: (bool? value) {
                    setState(() {
                      selectedServices[service] = value ?? false;
                    });
                  },
                );
              }).toList(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Duration",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Text("${(totalDuration / 60).toStringAsFixed(1)} hours",
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Text("Rs $totalCost",
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BookingScreen(saloonName: '',)),
                  );
                },
                child: const Text("Proceed",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
