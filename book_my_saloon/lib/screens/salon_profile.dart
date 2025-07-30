import 'package:flutter/material.dart';
import 'booking_screen.dart';

class SalonProfile extends StatefulWidget {
  final String salonName;

  const SalonProfile({required this.salonName, Key? key}) : super(key: key);

  @override
  _SalonProfileState createState() => _SalonProfileState();
}

class _SalonProfileState extends State<SalonProfile> {
  late PageController _pageController;
  String selectedGender = 'Male'; // Default gender
  final TextEditingController _searchController = TextEditingController();

  // Service definitions based on gender
  Map<String, Map<String, dynamic>> genderServices = {
    'Male': {
      "Hair Cutting and Shaving": {"price": 100, "duration": 60},
      "Oil Massage": {"price": 200, "duration": 120},
      "Beard Trimming": {"price": 300, "duration": 180},
    },
    'Female': {
      "Hair Cutting and Shaving": {"price": 100, "duration": 60},
      "Oil Massage": {"price": 200, "duration": 120},
      "Beard Trimming": {"price": 300, "duration": 180},
      "Nail Painting": {"price": 400, "duration": 90},
    },
    'Children': {
      "Hair Cutting and Shaving": {"price": 50, "duration": 30},
    },
    'Unisex': {
      "Oil Massage": {"price": 200, "duration": 120},
    },
  };

  Map<String, bool> selectedServices = {};

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.7, // 70% of width for current image
    );
    // Initialize selected services with default gender (Male)
    selectedServices = genderServices['Male']!.map((key, value) => MapEntry(key, false));
    _searchController.addListener(_filterServices);
  }

  void _filterServices() {
    setState(() {
      if (_searchController.text.isEmpty) {
        selectedServices = genderServices[selectedGender]!.map((key, value) => MapEntry(key, selectedServices[key] ?? false));
      } else {
        selectedServices = Map.fromEntries(
          genderServices[selectedGender]!
              .map((key, value) => MapEntry(key, selectedServices[key] ?? false))
              .entries
              .where((entry) => entry.key.toLowerCase().contains(_searchController.text.toLowerCase()))
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _updateServices(String gender) {
    setState(() {
      selectedGender = gender;
      selectedServices = genderServices[gender]!.map((key, value) => MapEntry(key, false));
      _searchController.text = ''; // Clear search when gender changes
    });
  }

  int get totalCost => selectedServices.entries
      .where((e) => e.value)
      .map((e) => genderServices[selectedGender]![e.key]!['price'])
      .fold<num>(0, (a, b) => a + b).toInt();

  int get totalDuration => selectedServices.entries
      .where((e) => e.value)
      .map((e) => genderServices[selectedGender]![e.key]!['duration'])
      .fold<num>(0, (a, b) => a + b).toInt();

  @override
  Widget build(BuildContext context) {
    final List<String> salonImages = [
      'images/salon.jpg',
      'images/salon.jpg',
      'images/salon.jpg',
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Center(
                child: Text(
                  "VIVORA",
                  style: TextStyle(
                    fontFamily: 'VivoraFont',
                    fontSize: 28,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.salonName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      const Row(
                        children: [
                          Icon(Icons.location_on, size: 16),
                          SizedBox(width: 4),
                          Text("Colombo"),
                        ],
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16),
              // Horizontal Scrollable Image Gallery
              SizedBox(
                height: 200,
                child: PageView.builder(
                  itemCount: salonImages.length,
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, child) {
                        double value = 1.0;
                        if (_pageController.position.hasPixels) {
                          final double page = _pageController.page ?? 0;
                          value = page - index;
                          value = (1 - (value.abs() * 0.3)).clamp(0.7, 1.0); // Smooth scale transition
                        }
                        return Transform.scale(
                          scale: Curves.easeInOut.transform(value),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                salonImages[index],
                                fit: BoxFit.cover,
                                width: 200,
                                height: 200,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey,
                                    child: Center(child: Text('Image Error')),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              // Gender Selection with smaller buttons and adjusted spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['Male', 'Female', 'Children', 'Unisex'].map((gender) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0), // Reduced space between buttons
                    child: ElevatedButton(
                      onPressed: () => _updateServices(gender),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedGender == gender ? Colors.black : Colors.grey,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Smaller padding
                        textStyle: const TextStyle(fontSize: 12), // Smaller text
                      ),
                      child: Text(gender),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              // Service Search Bar
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search services...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text("Services",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...selectedServices.keys.map((service) {
                return CheckboxListTile(
                  title: Text(service),
                  subtitle: Text('Rs ${genderServices[selectedGender]![service]!['price']}'),
                  value: selectedServices[service],
                  onChanged: (bool? value) {
                    setState(() {
                      selectedServices[service] = value ?? false;
                    });
                  },
                );
              }).toList(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Duration",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Text("${(totalDuration / 60).toStringAsFixed(1)} hours",
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Text("Rs $totalCost",
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookingScreen(saloonName: widget.salonName)),
                  );
                },
                child: const Text("Proceed",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}