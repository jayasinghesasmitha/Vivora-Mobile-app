import 'package:flutter/material.dart';
import 'package:salon_app/screens/add_slot.dart';
import 'package:salon_app/screens/time_schedule.dart';

class EditSlotScreen extends StatefulWidget {
  const EditSlotScreen({super.key});

  @override
  _EditSlotScreenState createState() => _EditSlotScreenState();
}

class _EditSlotScreenState extends State<EditSlotScreen> {
  final String employee = 'Sunil'; // Mock data, replace with actual data
  final DateTime date = DateTime.now(); // Mock data, replace with actual data
  final TextEditingController _customerNameController = TextEditingController(text: 'John Doe'); // Mock data
  final Set<String> selectedServices = {'Haircut', 'Manicure'}; // Mock data
  final String selectedTimeSlot = '10:00'; // Mock data
  String? _selectedIcon; // To track selected icon (null, 'traveller', or 'call')

  void toggleIconSelection(String iconType) {
    setState(() {
      if (_selectedIcon == iconType) {
        _selectedIcon = null; // Deselect if the same icon is clicked again
      } else {
        _selectedIcon = iconType; // Select the new icon, deselecting the other
      }
    });
  }

  void editBooking() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AddSlotScreen(
          // Pass current details to AddSlotScreen if it accepts parameters
          // Example: AddSlotScreen(employee: employee, date: date, ...),
        ),
      ),
    );
  }

  void cancelBooking() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const TimeScheduleScreen()),
    );
    // Logic to clear the selected cell in TimeScheduleScreen should be handled there
  }

  void confirmBooking() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const TimeScheduleScreen()),
    );
    // Logic to update TimeScheduleScreen with changes should be handled there
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Edit Time Slot', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black, size: 24),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            Text(
              'Employee: $employee | Date: ${date.day}/${date.month}/${date.year}',
              style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _customerNameController,
                    decoration: const InputDecoration(
                      labelText: "Customer's Name",
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    ),
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.directions_walk, color: _selectedIcon == 'traveller' ? Colors.black : Colors.grey, size: 24),
                  onPressed: () => toggleIconSelection('traveller'),
                ),
                IconButton(
                  icon: Icon(Icons.call, color: _selectedIcon == 'call' ? Colors.black : Colors.grey, size: 24),
                  onPressed: () => toggleIconSelection('call'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Services',
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: selectedServices.map((service) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(service, style: const TextStyle(color: Colors.black, fontSize: 14)),
                  )).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Time Slot',
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              selectedTimeSlot,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: editBooking,
                  child: const Text('Edit Booking', style: TextStyle(color: Colors.white, fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                ElevatedButton(
                  onPressed: cancelBooking,
                  child: const Text('Cancel Booking', style: TextStyle(color: Colors.white, fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                ElevatedButton(
                  onPressed: confirmBooking,
                  child: const Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}