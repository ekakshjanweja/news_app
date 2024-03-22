import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:news_app_lokal/core/api.dart';
import 'package:news_app_lokal/core/failure.dart';
import 'package:news_app_lokal/core/type_defs.dart';
import 'package:news_app_lokal/models/article_model.dart';

final newsRepositoryProvider = Provider<NewsRepository>(
  (ref) => NewsRepository(),
);

class NewsRepository {
  final Api _api = Api();

  FutureEither<List<ArticleModel>> getArticles({
    required String query,
    required String country,
    required bool topHeadlines,
  }) async {
    try {
      Response response;
      if (topHeadlines) {
        response = await _api.sendRequest.get(
          "/top-headlines?country=$country&apiKey=$apiKey",
        );
      } else {
        response = await _api.sendRequest.get(
          "/everything?q=$query&apiKey=$apiKey",
        );
      }

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.status != "ok") {
        return left(
          Failure(
            status: apiResponse.status,
            code: apiResponse.code!,
            message: apiResponse.message!,
          ),
        );
      }

      List<ArticleModel> articles = [];

      for (var element in apiResponse.articles) {
        articles.add(ArticleModel.fromMap(element));
      }

      return right(articles);
    } catch (e) {
      return left(
        Failure(
          status: "404",
          code: "Unknown",
          message: "An error occurred",
        ),
      );
    }
  }
}


//APPROACH Using FutureProvider

// final articlesProvider = FutureProvider<List<ArticleModel>>((ref) async {
//   try {
//     final Api api = Api();
//     Response response = await api.sendRequest.get(
//       "/everything?q=bitcoin&apiKey=$apiKey",
//     );

//     ApiResponse apiResponse = ApiResponse.fromResponse(response);

//     if (apiResponse.status != "ok") {
//       throw apiResponse;
//     }

//     List<ArticleModel> articles = [];

//     for (var element in apiResponse.articles) {
//       articles.add(ArticleModel.fromMap(element));
//     }

//     return articles;
//   } catch (e) {
//     rethrow;
//   }
// });
