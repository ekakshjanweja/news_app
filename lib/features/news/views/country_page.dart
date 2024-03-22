import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_lokal/features/news/views/home_page.dart';

class CountryPage extends ConsumerWidget {
  const CountryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> countries = [
      'in',
      'us',
      'br',
      'au',
      'ca',
      'nz',
    ];

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.02,
              ),
              child: DropdownButton(
                value: ref.watch(countryProvider),
                hint: const Text("Select Country"),
                items: countries.map((String country) {
                  return DropdownMenuItem(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                onChanged: (String? value) {
                  ref.read(countryProvider.notifier).state = value!;
                },
              ),
            ),
            FilledButton.tonal(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Go to results"),
            )
          ],
        ),
      ),
    );
  }
}
