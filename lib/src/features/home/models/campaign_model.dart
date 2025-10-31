class CampaignModel {
  final String title;
  final String organization;
  final double progress;
  final double donatedAmount;
  final double amount;
  final String category;
  final String location;
  final String imageUrl;
  final String? imageUrl1;
  final String? story;
  final String? period;

  CampaignModel({
    required this.title,
    required this.organization,
    required this.progress,
    required this.donatedAmount,
    required this.amount,
    required this.category,
    required this.location,
    required this.imageUrl,
    this.imageUrl1,
    this.story,
    this.period,
  });
factory CampaignModel.fromFirestore(Map<String, dynamic> data) {
  double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  return CampaignModel(
    title: data['title'] ?? '',
    organization: data['organization'] ?? '',
    progress: _toDouble(data['progress']),
    donatedAmount: _toDouble(data['donatedAmount']),
    amount: _toDouble(data['amount']),
    category: data['category'] ?? '',
    location: data['location'] ?? '',
    imageUrl: data['imageUrl'] ?? '',
    imageUrl1: data['imageUrl1'],
    story: data['story'],
    period: data['period'],
  );
}

}
