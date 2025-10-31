import '../../home/models/campaign_model.dart';

class CampaignRepository {
  CampaignRepository._();
  static final CampaignRepository instance = CampaignRepository._();

  final List<CampaignModel> featureCampaigns = [
    CampaignModel(
      "Donation for Child",
      "Unesco",
      0.5,
      12300,
      "Emergencies",
      "Africa / Namibia",
      "https://media.hawzahnews.com/d/2019/11/03/4/866306.jpg",
    ),
    CampaignModel(
      "Help for Families",
      "Unesco",
      0.7,
      4530,
      "Social project",
      "Europe / France",
      "https://ofhsoupkitchen.org/wp-content/uploads/2021/02/charity-bible-verses-1-1024x683.jpg",
    ),
    CampaignModel(
      "Orphans Charity",
      "Unesco",
      0.6,
      7800,
      "Emergencies",
      "Asia / Indonesia",
      "https://storage.googleapis.com/wp-static/wp-orphansinneed/2023/12/07b86145-giving-charity-ramadan.jpeg",
    ),
    CampaignModel(
      "Donation Drive",
      "Unesco",
      0.9,
      19000,
      "Medical",
      "Africa / Nigeria",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7csJ8xtOjTamjyw5sw84GqlRCUowlLOQF8w&s",
    ),
  ];

  final List<CampaignModel> latestCampaigns = [
    CampaignModel(
      "Donation for Child",
      "Unesco",
      0.5,
      12300,
      "Emergencies",
      "Africa / Namibia",
      "https://media.hawzahnews.com/d/2019/11/03/4/866306.jpg",
    ),
    CampaignModel(
      "School Library Project",
      "Unesco",
      0.7,
      6700,
      "Education",
      "Asia / Indonesia",
      "https://ofhsoupkitchen.org/wp-content/uploads/2021/02/charity-bible-verses-1-1024x683.jpg",
    ),
    CampaignModel(
      "Medical Aid Campaign",
      "Unesco",
      0.4,
      3200,
      "Medical",
      "Africa / Kenya",
      "https://storage.googleapis.com/wp-static/wp-orphansinneed/2023/12/07b86145-giving-charity-ramadan.jpeg",
    ),
    CampaignModel(
      "Clean Water Action",
      "Unesco",
      0.6,
      2100,
      "Environment",
      "Africa / Nigeria",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7csJ8xtOjTamjyw5sw84GqlRCUowlLOQF8w&s",
    ),
  ];
}


