import 'package:flutter/material.dart';
import '../models/location_model.dart';

class LocationChip extends StatelessWidget {
  final LocationModel location;

  const LocationChip({required this.location, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 26, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1.6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        location.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.black,
        ),
      ),
    );
  }
}
