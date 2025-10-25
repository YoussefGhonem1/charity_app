class CampaignModel {
  final String title;
  final String organization;
  final double progress;
  final double donatedAmount;
  final String category;
  final String location;
  final String imageUrl;
  final String imageUrl1;
  final String period;
  final double amount;
  final String story;
  final int numberOfPeopleDenoted;

  CampaignModel(
      this.title,
      this.organization,
      this.progress,
      this.donatedAmount,
      this.category,
      this.location,
      this.imageUrl,
      this.imageUrl1,
      this.period,
      this.amount,
      this.story,
      this.numberOfPeopleDenoted,
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
      data['imageUrl1'] ?? '',
      data['period'] ?? '',
      (data['amount'] as num?)?.toDouble() ?? 0.0,
      data['story'] ?? '',
      (data['number_of_people_denoted'] as int?) ?? 0,
    );
  }
}
