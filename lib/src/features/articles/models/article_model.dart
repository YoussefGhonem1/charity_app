class ArticleModel {
  final String title;
  final String content;
  final String imageUrl;
  final String createdAt;

  ArticleModel({
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}
