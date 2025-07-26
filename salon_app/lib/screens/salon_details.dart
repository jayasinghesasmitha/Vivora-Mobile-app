import 'package:flutter/material.dart';
import 'package:salon_app/screens/login.dart';

class SalonDetailsScreen extends StatefulWidget {
  const SalonDetailsScreen({super.key});

  @override
  _SalonDetailsScreenState createState() => _SalonDetailsScreenState();
}

class _SalonDetailsScreenState extends State<SalonDetailsScreen> {
  final _nameController = TextEditingController(text: 'Salon Name');
  final _descriptionController = TextEditingController(text: 'Salon Description');
  final List<Map<String, dynamic>> _openingDays = [
    {'day': 'Monday', 'checked': true, 'startHour': 8, 'startMin': 0, 'startPeriod': 'AM', 'endHour': 9, 'endMin': 0, 'endPeriod': 'PM', 'isEditing': false},
    {'day': 'Tuesday', 'checked': true, 'startHour': 8, 'startMin': 0, 'startPeriod': 'AM', 'endHour': 9, 'endMin': 0, 'endPeriod': 'PM', 'isEditing': false},
    {'day': 'Wednesday', 'checked': true, 'startHour': 8, 'startMin': 0, 'startPeriod': 'AM', 'endHour': 9, 'endMin': 0, 'endPeriod': 'PM', 'isEditing': false},
    {'day': 'Thursday', 'checked': true, 'startHour': 8, 'startMin': 0, 'startPeriod': 'AM', 'endHour': 9, 'endMin': 0, 'endPeriod': 'PM', 'isEditing': false},
    {'day': 'Friday', 'checked': true, 'startHour': 8, 'startMin': 0, 'startPeriod': 'AM', 'endHour': 9, 'endMin': 0, 'endPeriod': 'PM', 'isEditing': false},
    {'day': 'Saturday', 'checked': true, 'startHour': 8, 'startMin': 0, 'startPeriod': 'AM', 'endHour': 9, 'endMin': 0, 'endPeriod': 'PM', 'isEditing': false},
    {'day': 'Sunday', 'checked': false, 'startHour': 0, 'startMin': 0, 'startPeriod': 'AM', 'endHour': 0, 'endMin': 0, 'endPeriod': 'AM', 'isEditing': false},
  ];
  int _globalStartHour = 8, _globalStartMin = 0;
  String _globalStartPeriod = 'AM'; 
  int _globalEndHour = 9, _globalEndMin = 0;
  String _globalEndPeriod = 'PM'; 
  final List<String> _photos = [];
  final List<String> _services = ['Haircut', 'Coloring', 'Manicure'];
  final List<String> _employees = ['John Doe - Stylist', 'Jane Smith - Manager'];
  final List<String> _workStations = ['Station 1', 'Station 2'];

  bool _isEditing = false;

  void _showEditPopup(String field, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $field', style: const TextStyle(color: Colors.black)),
        content: TextField(
          controller: controller,
          maxLines: field == 'Description' ? 3 : 1,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.black54),
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel', style: TextStyle(color: Colors.black54)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {});
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[200],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Save', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  void _showTimeEditPopup({required int startHour, required int startMin, required String startPeriod, required int endHour, required int endMin, required String endPeriod, required Function(int, int, String, int, int, String) onSave}) {
    int tempStartHour = startHour;
    int tempStartMin = startMin;
    String tempStartPeriod = startPeriod;
    int tempEndHour = endHour;
    int tempEndMin = endMin;
    String tempEndPeriod = endPeriod;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Time', style: TextStyle(color: Colors.black)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                DropdownButton<int>(
                  value: tempStartHour * 2 + (tempStartMin ~/ 30),
                  items: List.generate(48, (index) {
                    int hour = index ~/ 2;
                    int minute = (index % 2) * 30;
                    String period = hour < 12 ? 'AM' : 'PM';
                    hour = hour > 12 ? hour - 12 : hour == 0 ? 12 : hour;
                    return DropdownMenuItem<int>(
                      value: index,
                      child: Text('$hour:${minute.toString().padLeft(2, '0')} $period', style: const TextStyle(fontSize: 14)),
                    );
                  }),
                  onChanged: (value) {
                    setState(() {
                      tempStartHour = (value! ~/ 2) % 24;
                      tempStartMin = (value % 2) * 30;
                      if (tempStartHour >= 12) {
                        tempStartPeriod = tempStartHour == 12 && tempStartMin == 0 ? 'PM' : 'AM';
                        if (tempStartHour > 12) tempStartHour -= 12;
                      } else {
                        tempStartPeriod = 'AM';
                      }
                      if (tempStartHour == 0) tempStartHour = 12;
                    });
                  },
                  dropdownColor: Colors.grey[200],
                  iconSize: 20,
                ),
                const SizedBox(width: 2),
                DropdownButton<String>(
                  value: tempStartPeriod,
                  items: ['AM', 'PM'].map((String period) {
                    return DropdownMenuItem<String>(
                      value: period,
                      child: Text(period, style: const TextStyle(color: Colors.black, fontSize: 14)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      tempStartPeriod = value!;
                      if (value == 'PM' && tempStartHour < 12) tempStartHour += 12;
                      if (value == 'AM' && tempStartHour > 12) tempStartHour -= 12;
                      if (tempStartHour == 24) tempStartHour = 12;
                    });
                  },
                  dropdownColor: Colors.grey[200],
                  iconSize: 20,
                ),
                const Text(' - ', style: TextStyle(color: Colors.black)),
                DropdownButton<int>(
                  value: tempEndHour * 2 + (tempEndMin ~/ 30),
                  items: List.generate(48, (index) {
                    int hour = index ~/ 2;
                    int minute = (index % 2) * 30;
                    String period = hour < 12 ? 'AM' : 'PM';
                    hour = hour > 12 ? hour - 12 : hour == 0 ? 12 : hour;
                    return DropdownMenuItem<int>(
                      value: index,
                      child: Text('$hour:${minute.toString().padLeft(2, '0')} $period', style: const TextStyle(fontSize: 14)),
                    );
                  }),
                  onChanged: (value) {
                    setState(() {
                      tempEndHour = (value! ~/ 2) % 24;
                      tempEndMin = (value % 2) * 30;
                      if (tempEndHour >= 12) {
                        tempEndPeriod = tempEndHour == 12 && tempEndMin == 0 ? 'PM' : 'AM';
                        if (tempEndHour > 12) tempEndHour -= 12;
                      } else {
                        tempEndPeriod = 'AM';
                      }
                      if (tempEndHour == 0) tempEndHour = 12;
                    });
                  },
                  dropdownColor: Colors.grey[200],
                  iconSize: 20,
                ),
                const SizedBox(width: 2),
                DropdownButton<String>(
                  value: tempEndPeriod,
                  items: ['AM', 'PM'].map((String period) {
                    return DropdownMenuItem<String>(
                      value: period,
                      child: Text(period, style: const TextStyle(color: Colors.black, fontSize: 14)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      tempEndPeriod = value!;
                      if (value == 'PM' && tempEndHour < 12) tempEndHour += 12;
                      if (value == 'AM' && tempEndHour > 12) tempEndHour -= 12;
                      if (tempEndHour == 24) tempEndHour = 12;
                    });
                  },
                  dropdownColor: Colors.grey[200],
                  iconSize: 20,
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel', style: TextStyle(color: Colors.black54)),
          ),
          ElevatedButton(
            onPressed: () {
              onSave(tempStartHour, tempStartMin, tempStartPeriod, tempEndHour, tempEndMin, tempEndPeriod);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[200],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Save', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  void _applyGlobalTime() {
    setState(() {
      _globalStartHour = 8;
      _globalStartMin = 0;
      _globalStartPeriod = 'AM';
      _globalEndHour = 9;
      _globalEndMin = 0;
      _globalEndPeriod = 'PM';
      for (var day in _openingDays) {
        if (day['checked']) {
          day['startHour'] = _globalStartHour;
          day['startMin'] = _globalStartMin;
          day['startPeriod'] = _globalStartPeriod;
          day['endHour'] = _globalEndHour;
          day['endMin'] = _globalEndMin;
          day['endPeriod'] = _globalEndPeriod;
        }
      }
    });
  }

  void _toggleEdit(int index) {
    setState(() {
      _openingDays[index]['isEditing'] = !_openingDays[index]['isEditing'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VIVORA', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Edit logo functionality to be implemented')),
                  );
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.grey[300]!, blurRadius: 4, offset: const Offset(0, 2)),
                    ],
                  ),
                  child: const Icon(Icons.store, color: Colors.black54, size: 50),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _nameController.text,
                    style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.black54),
                  onPressed: () => _showEditPopup('Name', _nameController),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _descriptionController.text,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.black54),
                  onPressed: () => _showEditPopup('Description', _descriptionController),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Opening Days Block
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(color: Colors.grey[300]!, blurRadius: 4, offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Opening Days',
                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Opening Hours',
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                      Row(
                        children: [
                          Text(
                            '${_globalStartHour.toString().padLeft(2, '0')}:${_globalStartMin.toString().padLeft(2, '0')} $_globalStartPeriod - '
                            '${_globalEndHour.toString().padLeft(2, '0')}:${_globalEndMin.toString().padLeft(2, '0')} $_globalEndPeriod',
                            style: const TextStyle(color: Colors.black54),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.black54),
                            onPressed: () => _showTimeEditPopup(
                              startHour: _globalStartHour,
                              startMin: _globalStartMin,
                              startPeriod: _globalStartPeriod,
                              endHour: _globalEndHour,
                              endMin: _globalEndMin,
                              endPeriod: _globalEndPeriod,
                              onSave: (startHour, startMin, startPeriod, endHour, endMin, endPeriod) {
                                setState(() {
                                  _globalStartHour = startHour;
                                  _globalStartMin = startMin;
                                  _globalStartPeriod = startPeriod;
                                  _globalEndHour = endHour;
                                  _globalEndMin = endMin;
                                  _globalEndPeriod = endPeriod;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 50,
                        child: ElevatedButton(
                          onPressed: _applyGlobalTime,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                          ),
                          child: const Text('Apply', style: TextStyle(color: Colors.black, fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Daily Availability',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Text(
                          'Days',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text(
                        'Time',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ..._openingDays.asMap().entries.map((entry) {
                    final index = entry.key;
                    final dayData = entry.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Checkbox(
                                  value: dayData['checked'],
                                  onChanged: (value) {
                                    setState(() {
                                      dayData['checked'] = value ?? false;
                                      if (!dayData['checked']) dayData['isEditing'] = false;
                                    });
                                  },
                                  activeColor: Colors.black,
                                  checkColor: Colors.white,
                                ),
                                Text(dayData['day'], style: const TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '${dayData['startHour'].toString().padLeft(2, '0')}:${dayData['startMin'].toString().padLeft(2, '0')} ${dayData['startPeriod']} - '
                                '${dayData['endHour'].toString().padLeft(2, '0')}:${dayData['endMin'].toString().padLeft(2, '0')} ${dayData['endPeriod']}',
                                style: const TextStyle(color: Colors.black54),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.black54),
                                onPressed: () => _showTimeEditPopup(
                                  startHour: dayData['startHour'],
                                  startMin: dayData['startMin'],
                                  startPeriod: dayData['startPeriod'],
                                  endHour: dayData['endHour'],
                                  endMin: dayData['endMin'],
                                  endPeriod: dayData['endPeriod'],
                                  onSave: (startHour, startMin, startPeriod, endHour, endMin, endPeriod) {
                                    setState(() {
                                      dayData['startHour'] = startHour;
                                      dayData['startMin'] = startMin;
                                      dayData['startPeriod'] = startPeriod;
                                      dayData['endHour'] = endHour;
                                      dayData['endMin'] = endMin;
                                      dayData['endPeriod'] = endPeriod;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 10),
                  Text(
                    'Current Date & Time: July 26, 2025, 10:43 AM +0530',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Save', style: TextStyle(color: Colors.black)),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Update', style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Add Photos Block
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(color: Colors.grey[300]!, blurRadius: 4, offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add Photos',
                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ..._photos.map((photo) => Container(
                              margin: const EdgeInsets.only(right: 10),
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                border: Border.all(color: Colors.black54),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(photo, fit: BoxFit.cover),
                            )),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _photos.add('assets/images/default_photo.png');
                            });
                          },
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.add, color: Colors.black54, size: 40),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Services Block
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(color: Colors.grey[300]!, blurRadius: 4, offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Services',
                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ..._services.map((service) => ListTile(
                        title: Text(service, style: const TextStyle(color: Colors.black)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.black54),
                              onPressed: () {
                                setState(() {
                                  _services.add('New Service');
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _services.remove(service);
                                });
                              },
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Employees Block
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(color: Colors.grey[300]!, blurRadius: 4, offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Employees',
                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ..._employees.map((employee) => ListTile(
                        title: Text(employee, style: const TextStyle(color: Colors.black)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.black54),
                              onPressed: () {
                                setState(() {
                                  _employees.add('New Employee - Role');
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _employees.remove(employee);
                                });
                              },
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Work Stations Block
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(color: Colors.grey[300]!, blurRadius: 4, offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Work Stations',
                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ..._workStations.map((station) => ListTile(
                        title: Text(station, style: const TextStyle(color: Colors.black)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.black54),
                              onPressed: () {
                                setState(() {
                                  _workStations.add('New Station');
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _workStations.remove(station);
                                });
                              },
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Back', style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}