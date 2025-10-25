import 'package:flutter/material.dart';
import '../models/foundation_model.dart';

class FoundationCard extends StatelessWidget {
  final FoundationModel foundation;
  FoundationCard({required this.foundation});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Image.network(foundation.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
        title: Text(foundation.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(foundation.organization),
            Text(foundation.description, maxLines: 2, overflow: TextOverflow.ellipsis),
            Text('${foundation.category} - ${foundation.location}', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
