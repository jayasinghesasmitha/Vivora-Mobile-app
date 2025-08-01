import 'package:flutter/material.dart';
import 'package:salon_app/screens/add_slot.dart';
import 'package:salon_app/screens/time_schedule.dart';

class EditSlotScreen extends StatefulWidget {
  final Map<String, dynamic> slotDetails;
  final List<Map<String, dynamic>> bookedSlots;

  const EditSlotScreen({super.key, required this.slotDetails, required this.bookedSlots});

  @override
  _EditSlotScreenState createState() => _EditSlotScreenState();
}

class _EditSlotScreenState extends State<EditSlotScreen> {
  late TextEditingController _customerNameController;
  late Set<String> selectedServices;
  late String? _selectedIcon;
  late String selectedTimeSlot;
  late Map<String, dynamic> employee;
  late DateTime date;
  final Map<String, double> services = {
    'Haircut': 20.0,
    'Manicure': 15.0,
    'Pedicure': 25.0,
  };

  @override
  void initState() {
    super.initState();
    _customerNameController = TextEditingController(text: widget.slotDetails['customerName']);
    selectedServices = Set.from(widget.slotDetails['services']);
    _selectedIcon = widget.slotDetails['type'];
    selectedTimeSlot = widget.slotDetails['time'];
    employee = {'name': widget.slotDetails['employee'], 'image': 'images/placeholder.png'};
    date = widget.slotDetails['date'];
  }

  void toggleIconSelection(String iconType) {
    setState(() {
      if (_selectedIcon == iconType) {
        _selectedIcon = null;
      } else {
        _selectedIcon = iconType;
      }
    });
  }

  void toggleServiceSelection(String service) {
    setState(() {
      if (selectedServices.contains(service)) {
        selectedServices.remove(service);
      } else {
        selectedServices.add(service);
      }
    });
  }

  void editBooking() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddSlotScreen(bookedSlots: widget.bookedSlots),
      ),
    );
  }

  void cancelBooking() {
    final updatedSlots = List<Map<String, dynamic>>.from(widget.bookedSlots)
      ..removeWhere(
        (slot) =>
            slot['employee'] == employee['name'] &&
            slot['time'] == selectedTimeSlot &&
            slot['date'].day == date.day &&
            slot['date'].month == date.month &&
            slot['date'].year == date.year,
      );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TimeScheduleScreen(bookedSlots: updatedSlots),
      ),
    );
  }

  void confirmBooking() {
    final updatedSlots = List<Map<String, dynamic>>.from(widget.bookedSlots);
    updatedSlots.removeWhere(
      (slot) =>
          slot['employee'] == employee['name'] &&
          slot['time'] == selectedTimeSlot &&
          slot['date'].day == date.day &&
          slot['date'].month == date.month &&
          slot['date'].year == date.year,
    );
    updatedSlots.add({
      'employee': employee['name'],
      'customerName': _customerNameController.text,
      'date': date,
      'time': selectedTimeSlot,
      'type': _selectedIcon ?? 'booking',
      'services': List.from(selectedServices),
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TimeScheduleScreen(bookedSlots: updatedSlots),
      ),
    );
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(employee['image']!),
                      backgroundColor: Colors.grey[200],
                    ),
                    const SizedBox(width: 10),
                    Text(
                      employee['name']!,
                      style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey[200],
                  child: Text(
                    '${date.day}',
                    style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Day: ${['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'][date.weekday - 1]}',
              style: const TextStyle(color: Colors.black, fontSize: 16),
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
              children: services.entries.map((entry) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: selectedServices.contains(entry.key),
                            onChanged: (value) => toggleServiceSelection(entry.key),
                            checkColor: Colors.black,
                            activeColor: Colors.black,
                          ),
                          Text(entry.key, style: const TextStyle(color: Colors.black, fontSize: 14)),
                        ],
                      ),
                      Text('\$${entry.value}', style: const TextStyle(color: Colors.black, fontSize: 14)),
                    ],
                  )).toList(),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(selectedTimeSlot, style: const TextStyle(color: Colors.black, fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      minimumSize: const Size(200, 0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: editBooking,
                    child: const Text('Edit Booking', style: TextStyle(color: Colors.white, fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      minimumSize: const Size(400, 0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: cancelBooking,
                    child: const Text('Cancel Booking', style: TextStyle(color: Colors.white, fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      minimumSize: const Size(400, 0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: confirmBooking,
                    child: const Text('Confirm', style: TextStyle(color: Colors.black, fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      minimumSize: const Size(400, 0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}