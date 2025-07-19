import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date and time formatting
import 'package:book_my_saloon/screens/home_screen.dart'; // Import the home screen

class BookingConfirmationScreen extends StatelessWidget {
  final String saloonName;
  final String service;
  final DateTime date;
  final TimeOfDay time;

  const BookingConfirmationScreen({
    Key? key,
    required this.saloonName,
    required this.service,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample service prices (to be adjusted based on actual data)
    final Map<String, double> servicePrices = {
      'Hair Cutting and Shaving': 1400.0,
      'Oil Massage': 1400.0,
      'Beard Trimming': 1400.0,
    };
    final double servicePrice = servicePrices[service] ?? 0.0;
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final String formattedDate = dateFormat.format(date);
    final String startTime = '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
    final String endTime = '${time.hour}:${(time.minute + 45).toString().padLeft(2, '0')}';
    final double total = servicePrice; // Assuming single service for now

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // VIVORA Logo
            Text(
              'VIVORA',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Roboto', // Placeholder font, adjust as needed
              ),
            ),
            SizedBox(height: 20),
            // Booking Confirmed Text
            Text(
              'Booking Confirmed',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Salon Logo
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'images/salon.jpg', // Replace with actual salon image
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 10),
            // Salon Name and Location
            Text(
              saloonName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Colombo',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            // Services
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(service, style: TextStyle(fontSize: 16)),
                Text('Rs $servicePrice', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 10),
            // Additional Services (Placeholder, to be dynamic from salon_profile.dart)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Oil Massage', style: TextStyle(fontSize: 16)),
                Text('Rs 1400', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Beard Trimming', style: TextStyle(fontSize: 16)),
                Text('Rs 1400', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 20),
            // Pay at Venue
            Row(
              children: [
                Icon(Icons.payment, color: Colors.grey),
                SizedBox(width: 5),
                Text('Pay at Venue', style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
            SizedBox(height: 20),
            // Time Slot
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Time Slot', style: TextStyle(fontSize: 16)),
                Text('$startTime - $endTime', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 10),
            // Duration
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Duration', style: TextStyle(fontSize: 16)),
                Text('45 minutes', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 10),
            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Rs $total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 20),
            // Back to Home Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Back to Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}