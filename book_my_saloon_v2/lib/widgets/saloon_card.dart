import 'package:flutter/material.dart';
import 'package:book_my_saloon/utils/colors.dart';
import 'package:book_my_saloon/utils/styles.dart';

class SaloonCard extends StatelessWidget {
  final String name;
  final String address;
  final double rating;
  final VoidCallback onTap;

  const SaloonCard({
    Key? key,
    required this.name,
    required this.address,
    required this.rating,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.cut,
                  size: 40,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppStyles.sectionHeadingStyle,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      address,
                      style: AppStyles.subHeadingStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          rating.toStringAsFixed(1),
                          style: AppStyles.subHeadingStyle.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: AppColors.lightTextColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}