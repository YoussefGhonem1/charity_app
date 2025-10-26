import 'package:charity/src/features/home/widgets/foundation_card';
import 'package:flutter/material.dart';
import '../models/foundation_model.dart';

class FoundationsList extends StatelessWidget {
  final List<FoundationModel> foundations;
  const FoundationsList({required this.foundations, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: foundations.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: FoundationCard(foundation: foundations[index]),
        ),
      ),
    );
  }
}
