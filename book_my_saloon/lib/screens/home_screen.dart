import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:book_my_saloon/utils/colors.dart';
import 'package:book_my_saloon/utils/styles.dart';
import 'package:book_my_saloon/widgets/saloon_card.dart';
import 'package:book_my_saloon/screens/salon_profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _salons = [
    {
      'name': 'Salon Senasha',
      'latitude': 6.9271,
      'longitude': 79.8612,
      'address': 'Shantha Kotagoda, Colombo',
      'hours': '8:00 am to 10:00 pm'
    },
    {
      'name': 'Dilianka Salon',
      'latitude': 6.9250,
      'longitude': 79.8600,
      'address': 'Colombo',
      'hours': '8:00 am to 10:00 pm'
    },
    {
      'name': 'Style Studio',
      'latitude': 6.9260,
      'longitude': 79.8620,
      'address': 'Colombo',
      'hours': '8:00 am to 10:00 pm'
    },
    {
      'name': "Dee's Hair Bea & Bridal Salon",
      'latitude': 6.9240,
      'longitude': 79.8630,
      'address': 'Colombo',
      'hours': '8:00 am to 10:00 pm'
    },
    {
      'name': 'Salon Sithru',
      'latitude': 6.9230,
      'longitude': 79.8590,
      'address': 'Piliyandala, Colombo',
      'hours': '8:00 am to 10:00 pm'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VIVORA', style: AppStyles.appBarStyle),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Implement logout functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search a Salon...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              flex: 2,
              child: FlutterMap(
                options: MapOptions(
                  center: latLng.LatLng(6.9271, 79.8612), // Colombo center
                  zoom: 13.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    userAgentPackageName: 'com.example.book_my_saloon', // Add this
                  ),
                  MarkerLayer(
                    markers: _salons.map((salon) => Marker(
                          point: latLng.LatLng(salon['latitude'], salon['longitude']),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SalonProfile(salonName: salon['name']),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 30.0,
                            ),
                          ),
                        )).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Nearby Saloons',
              style: AppStyles.sectionHeadingStyle,
            ),
            const SizedBox(height: 16),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: _salons.length,
                itemBuilder: (context, index) {
                  final salon = _salons[index];
                  return SaloonCard(
                    name: salon['name'],
                    address: salon['address'],
                    hours: salon['hours'],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SalonProfile(salonName: salon['name']),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}