import 'package:charity/src/features/home/models/foundation_model.dart';
import 'package:flutter/material.dart';

class FoundationCard extends StatelessWidget {
  final FoundationModel foundation;
  final bool isFavourite;
  final VoidCallback? onFavouriteTap;
  FoundationCard({
    required this.foundation,
    this.isFavourite = false,
    this.onFavouriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFFE7277), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: (foundation.imageUrl.isNotEmpty)
                    ? Image.network(
                        foundation.imageUrl,
                        width: double.infinity,
                        height: 125,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/image1170x530cropped.jpg',
                        width: double.infinity,
                        height: 125,
                        fit: BoxFit.cover,
                      ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onFavouriteTap,
                  child: Icon(
                    isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: Color(0xFFFE7277),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            foundation.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6),
          Row(
            children: [
              ...List.generate(
                2,
                (idx) => Padding(
                  padding: EdgeInsets.only(right: 2),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/women/${30 + idx}.jpg",
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4),
              Text(
                "+ 50000 people donated",
                style: TextStyle(fontSize: 11, color: Colors.grey[800]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Text(
                foundation.organization,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFFFE7277),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.folder, color: Color(0xFFFE7277), size: 15),
            ],
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.grey[600], size: 15),
              SizedBox(width: 4),
              Flexible(
                child: Text(
                  foundation.location,
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
