import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:book_my_saloon/utils/colors.dart';
import 'package:book_my_saloon/utils/styles.dart';
import 'package:book_my_saloon/widgets/custom_button.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final String saloonName;
  final String service;
  final DateTime date;
  final TimeOfDay time;

  const BookingConfirmationScreen({
    Key? key,
    required this.saloonName,
    required this.service,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmation', style: AppStyles.appBarStyle),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking Details',
              style: AppStyles.headingStyle,
            ),
            const SizedBox(height: 20),
            _buildDetailRow('Saloon:', saloonName),
            _buildDetailRow('Service:', service),
            _buildDetailRow(
              'Date:', 
              DateFormat('MMM dd, yyyy').format(date),
            ),
            _buildDetailRow(
              'Time:', 
              time.format(context),
            ),
            const Spacer(),
            CustomButton(
              text: 'Confirm Booking',
              onPressed: () {
                // Save booking and navigate
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: AppStyles.subHeadingStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: AppStyles.subHeadingStyle,
          ),
        ],
      ),
    );
  }
}