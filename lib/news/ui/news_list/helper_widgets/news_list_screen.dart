import 'package:green_mode/core/ui/add_vertical_space.dart';
import 'package:green_mode/core/ui/loading_indicator.dart';
import 'package:green_mode/core/ui/themed_divider.dart';
import 'package:green_mode/core/ui/themed_scrollbar.dart';
import 'package:green_mode/news/data/news_providers.dart';
import 'package:green_mode/news/ui/news_list/helper_widgets/news_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewsListScreen extends ConsumerWidget {
  const NewsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsList = ref.watch(newsNotifierProvider);

    return newsList.when(
      data: (providedNewsList) {
        return Expanded(
          child: ThemedScrollbar(
            child: ListView.separated(
              itemCount: providedNewsList.length,
              itemBuilder: (context, index) {
                //if its the last index and there is more news to load
                if (index == providedNewsList.length - 1 &&
                    ref.read(newsNotifierProvider.notifier).canLoadMore()) {
                  return Column(
                    children: [
                      NewsListItem(
                        news: providedNewsList[index],
                      ),
                      const AddVerticalSpace(height: 8.0),
                      OutlinedButton(
                        onPressed: () async {
                          ref.read(newsNotifierProvider.notifier).loadMore();
                        },
                        child: const Text("LOAD MORE"),
                      ),
                    ],
                  );
                } else {
                  return NewsListItem(
                    news: providedNewsList[index],
                  );
                }
              },
              separatorBuilder: (context, index) => const ThemedDivider(),
            ),
          ),
        );
      },
      error: (error, stackTrace) => Center(
        child: Text(
          error.toString(),
        ),
      ),
      loading: () => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            LoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
