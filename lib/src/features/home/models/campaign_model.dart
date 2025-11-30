class CampaignModel {
  final String id; 
  final String title;
  final String organization;
  final double progress;
  final double donatedAmount;
  final double amount; 
  final double currentAmount;
  final String category;
  final String location;
  final String imageUrl;
  final String? imageUrl1;
  final String? story;
  final String? period;

  CampaignModel({
    required this.id, 
    required this.title,
    required this.organization,
    required this.progress,
    required this.donatedAmount,
    required this.amount,
    required this.currentAmount,
    required this.category,
    required this.location,
    required this.imageUrl,
    this.imageUrl1,
    this.story,
    this.period,
  });

  factory CampaignModel.fromFirestore(String id, Map<String, dynamic> data) { 
    double toDouble(dynamic value) {
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return CampaignModel(
      id: id,
      title: data['title'] ?? '',
      organization: data['organization'] ?? '',
      progress: toDouble(data['progress']),
      donatedAmount: toDouble(data['donatedAmount']),
      amount: toDouble(data['amount']),
      currentAmount: toDouble(data['currentAmount']),
      category: data['category'] ?? '',
      location: data['location'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      imageUrl1: data['imageUrl1'],
      story: data['story'],
      period: data['period'],
    );
  }
}