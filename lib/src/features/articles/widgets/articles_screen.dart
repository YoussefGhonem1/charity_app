import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/articles_cubit.dart';
import '../cubit/articles_state.dart';
import '../models/article_model.dart';
import 'article_item.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Articles",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: BlocBuilder<ArticlesCubit, ArticlesState>(
        builder: (context, state) {
          if (state is ArticlesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ArticlesError) {
            return Center(child: Text(state.message));
          }

          if (state is ArticlesLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                return ArticleItem(article: state.articles[index]);
              },
            );
          }

          return const Center(child: Text("No Data"));
        },
      ),
    );
  }
}
