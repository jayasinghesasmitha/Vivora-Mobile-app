import 'package:flutter/material.dart';

class AddSlotScreen extends StatefulWidget {
  const AddSlotScreen({super.key});

  @override
  _AddSlotScreenState createState() => _AddSlotScreenState();
}

class _AddSlotScreenState extends State<AddSlotScreen> {
  String selectedEmployee = '';
  String selectedDay = 'Monday';
  String selectedTime = '08:00 AM';
  final List<bool> employeeAvailability = [false, false, false, false]; // Added 'All' as the first option
  final List<Map<String, dynamic>> services = [
    {'name': 'Haircut', 'price': 500},
    {'name': 'Coloring', 'price': 1500},
    {'name': 'Manicure', 'price': 300},
  ];
  final List<bool> selectedServices = [false, false, false];
  List<Map<String, dynamic>> filteredServices = [];
  final TextEditingController searchController = TextEditingController();
  final TextEditingController employeeController = TextEditingController();
  final List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

  @override
  void initState() {
    super.initState();
    filteredServices = List.from(services);
    searchController.addListener(_filterServices);
  }

  void _filterServices() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredServices = services.where((service) => service['name'].toLowerCase().contains(query)).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    employeeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VIVORA', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text('ADD TIME SLOT', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Employee:', style: TextStyle(color: Colors.black, fontSize: 16)),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.person),
                        onPressed: () {},
                        color: Colors.black,
                      ),
                      IconButton(
                        icon: const Icon(Icons.group),
                        onPressed: () {},
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: employeeController,
                decoration: InputDecoration(
                  hintText: 'Enter employee name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                onChanged: (value) {
                  setState(() {
                    selectedEmployee = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text('Services:', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search services...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 10),
              ...List.generate(filteredServices.length, (index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: selectedServices[index],
                            onChanged: (bool? value) {
                              setState(() {
                                selectedServices[index] = value ?? false;
                              });
                            },
                            activeColor: Colors.black,
                            checkColor: Colors.white,
                          ),
                          Text(filteredServices[index]['name'], style: const TextStyle(color: Colors.black)),
                        ],
                      ),
                      Text('${filteredServices[index]['price']} Rs', style: const TextStyle(color: Colors.black)),
                    ],
                  )),
              const SizedBox(height: 20),
              const Text('Employee Availability:', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
              ...List.generate(4, (index) => Row(
                    children: [
                      Checkbox(
                        value: employeeAvailability[index],
                        onChanged: selectedEmployee.isEmpty
                            ? null
                            : (bool? value) {
                                setState(() {
                                  employeeAvailability[index] = value ?? false;
                                  if (index == 0 && value == true) {
                                    employeeAvailability.setAll(1, [true, true, true]);
                                  } else if (index > 0 && value == true) {
                                    employeeAvailability[0] = false;
                                  }
                                });
                              },
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                      ),
                      Text(['All', 'Kasun', 'Ruwan', 'Amal'][index], style: const TextStyle(color: Colors.black)),
                    ],
                  )),
              const SizedBox(height: 20),
              const Text('Days:', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: days.map((day) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedDay = day;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedDay == day ? Colors.black : Colors.grey[200],
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text(day, style: const TextStyle(color: Colors.white)),
                        ),
                      )).toList(),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Time Slots:', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              SizedBox(
                height: 200, // Fixed height to avoid unbounded height issue
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(16, (index) {
                      final hour = 8 + (index ~/ 2);
                      final minute = (index % 2) * 30;
                      final time = '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} ${hour < 12 ? 'AM' : 'PM'}';
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedTime = time;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedTime == time ? Colors.black : Colors.grey[200],
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text(time, style: const TextStyle(color: Colors.white)),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('ADD', style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}