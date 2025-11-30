import '../models/article_model.dart';

abstract class ArticlesState {}

class ArticlesLoading extends ArticlesState {}

class ArticlesLoaded extends ArticlesState {
  final List<ArticleModel> articles;
  ArticlesLoaded(this.articles);
}

class ArticlesError extends ArticlesState {
  final String message;
  ArticlesError(this.message);
}
