import 'package:flutter/material.dart';
import 'package:salon_app/screens/add_slot.dart';
import 'package:salon_app/screens/edit_slot.dart';
import 'package:salon_app/screens/salon_details.dart';

class TimeScheduleScreen extends StatefulWidget {
  const TimeScheduleScreen({super.key});

  @override
  _TimeScheduleScreenState createState() => _TimeScheduleScreenState();
}

class _TimeScheduleScreenState extends State<TimeScheduleScreen> {
  String selectedOption = 'All';
  final List<Map<String, dynamic>> employees = [
    {'name': 'John Doe', 'image': 'images/salon_image.jpg'},
    {'name': 'Jane Smith', 'image': 'images/salon_image.jpg'},
    {'name': 'Mike Johnson', 'image': 'images/salon_image.jpg'},
  ];
  int selectedDays = 1;
  final List<DateTime> days = [
    DateTime(2025, 7, 29), // Tuesday
    DateTime(2025, 7, 30), // Wednesday
    DateTime(2025, 7, 31), // Thursday
  ];
  Map<DateTime, List<Map<String, dynamic>>> timeSlots = {
    DateTime(2025, 7, 29): [
      {'time': '08:00 AM', 'employees': [true, true, true]},
      {'time': '08:30 AM', 'employees': [true, false, true]},
    ],
    DateTime(2025, 7, 30): [
      {'time': '09:00 AM', 'employees': [false, true, true]},
    ],
    DateTime(2025, 7, 31): [
      {'time': '10:00 AM', 'employees': [true, true, false]},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VIVORA', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Salon Name', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Image.asset(
                      'images/salon_image.jpg',
                      height: 50,
                      width: 50,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error, color: Colors.red);
                      },
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SalonDetailsScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Edit Profile', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Select:', style: TextStyle(color: Colors.black)),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedOption,
                  items: ['All', 'Available Employees'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(color: Colors.black)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedOption = newValue!;
                    });
                  },
                  dropdownColor: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Icon(Icons.people, color: Colors.black),
                  ...employees.map((employee) => Row(
                        children: [
                          Image.asset(
                            employee['image'],
                            height: 40,
                            width: 40,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.error, color: Colors.red);
                            },
                          ),
                          const SizedBox(width: 5),
                          Text(employee['name'], style: const TextStyle(color: Colors.black)),
                          const SizedBox(width: 10),
                        ],
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditSlotScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Edit Available Time Slots', style: TextStyle(color: Colors.black)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [1, 2, 3].map((dayCount) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDays = dayCount;
                      });
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: selectedDays == dayCount ? Colors.black : Colors.grey,
                      child: Text('$dayCount days', style: TextStyle(color: Colors.white)),
                    ),
                  )).toList(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: selectedDays,
                itemBuilder: (context, index) {
                  final date = days[index];
                  final slots = timeSlots[date] ?? [];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${date.day}/${date.month}/${date.year} (${['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'][date.weekday - 1]})',
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      ...List.generate(16, (slotIndex) {
                        final startHour = 8 + (slotIndex ~/ 2);
                        final startMin = (slotIndex % 2) * 30;
                        final time = '${startHour.toString().padLeft(2, '0')}:${startMin.toString().padLeft(2, '0')} ${startHour < 12 ? 'AM' : 'PM'}';
                        final slot = slots.firstWhere((s) => s['time'] == time, orElse: () => {'time': time, 'employees': [false, false, false]});
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(slot['time'], style: const TextStyle(color: Colors.black)),
                              ),
                              ...List.generate(3, (empIndex) {
                                final color = slot['employees'][empIndex]
                                    ? [Colors.red, Colors.green, Colors.blue][empIndex]
                                    : Colors.white;
                                return Container(
                                  width: 30,
                                  height: 30,
                                  color: color,
                                  margin: const EdgeInsets.only(right: 5),
                                );
                              }),
                            ],
                          ),
                        );
                      }),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddSlotScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('ADD SLOT', style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}