class CampaignModel {
  final String title;
  final String organization;
  final double progress;
  final double donatedAmount;
  final String category;
  final String location;
  final String imageUrl;

  CampaignModel(
      this.title,
      this.organization,
      this.progress,
      this.donatedAmount,
      this.category,
      this.location,
      this.imageUrl,
      );

  factory CampaignModel.fromFirestore(Map<String, dynamic> data) {
    return CampaignModel(
      data['title'] ?? '',
      data['organization'] ?? '',
      (data['progress'] as num?)?.toDouble() ?? 0.0,
      (data['donatedAmount'] as num?)?.toDouble() ?? 0.0,
      data['category'] ?? '',
      data['location'] ?? '',
      data['imageUrl'] ?? '',
    );
  }
}
