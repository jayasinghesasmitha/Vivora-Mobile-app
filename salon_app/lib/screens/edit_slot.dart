import 'package:flutter/material.dart';

class EditSlotScreen extends StatefulWidget {
  const EditSlotScreen({super.key});

  @override
  _EditSlotScreenState createState() => _EditSlotScreenState();
}

class _EditSlotScreenState extends State<EditSlotScreen> {
  DateTime selectedDate = DateTime(2025, 7, 29);
  String selectedTime = '08:00 AM';
  List<bool> employeeAvailability = [true, true, true];

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
            const Text('Edit Time Slot', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Date:', style: TextStyle(color: Colors.black)),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2025),
                      lastDate: DateTime(2026),
                    );
                    if (picked != null) setState(() => selectedDate = picked);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('${selectedDate.day}/${selectedDate.month}/${selectedDate.year}', style: const TextStyle(color: Colors.black)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Time:', style: TextStyle(color: Colors.black)),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedTime,
                  items: List.generate(16, (index) {
                    final hour = 8 + (index ~/ 2);
                    final minute = (index % 2) * 30;
                    return DropdownMenuItem<String>(
                      value: '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} ${hour < 12 ? 'AM' : 'PM'}',
                      child: Text('${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} ${hour < 12 ? 'AM' : 'PM'}', style: const TextStyle(color: Colors.black)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTime = newValue!;
                    });
                  },
                  dropdownColor: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Employee Availability:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ...List.generate(3, (index) => Row(
                  children: [
                    Checkbox(
                      value: employeeAvailability[index],
                      onChanged: (bool? value) {
                        setState(() {
                          employeeAvailability[index] = value ?? false;
                        });
                      },
                      activeColor: Colors.black,
                      checkColor: Colors.white,
                    ),
                    Text(['John Doe', 'Jane Smith', 'Mike Johnson'][index], style: const TextStyle(color: Colors.black)),
                  ],
                )),
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
                child: const Text('Save Changes', style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}