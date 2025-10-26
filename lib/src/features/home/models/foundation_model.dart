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

  factory FoundationModel.fromJson(Map<String, dynamic> json) {
    return FoundationModel(
      title: json['title'] ?? '',
      organization: json['organization'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      location: json['location'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'organization': organization,
      'description': description,
      'category': category,
      'location': location,
      'imageUrl': imageUrl,
    };
  }
}