import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestUI extends ConsumerWidget {
  const TestUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // AsyncValue<Emission> currentEmission = ref.watch(currentEmissionProvider);
    // AsyncValue<List<News>> newsListProvider = ref.watch(newsNotifierProvider);

    // AsyncValue<List<String>> content = ref.watch(contentNotifierProvider);

    // print("html: ${content}");

    // return content.when(
    //     data: (contentList) => Column(
    //           children: [
    //             Expanded(
    //               child: SingleChildScrollView(child: Text(content.toString())),
    //             ),
    //           ],
    //         ),
    //     error: (error, stackTrace) => Text(error.toString()),
    //     loading: () => CircularProgressIndicator());

    return Container();

    // return currentEmission.when(
    //   data: (currEmission) => Text("$currEmission"),
    //   error: (error, stackTrace) => Text("$error"),
    //   loading: () => const CircularProgressIndicator(),
    // );

    // return newsListProvider.when(
    //   data: (newsList) => Column(
    //     children: [
    //       Expanded(
    //         child: SingleChildScrollView(
    //           child: Text(
    //               "${newsList.map((news) => "${news.title}\n\n").toList()}"),
    //         ),
    //       ),
    //       ElevatedButton(
    //         onPressed: () {
    //           // ref.read(newsCategoryProvider.notifier).state =
    //           //     NewsCategory.business;

    //           ref.read(newsNotifierProvider.notifier).loadMore();
    //         },
    //         child: const Text("change"),
    //       ),
    //     ],
    //   ),
    //   error: (error, stackTrace) => Text("$error"),
    //   loading: () => const CircularProgressIndicator(),
    // );
  }
}
// Future<String> scrapeWebsite() async {
//     final url = Uri.parse(
//         "https://www.bbc.com/news/uk-england-northamptonshire-63328168");

//     final webScraper = await WebScraper("https://www.bbc.com");

//     if (await webScraper
//         .loadWebPage("/news/uk-england-northamptonshire-63328168")) {
//       List<Map<String, dynamic>> elements =
//           webScraper.getElement('> div > p', []);

//       return elements.toString();
//       print(elements);
//     }
//     return "";

//   }

  