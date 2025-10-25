import 'package:flutter/material.dart';
import '../models/foundation_model.dart';
import 'foundation_card.dart';

class FoundationsList extends StatelessWidget {
  final List<FoundationModel> foundations;
  const FoundationsList({required this.foundations});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: foundations.length,
      itemBuilder: (context, index) => FoundationCard(foundation: foundations[index]),
    );
  }
}
