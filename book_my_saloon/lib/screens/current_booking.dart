import 'package:flutter/material.dart';
import 'package:book_my_saloon/screens/home_screen.dart';

class CurrentBooking extends StatelessWidget {
  const CurrentBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simulating a list of bookings (replace with actual data source)
    List<Map<String, String>> bookings = []; // Empty list for no bookings

    return Scaffold(
      appBar: AppBar(
        title: const Text('VIVORA', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: bookings.isEmpty
                  ? const Center(child: Text('There are no booking yet'))
                  : ListView.builder(
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        final booking = bookings[index];
                        return Card(
                          child: ListTile(
                            title: Text(booking['salonName'] ?? ''),
                            subtitle: Text('Time: ${booking['time'] ?? ''}\nDate: ${booking['date'] ?? ''}'),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Text('Back to Home'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}