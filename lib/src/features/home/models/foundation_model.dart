class FoundationModel {
  final String title;
  final String organization;
  final String description;
  final String category;
  final String location;
  final String imageUrl;

  FoundationModel({
    required this.title,
    required this.organization,
    required this.description,
    required this.category,
    required this.location,
    required this.imageUrl,
  });

 factory FoundationModel.fromJson(Map<String, dynamic> data) {
  return FoundationModel(
    title: data['title']?.toString().trim() ?? '',
    organization: data['organization']?.toString().trim() ?? '',
    description: data['description']?.toString().trim() ?? '',
    category: data['category']?.toString().trim() ?? '',
    location: data['location']?.toString().trim() ?? '',
    imageUrl: data['imageUrl']?.toString().trim() ?? '',
  );
}
}
