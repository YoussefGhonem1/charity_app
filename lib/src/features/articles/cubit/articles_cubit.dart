import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/article_model.dart';
import 'articles_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  ArticlesCubit() : super(ArticlesLoading());

  Future<void> getArticles() async {
    try {
      final data = await FirebaseFirestore.instance
          .collection('articles')
          .orderBy('createdAt', descending: true)
          .get();

      final articles = data.docs
          .map((doc) => ArticleModel.fromJson(doc.data()))
          .toList();

      emit(ArticlesLoaded(articles));
    } catch (e) {
      emit(ArticlesError(e.toString()));
    }
  }
}
