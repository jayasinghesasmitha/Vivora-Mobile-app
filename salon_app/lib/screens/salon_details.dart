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
    {'day': 'Monday', 'checked': true, 'startHour': 9, 'startMin': 0, 'startPeriod': 'AM', 'endHour': 6, 'endMin': 0, 'endPeriod': 'PM'},
    {'day': 'Tuesday', 'checked': true, 'startHour': 9, 'startMin': 0, 'startPeriod': 'AM', 'endHour': 6, 'endMin': 0, 'endPeriod': 'PM'},
    {'day': 'Wednesday', 'checked': true, 'startHour': 9, 'startMin': 0, 'startPeriod': 'AM', 'endHour': 6, 'endMin': 0, 'endPeriod': 'PM'},
    {'day': 'Thursday', 'checked': true, 'startHour': 9, 'startMin': 0, 'startPeriod': 'AM', 'endHour': 6, 'endMin': 0, 'endPeriod': 'PM'},
    {'day': 'Friday', 'checked': true, 'startHour': 9, 'startMin': 0, 'startPeriod': 'AM', 'endHour': 6, 'endMin': 0, 'endPeriod': 'PM'},
    {'day': 'Saturday', 'checked': true, 'startHour': 9, 'startMin': 0, 'startPeriod': 'AM', 'endHour': 6, 'endMin': 0, 'endPeriod': 'PM'},
    {'day': 'Sunday', 'checked': false, 'startHour': 0, 'startMin': 0, 'startPeriod': 'AM', 'endHour': 0, 'endMin': 0, 'endPeriod': 'AM'},
  ];
  int _commonStartHour = 9, _commonStartMin = 0;
  String _commonStartPeriod = 'AM';
  int _commonEndHour = 6, _commonEndMin = 0;
  String _commonEndPeriod = 'PM';
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

  void _applyCommonTime() {
    setState(() {
      for (var day in _openingDays) {
        if (day['checked']) {
          day['startHour'] = _commonStartHour;
          day['startMin'] = _commonStartMin;
          day['startPeriod'] = _commonStartPeriod;
          day['endHour'] = _commonEndHour;
          day['endMin'] = _commonEndMin;
          day['endPeriod'] = _commonEndPeriod;
        }
      }
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
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            ..._openingDays.map((dayData) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: dayData['checked'],
                                        onChanged: (value) {
                                          setState(() {
                                            dayData['checked'] = value ?? false;
                                          });
                                        },
                                        activeColor: Colors.black,
                                        checkColor: Colors.white,
                                      ),
                                      Text(dayData['day'], style: const TextStyle(color: Colors.black)),
                                      const SizedBox(width: 10),
                                      if (dayData['checked']) ...[
                                        SizedBox(
                                          width: 40,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                                borderSide: BorderSide(color: Colors.black54),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: TextEditingController(text: dayData['startHour'].toString()),
                                            onChanged: (value) {
                                              dayData['startHour'] = int.tryParse(value) ?? 0;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 2),
                                        SizedBox(
                                          width: 40,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                                borderSide: BorderSide(color: Colors.black54),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: TextEditingController(text: dayData['startMin'].toString()),
                                            onChanged: (value) {
                                              dayData['startMin'] = int.tryParse(value) ?? 0;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 2),
                                        DropdownButton<String>(
                                          value: dayData['startPeriod'],
                                          items: ['AM', 'PM'].map((String period) {
                                            return DropdownMenuItem<String>(
                                              value: period,
                                              child: Text(period, style: const TextStyle(color: Colors.black)),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              dayData['startPeriod'] = value!;
                                            });
                                          },
                                          dropdownColor: Colors.grey[200],
                                          iconSize: 20,
                                        ),
                                        const Text(' - ', style: TextStyle(color: Colors.black)),
                                        SizedBox(
                                          width: 40,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                                borderSide: BorderSide(color: Colors.black54),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: TextEditingController(text: dayData['endHour'].toString()),
                                            onChanged: (value) {
                                              dayData['endHour'] = int.tryParse(value) ?? 0;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 2),
                                        SizedBox(
                                          width: 40,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                                borderSide: BorderSide(color: Colors.black54),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: TextEditingController(text: dayData['endMin'].toString()),
                                            onChanged: (value) {
                                              dayData['endMin'] = int.tryParse(value) ?? 0;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 2),
                                        DropdownButton<String>(
                                          value: dayData['endPeriod'],
                                          items: ['AM', 'PM'].map((String period) {
                                            return DropdownMenuItem<String>(
                                              value: period,
                                              child: Text(period, style: const TextStyle(color: Colors.black)),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              dayData['endPeriod'] = value!;
                                            });
                                          },
                                          dropdownColor: Colors.grey[200],
                                          iconSize: 20,
                                        ),
                                      ],
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Common Time Period', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(6)),
                                        borderSide: BorderSide(color: Colors.black54),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                    ),
                                    keyboardType: TextInputType.number,
                                    controller: TextEditingController(text: _commonStartHour.toString()),
                                    onChanged: (value) {
                                      _commonStartHour = int.tryParse(value) ?? 0;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 2),
                                SizedBox(
                                  width: 40,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(6)),
                                        borderSide: BorderSide(color: Colors.black54),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                    ),
                                    keyboardType: TextInputType.number,
                                    controller: TextEditingController(text: _commonStartMin.toString()),
                                    onChanged: (value) {
                                      _commonStartMin = int.tryParse(value) ?? 0;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 2),
                                DropdownButton<String>(
                                  value: _commonStartPeriod,
                                  items: ['AM', 'PM'].map((String period) {
                                    return DropdownMenuItem<String>(
                                      value: period,
                                      child: Text(period, style: const TextStyle(color: Colors.black)),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _commonStartPeriod = value!;
                                    });
                                  },
                                  dropdownColor: Colors.grey[200],
                                  iconSize: 20,
                                ),
                                const Text(' - ', style: TextStyle(color: Colors.black)),
                                SizedBox(
                                  width: 40,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(6)),
                                        borderSide: BorderSide(color: Colors.black54),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                    ),
                                    keyboardType: TextInputType.number,
                                    controller: TextEditingController(text: _commonEndHour.toString()),
                                    onChanged: (value) {
                                      _commonEndHour = int.tryParse(value) ?? 0;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 2),
                                SizedBox(
                                  width: 40,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(6)),
                                        borderSide: BorderSide(color: Colors.black54),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                    ),
                                    keyboardType: TextInputType.number,
                                    controller: TextEditingController(text: _commonEndMin.toString()),
                                    onChanged: (value) {
                                      _commonEndMin = int.tryParse(value) ?? 0;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 2),
                                DropdownButton<String>(
                                  value: _commonEndPeriod,
                                  items: ['AM', 'PM'].map((String period) {
                                    return DropdownMenuItem<String>(
                                      value: period,
                                      child: Text(period, style: const TextStyle(color: Colors.black)),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _commonEndPeriod = value!;
                                    });
                                  },
                                  dropdownColor: Colors.grey[200],
                                  iconSize: 20,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: _applyCommonTime,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              ),
                              child: const Text('Apply', style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Current Date & Time: July 25, 2025, 11:17 PM +0530',
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