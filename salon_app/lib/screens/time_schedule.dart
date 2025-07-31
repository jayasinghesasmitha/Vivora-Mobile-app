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
    {'name': 'All', 'image': 'images/placeholder.png'},
    {'name': 'Sunil', 'image': 'images/placeholder.png'},
    {'name': 'Nimal', 'image': 'images/placeholder.png'},
    {'name': 'Kamal', 'image': 'images/placeholder.png'},
  ];
  DateTime _currentDate = DateTime.now();
  final List<DateTime> dates = [];
  Set<String> selectedEmployees = {'All', 'Sunil', 'Nimal', 'Kamal'};
  final List<Color> slotColors = [Colors.pink[50]!, Colors.green[50]!, Colors.blue[50]!];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 7; i++) {
      dates.add(DateTime.now().add(Duration(days: i)));
    }
  }

  void toggleEmployeeSelection(String name) {
    setState(() {
      if (name == 'All') {
        selectedEmployees = {'All', 'Sunil', 'Nimal', 'Kamal'};
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('VIVORA', style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black, size: 24),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
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
                                        backgroundColor: Colors.grey[200],
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
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const AddSlotScreen()),
                            );
                          },
                          child: const Text('ADD SLOT', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_left, color: Colors.black, size: 32, shadows: [
                            Shadow(color: Colors.black26, offset: Offset(2, 2), blurRadius: 4),
                          ]),
                          onPressed: () {
                            setState(() {
                              _currentDate = _currentDate.subtract(Duration(days: 1));
                              dates.clear();
                              for (int i = 0; i < 7; i++) {
                                dates.add(_currentDate.add(Duration(days: i)));
                              }
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            '${_currentDate.day.toString().padLeft(2, '0')}-${_currentDate.month.toString().padLeft(2, '0')}-${_currentDate.year} (${['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][_currentDate.weekday - 1]})',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(color: Colors.black12, offset: Offset(1, 1), blurRadius: 3),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_right, color: Colors.black, size: 32, shadows: [
                            Shadow(color: Colors.black26, offset: Offset(-2, 2), blurRadius: 4),
                          ]),
                          onPressed: () {
                            setState(() {
                              _currentDate = _currentDate.add(Duration(days: 1));
                              dates.clear();
                              for (int i = 0; i < 7; i++) {
                                dates.add(_currentDate.add(Duration(days: i)));
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 500,
                      child: ListView.builder(
                        itemCount: 24,
                        itemBuilder: (context, index) {
                          final hour = index;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0, right: 12.0),
                                      child: Text(
                                        '${hour.toString().padLeft(2, '0')}:00',
                                        style: const TextStyle(color: Colors.black, fontSize: 16),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: List.generate(3, (empIndex) {
                                          final employeeName = ['Sunil', 'Nimal', 'Kamal'][empIndex];
                                          final isVisible = selectedEmployees.contains('All') || selectedEmployees.contains(employeeName);
                                          return Expanded(
                                            child: GestureDetector(
                                              onTap: isVisible
                                                  ? () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (_) => const EditSlotScreen()),
                                                      );
                                                    }
                                                  : null,
                                              child: Container(
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: isVisible ? slotColors[empIndex % slotColors.length] : Colors.white,
                                                  border: Border.all(color: Colors.grey[300]!, width: 0.5),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                margin: const EdgeInsets.all(2),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                                if (index < 23) Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0, right: 12.0),
                                      child: Text(
                                        '${hour.toString().padLeft(2, '0')}:30',
                                        style: const TextStyle(color: Colors.black, fontSize: 16),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: List.generate(3, (empIndex) {
                                          final employeeName = ['Sunil', 'Nimal', 'Kamal'][empIndex];
                                          final isVisible = selectedEmployees.contains('All') || selectedEmployees.contains(employeeName);
                                          return Expanded(
                                            child: GestureDetector(
                                              onTap: isVisible
                                                  ? () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (_) => const EditSlotScreen()),
                                                      );
                                                    }
                                                  : null,
                                              child: Container(
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: isVisible ? slotColors[empIndex % slotColors.length] : Colors.white,
                                                  border: Border.all(color: Colors.grey[300]!, width: 0.5),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                margin: const EdgeInsets.all(2),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 16.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SalonDetailsScreen()),
                  );
                },
                child: const Text('Back', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}