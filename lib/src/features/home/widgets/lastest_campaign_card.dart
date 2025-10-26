import 'package:flutter/material.dart';
import '../models/campaign_model.dart';

class LastestCampaignCard extends StatelessWidget {
  final CampaignModel campaign;
  final bool isFavourite;
  final VoidCallback? onFavouriteTap;

  const LastestCampaignCard({
    required this.campaign,
    this.isFavourite = false,
    this.onFavouriteTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Color(0xFFFE7277), width: 2),
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              campaign.imageUrl,
              height: 75,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(height: 75, color: Colors.grey[200], child: Icon(Icons.error)),
            ),
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Text(
                  campaign.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: onFavouriteTap,
                child: Icon(
                  isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: Color(0xFFFE7277),
                  size: 15,
                ),
              ),
            ],
          ),
          SizedBox(height: 2),
          Text(
            "By ${campaign.organization}",
            style: TextStyle(fontSize: 10, color: Color(0xFFFE7277)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Text(
                "Raised",
                style: TextStyle(fontSize: 10, color: Colors.grey[500]),
              ),
              Spacer(),
              Text(
                "${(campaign.progress * 100).round()}%",
                style: TextStyle(fontSize: 10, color: Color(0xFFFE7277)),
              ),
            ],
          ),
          SizedBox(height: 2),
          LinearProgressIndicator(
            value: campaign.progress,
            color: Color(0xFFFE7277),
            backgroundColor: Colors.grey[200],
            minHeight: 3,
            borderRadius: BorderRadius.circular(3),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              for (int idx = 0; idx < 3; idx++)
                Padding(
                  padding: EdgeInsets.only(right: 2),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/${17 + idx}.jpg"),
                  ),
                ),
              SizedBox(width: 3),
              Text(
                "+${campaign.donatedAmount.toInt()}",
                style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
