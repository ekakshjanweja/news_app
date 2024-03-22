import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_lokal/features/news/repository/news_repository.dart';
import 'package:news_app_lokal/models/article_model.dart';

final newsControllerProvider = Provider<NewsController>(
  (ref) => NewsController(
    newsRepository: ref.read(newsRepositoryProvider),
  ),
);

class NewsController {
  final NewsRepository _newsRepository;

  NewsController({required NewsRepository newsRepository})
      : _newsRepository = newsRepository;

  Future<List<ArticleModel>?> getArticles({
    required BuildContext context,
    required String query,
    required String country,
    required bool topHeadlines,
  }) async {
    final result = await _newsRepository.getArticles(
      query: query,
      country: country,
      topHeadlines: topHeadlines,
    );

    return result.fold((l) {
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) => ErrorPage(failure: l),
      // ));
      return null;
    }, (r) => r);
  }
}
