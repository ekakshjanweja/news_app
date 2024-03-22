import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_lokal/features/news/controller/news_controller.dart';
import 'package:news_app_lokal/features/news/views/country_page.dart';
import 'package:news_app_lokal/features/news/views/search_page.dart';
import 'package:news_app_lokal/features/news/widgets/news_item_tile.dart';

final queryProvider = StateProvider<String>((ref) => "ai");

final topHeadlinesProvider = StateProvider<bool>((ref) => false);

final countryProvider = StateProvider<String>((ref) => "us");

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App Lokal'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Row(
                  children: [
                    FilledButton.tonal(
                      onPressed: () {
                        ref.read(topHeadlinesProvider.notifier).state =
                            !ref.read(topHeadlinesProvider);
                      },
                      child: Text(ref.read(topHeadlinesProvider) == false
                          ? "Top Headlines"
                          : "All News"),
                    ),
                    const SizedBox(width: 10),
                    FilledButton.tonal(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CountryPage(),
                          ),
                        );
                      },
                      child: const Text("Edit Country"),
                    ),
                    const SizedBox(width: 10),
                    IconButton.filledTonal(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SearchPage(),
                          ),
                        );
                      },
                      icon: const Row(
                        children: [
                          Icon(Icons.search),
                          Text("Search"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Text(
                ref.read(topHeadlinesProvider) == false
                    ? "Showing results for ${ref.watch(queryProvider)}"
                    : "Showing top headlines in ${ref.watch(countryProvider)}",
              ),
              FutureBuilder(
                future: ref.read(newsControllerProvider).getArticles(
                      context: context,
                      query: ref.watch(queryProvider),
                      country: ref.watch(countryProvider),
                      topHeadlines: ref.watch(topHeadlinesProvider),
                    ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  if (snapshot.hasData) {
                    final articles = snapshot.data!;
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (BuildContext context, int index) =>
                            NewsItemTile(
                          articleModel: articles[index],
                        ),
                      ),
                    );
                  }

                  return const Center(
                    child: Text("Failed to load data"),
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              )
            ],
          ),
        ),
      ),
    );
  }
}
