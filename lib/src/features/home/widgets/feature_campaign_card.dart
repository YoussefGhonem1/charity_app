import 'package:flutter/material.dart';
import '../models/campaign_model.dart';

class FeatureCampaignCard extends StatelessWidget {
  final CampaignModel campaign;
  final bool isFavourite;
  final VoidCallback? onFavouriteTap;

  const FeatureCampaignCard({
    required this.campaign,
    this.isFavourite = false,
    this.onFavouriteTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFFE7277), width: 2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: (campaign.imageUrl.isNotEmpty)
                    ? Image.network(
                        campaign.imageUrl,
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
            campaign.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Text(
                "By ${campaign.organization}",
                style: TextStyle(fontSize: 12, color: Color(0xFFFE7277)),
              ),
              SizedBox(width: 3),
              Icon(Icons.verified, color: Color.fromARGB(255, 212, 109, 112), size: 15),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(
                "Raised",
                style: TextStyle(fontSize: 11, color: Colors.grey[500]),
              ),
              Spacer(),
              Text(
                "${(campaign.progress * 100).round()}%",
                style: TextStyle(fontSize: 11, color: Color(0xFFFE7277)),
              ),
            ],
          ),
          SizedBox(height: 3),
          LinearProgressIndicator(
            value: campaign.progress,
            color: Color(0xFFFE7277),
            backgroundColor: Colors.grey[200],
            minHeight: 4,
            borderRadius: BorderRadius.circular(3),
          ),
          SizedBox(height: 6),
          Row(
            children: [
              ...List.generate(
                3,
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
                "+${campaign.donatedAmount.toInt()} people donated",
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
                campaign.category,
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
                  campaign.location,
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