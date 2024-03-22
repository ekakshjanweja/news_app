import 'package:flutter/material.dart';
import 'package:news_app_lokal/core/launch_url.dart';
import 'package:news_app_lokal/features/news/views/article_page.dart';
import 'package:news_app_lokal/models/article_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsItemTile extends StatelessWidget {
  final ArticleModel articleModel;

  const NewsItemTile({
    super.key,
    required this.articleModel,
  });

  @override
  Widget build(BuildContext context) {
    if (articleModel.title == null ||
        articleModel.description == null ||
        articleModel.urlToImage == null ||
        articleModel.content == null ||
        articleModel.author == null ||
        articleModel.url == null ||
        articleModel.publishedAt == null ||
        articleModel.source == null) {
      return const SizedBox();
    }

    return GestureDetector(
      onTap: () {
        print("object");
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => ArticlePage(articleModel: articleModel),
        //   ),
        // ),

        LaunchUrl().launchUrl(articleModel.url!);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.02,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(articleModel.urlToImage!),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    articleModel.title!,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(articleModel.description!)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
