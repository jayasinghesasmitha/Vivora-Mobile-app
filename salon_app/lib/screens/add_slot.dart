import 'package:flutter/material.dart';
import 'package:salon_app/screens/edit_slot.dart';
import 'package:salon_app/screens/time_schedule.dart'; // Import time_schedule.dart

class AddSlotScreen extends StatefulWidget {
  const AddSlotScreen({super.key});

  @override
  _AddSlotScreenState createState() => _AddSlotScreenState();
}

class _AddSlotScreenState extends State<AddSlotScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController(text: 'John Doe');
  final List<String> services = ['Haircut', 'Manicure', 'Pedicure'];
  final Set<String> selectedServices = {};
  final List<Map<String, dynamic>> employees = [
    {'name': 'All', 'image': 'images/placeholder.png'},
    {'name': 'Sunil', 'image': 'images/placeholder.png'},
    {'name': 'Nimal', 'image': 'images/placeholder.png'},
    {'name': 'Kamal', 'image': 'images/placeholder.png'},
  ];
  final Set<String> selectedEmployees = {};
  final List<DateTime> availableDays = List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
  DateTime _selectedDay = DateTime.now();
  final Set<String> selectedTimeSlots = {};
  String? _selectedIcon; // To track selected icon (null, 'traveller', or 'call')

  void toggleServiceSelection(String service) {
    setState(() {
      if (selectedServices.contains(service)) {
        selectedServices.remove(service);
      } else {
        selectedServices.add(service);
      }
    });
  }

  void toggleEmployeeSelection(String name) {
    setState(() {
      if (name == 'All') {
        selectedEmployees.clear();
        selectedEmployees.addAll({'All', 'Sunil', 'Nimal', 'Kamal'});
      } else {
        selectedEmployees.remove('All');
        if (selectedEmployees.contains(name)) {
          selectedEmployees.remove(name);
        } else {
          selectedEmployees.add(name);
        }
        if (selectedEmployees.length == 3) {
          selectedEmployees.add('All');
        }
      }
    });
  }

  void selectDay(DateTime day) {
    setState(() {
      _selectedDay = day;
    });
  }

  void toggleTimeSlotSelection(int index) {
    final slot = '${(index ~/ 2).toString().padLeft(2, '0')}:${index % 2 == 1 ? '30' : '00'}';
    setState(() {
      if (selectedTimeSlots.contains(slot)) {
        selectedTimeSlots.remove(slot);
      } else {
        selectedTimeSlots.add(slot);
      }
    });
  }

  void toggleIconSelection(String iconType) {
    setState(() {
      if (_selectedIcon == iconType) {
        _selectedIcon = null; // Deselect if the same icon is clicked again
      } else {
        _selectedIcon = iconType; // Select the new icon, deselecting the other
      }
    });
  }

  bool canAddSlot() {
    return selectedServices.isNotEmpty && selectedEmployees.isNotEmpty && selectedTimeSlots.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final filteredServices = services
        .where((service) => service.toLowerCase().contains(_searchController.text.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Add Time Slot', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Services Available',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search services...',
                prefixIcon: const Icon(Icons.search, color: Colors.black, size: 16),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.black)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: filteredServices.map((service) => Row(
                    children: [
                      Checkbox(
                        value: selectedServices.contains(service),
                        onChanged: (value) => toggleServiceSelection(service),
                        checkColor: Colors.black,
                        activeColor: Colors.black,
                      ),
                      Text(service, style: const TextStyle(fontSize: 14)),
                    ],
                  )).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Employees Available',
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 80,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: employees.map((employee) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () => toggleEmployeeSelection(employee['name']),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage(employee['image']),
                                backgroundColor: selectedEmployees.contains(employee['name']) ? Colors.grey[700] : Colors.grey[200],
                                child: selectedEmployees.contains(employee['name'])
                                    ? const Icon(Icons.check, color: Colors.white, size: 20)
                                    : null,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                employee['name'],
                                style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      )).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Available Days',
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 80,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: availableDays.map((day) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () => selectDay(day),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: _selectedDay.day == day.day && _selectedDay.month == day.month && _selectedDay.year == day.year
                                ? Colors.black
                                : Colors.grey[200],
                            child: Text(
                              '${day.day}\n${['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][day.weekday - 1]}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _selectedDay.day == day.day && _selectedDay.month == day.month && _selectedDay.year == day.year
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      )).toList(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: 48,
                itemBuilder: (context, index) {
                  final slot = '${(index ~/ 2).toString().padLeft(2, '0')}:${index % 2 == 1 ? '30' : '00'}';
                  final isSelected = selectedTimeSlots.contains(slot);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: GestureDetector(
                      onTap: () => toggleTimeSlotSelection(index),
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!, width: 0.5),
                          borderRadius: BorderRadius.circular(8),
                          color: isSelected ? Colors.grey[200] : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            slot,
                            style: const TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ));
                },
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                onPressed: canAddSlot() ? () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const TimeScheduleScreen()),
                  );
                } : null,
                child: const Text('Add', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: canAddSlot() ? Colors.black : Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}