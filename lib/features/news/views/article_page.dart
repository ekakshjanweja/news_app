import 'package:flutter/material.dart';
import 'package:news_app_lokal/models/article_model.dart';

class ArticlePage extends StatelessWidget {
  final ArticleModel articleModel;
  const ArticlePage({
    super.key,
    required this.articleModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Text(articleModel.content!)],
      ),
    );
  }
}
