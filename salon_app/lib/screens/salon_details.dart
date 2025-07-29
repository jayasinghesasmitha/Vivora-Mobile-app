import 'package:flutter/material.dart';
import 'package:salon_app/screens/time_schedule.dart';


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
  final List<Map<String, dynamic>> _services = [
    {'service': 'Haircut', 'price': 500, 'time': '1 hr', 'userCategories': ['male', 'female']},
    {'service': 'Coloring', 'price': 1500, 'time': '2 hrs', 'userCategories': ['female']},
    {'service': 'Manicure', 'price': 300, 'time': '45 mins', 'userCategories': ['female', 'children']}
  ];
  final List<Map<String, dynamic>> _employees = [
    {'name': 'John Doe - Stylist', 'image': 'images/salon_image.jpg', 'contact': '1234567890', 'email': 'john@example.com', 'bio': 'Experienced stylist', 'services': ['Haircut', 'Coloring']},
    {'name': 'Jane Smith - Manager', 'image': 'images/salon_image.jpg', 'contact': '0987654321', 'email': 'jane@example.com', 'bio': 'Dedicated manager', 'services': ['Manicure']}
  ];
  final List<Map<String, dynamic>> _workStations = [
    {'name': 'Station 1', 'description': 'Description for Station 1', 'services': ['Haircut', 'Coloring']},
    {'name': 'Station 2', 'description': 'Description for Station 2', 'services': ['Manicure']}
  ];
  bool _showPrices = false;

  bool _isEditing = false;

  void _showEditPopup(String field, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $field', style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        content: TextField(
          controller: controller,
          maxLines: field == 'Description' ? 3 : 1,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.black54),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(backgroundColor: Colors.white),
            child: const Text('Cancel', style: TextStyle(color: Colors.black54)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {});
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
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
        backgroundColor: Colors.white,
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
                  dropdownColor: Colors.white,
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
                  dropdownColor: Colors.white,
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
                  dropdownColor: Colors.white,
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
                  dropdownColor: Colors.white,
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
            style: TextButton.styleFrom(backgroundColor: Colors.white),
            child: const Text('Cancel', style: TextStyle(color: Colors.black54)),
          ),
          ElevatedButton(
            onPressed: () {
              onSave(tempStartHour, tempStartMin, tempStartPeriod, tempEndHour, tempEndMin, tempEndPeriod);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
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

  void _showServiceEditPopup({int? index}) {
    final TextEditingController _serviceController = TextEditingController(text: index != null ? _services[index]['service'] : '');
    final TextEditingController _priceController = TextEditingController(text: index != null ? _services[index]['price'].toString() : '');
    final TextEditingController _timeController = TextEditingController(text: index != null ? _services[index]['time'] : '');
    List<String> selectedCategories = index != null ? List.from(_services[index]['userCategories']) : [];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index != null ? 'Edit Service' : 'Add New Service', style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _serviceController,
                    decoration: InputDecoration(
                      labelText: 'Service',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      labelText: 'Price (Rs)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _timeController,
                    decoration: InputDecoration(
                      labelText: 'Time',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('User Category', style: TextStyle(fontWeight: FontWeight.bold)),
                  ...['male', 'female', 'children', 'unisex'].map((category) => CheckboxListTile(
                        title: Text(category),
                        value: selectedCategories.contains(category),
                        onChanged: (bool? value) {
                          setDialogState(() {
                            if (value == true) {
                              if (!selectedCategories.contains(category)) {
                                selectedCategories.add(category);
                              }
                            } else {
                              selectedCategories.remove(category);
                            }
                          });
                        },
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                      )),
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(backgroundColor: Colors.white),
            child: const Text('Cancel', style: TextStyle(color: Colors.black54)),
          ),
          ElevatedButton(
            onPressed: () {
              if (_serviceController.text.isNotEmpty &&
                  _priceController.text.isNotEmpty &&
                  _timeController.text.isNotEmpty &&
                  selectedCategories.isNotEmpty) {
                setState(() {
                  if (index != null) {
                    _services[index] = {
                      'service': _serviceController.text,
                      'price': int.tryParse(_priceController.text) ?? 0,
                      'time': _timeController.text,
                      'userCategories': selectedCategories,
                    };
                  } else {
                    _services.add({
                      'service': _serviceController.text,
                      'price': int.tryParse(_priceController.text) ?? 0,
                      'time': _timeController.text,
                      'userCategories': selectedCategories,
                    });
                  }
                });
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill all fields and select at least one category')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(index != null ? 'Save' : 'Add', style: const TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  void _showEmployeePopup({int? index}) {
    final TextEditingController _nameController = TextEditingController(text: index != null ? _employees[index]['name'] : '');
    final TextEditingController _contactController = TextEditingController(text: index != null ? _employees[index]['contact'] : '');
    final TextEditingController _emailController = TextEditingController(text: index != null ? _employees[index]['email'] : '');
    final TextEditingController _bioController = TextEditingController(text: index != null ? _employees[index]['bio'] : '');
    String _imagePath = index != null ? _employees[index]['image'] : 'images/salon_image.jpg';
    List<String> selectedServices = index != null ? List.from(_employees[index]['services']) : [];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index != null ? 'Edit Employee' : 'Add New Employee', style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      setDialogState(() {
                        _imagePath = 'images/salon_image.jpg';
                      });
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          _imagePath,
                          height: 100,
                          width: 100,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error, color: Colors.red);
                          },
                        ),
                        const Text('Tap to change image', style: TextStyle(color: Colors.black54)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _contactController,
                    decoration: InputDecoration(
                      labelText: 'Contact Number',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _bioController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Bio',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Services', style: TextStyle(fontWeight: FontWeight.bold)),
                  ..._services.map((service) => CheckboxListTile(
                        title: Text(service['service']),
                        value: selectedServices.contains(service['service']),
                        onChanged: (bool? value) {
                          setDialogState(() {
                            if (value == true) {
                              if (!selectedServices.contains(service['service'])) {
                                selectedServices.add(service['service']);
                              }
                            } else {
                              selectedServices.remove(service['service']);
                            }
                          });
                        },
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                      )),
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(backgroundColor: Colors.white),
            child: const Text('Cancel', style: TextStyle(color: Colors.black54)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (index != null) {
                  _employees[index] = {
                    'name': _nameController.text,
                    'image': _imagePath,
                    'contact': _contactController.text,
                    'email': _emailController.text,
                    'bio': _bioController.text,
                    'services': selectedServices,
                  };
                } else {
                  _employees.add({
                    'name': _nameController.text,
                    'image': _imagePath,
                    'contact': _contactController.text,
                    'email': _emailController.text,
                    'bio': _bioController.text,
                    'services': selectedServices,
                  });
                }
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(index != null ? 'Save and Update' : 'Add', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  void _showAddWorkStationPopup() {
    final TextEditingController _nameController = TextEditingController();
    List<String> selectedServices = [];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add Workstation',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Services',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 10),
              ..._services.map((service) => StatefulBuilder(
                    builder: (context, setState) => CheckboxListTile(
                      title: Text(service['service']),
                      value: selectedServices.contains(service['service']),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            if (!selectedServices.contains(service['service'])) {
                              selectedServices.add(service['service']);
                            }
                          } else {
                            selectedServices.remove(service['service']);
                          }
                        });
                      },
                      activeColor: Colors.black,
                      checkColor: Colors.white,
                    ),
                  )),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                    child: const Text('Cancel', style: TextStyle(color: Colors.black54)),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_nameController.text.isNotEmpty && selectedServices.isNotEmpty) {
                        setState(() {
                          _workStations.add({
                            'name': _nameController.text,
                            'description': '',
                            'services': selectedServices,
                          });
                        });
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fill the name and select at least one service')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Save', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditWorkStationPopup(int index) {
    final TextEditingController _nameController = TextEditingController(text: _workStations[index]['name']);
    List<String> selectedServices = List.from(_workStations[index]['services']);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Edit Workstation',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Services',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 10),
              ..._services.map((service) => StatefulBuilder(
                    builder: (context, setState) => CheckboxListTile(
                      title: Text(service['service']),
                      value: selectedServices.contains(service['service']),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            if (!selectedServices.contains(service['service'])) {
                              selectedServices.add(service['service']);
                            }
                          } else {
                            selectedServices.remove(service['service']);
                          }
                        });
                      },
                      activeColor: Colors.black,
                      checkColor: Colors.white,
                    ),
                  )),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                    child: const Text('Cancel', style: TextStyle(color: Colors.black54)),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_nameController.text.isNotEmpty && selectedServices.isNotEmpty) {
                        setState(() {
                          _workStations[index] = {
                            'name': _nameController.text,
                            'description': '',
                            'services': selectedServices,
                          };
                        });
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fill the name and select at least one service')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Save', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
                    color: Colors.white,
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
                color: Colors.white,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text(
                          'Opening Hours',
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 50,
                        child: ElevatedButton(
                          onPressed: _applyGlobalTime,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
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
                    'Current Date & Time: July 29, 2025, 04:19 PM +0530',
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
                          backgroundColor: Colors.white,
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
                          backgroundColor: Colors.white,
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
                color: Colors.white,
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
                                color: Colors.white,
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
                              color: Colors.white,
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
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey[300]!, blurRadius: 4, offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Services',
                      style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: _showPrices,
                        onChanged: (value) {
                          setState(() {
                            _showPrices = value ?? false;
                          });
                        },
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                      ),
                      const Text('Show Prices', style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Expanded(child: Text('Service', style: TextStyle(fontWeight: FontWeight.bold))),
                      if (_showPrices) const Expanded(child: Text('Price (Rs)', style: TextStyle(fontWeight: FontWeight.bold))),
                      const Expanded(child: Text('Time', style: TextStyle(fontWeight: FontWeight.bold))),
                      const Expanded(child: Text('User Category', style: TextStyle(fontWeight: FontWeight.bold))),
                      const SizedBox(width: 80), // Space for icons
                    ],
                  ),
                  const SizedBox(height: 10),
                  ..._services.map((service) => Row(
                        children: [
                          Expanded(child: Text(service['service'], style: const TextStyle(color: Colors.black))),
                          if (_showPrices) Expanded(child: Text(service['price'].toString(), style: const TextStyle(color: Colors.black))),
                          Expanded(child: Text(service['time'], style: const TextStyle(color: Colors.black))),
                          Expanded(child: Text(service['userCategories'].join(', '), style: const TextStyle(color: Colors.black))),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.black54),
                                onPressed: () => _showServiceEditPopup(index: _services.indexOf(service)),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    _services.remove(service);
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      )),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _showServiceEditPopup(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Add New Service', style: TextStyle(color: Colors.black)),
                    ),
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
                          backgroundColor: Colors.white,
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
                          backgroundColor: Colors.white,
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
            // Employees Block
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey[300]!, blurRadius: 4, offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Employees',
                      style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _showEmployeePopup(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Add New Employee', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Available Employees',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  ..._employees.map((employee) => ListTile(
                        tileColor: Colors.white,
                        leading: Image.asset(
                          employee['image'],
                          height: 50,
                          width: 50,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error, color: Colors.red);
                          },
                        ),
                        title: Text(employee['name'], style: const TextStyle(color: Colors.black)),
                        subtitle: Text('${employee['contact']} | ${employee['email']}', style: const TextStyle(color: Colors.black54)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.black54),
                              onPressed: () => _showEmployeePopup(index: _employees.indexOf(employee)),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _employees.remove(employee);
                                });
                              },
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
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
                          backgroundColor: Colors.white,
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
            // Work Stations Block
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey[300]!, blurRadius: 4, offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Workstations',
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.black54),
                        onPressed: () => _showEditWorkStationPopup(0), // Edit first workstation by default
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: _showAddWorkStationPopup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Add Workstation', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ..._workStations.map((station) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            station['name'],
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Services: ${station['services'].join(', ')}',
                            style: const TextStyle(color: Colors.black54),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.black54),
                                onPressed: () => _showEditWorkStationPopup(_workStations.indexOf(station)),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    _workStations.remove(station);
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      )),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
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
                          backgroundColor: Colors.white,
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
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const TimeScheduleScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Next', style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}