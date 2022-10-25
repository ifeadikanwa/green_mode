import 'package:green_mode/core/data/carbon_aware_providers.dart';
import 'package:green_mode/news/data/constants/news_category.dart';
import 'package:green_mode/news/data/content_notifier.dart';
import 'package:green_mode/news/data/models/news.dart';
import 'package:green_mode/news/data/news_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newsCategoryProvider = StateProvider<NewsCategory>(
  (ref) => NewsCategory.business,
);

final contentUrlProvider = StateProvider<String>((ref) => "");

//the provider for news list
final newsNotifierProvider =
    StateNotifierProvider<NewsNotifier, AsyncValue<List<News>>>((ref) {
  final location = ref.watch(locationProvider);
  final category = ref.watch(newsCategoryProvider);

  return NewsNotifier(location, category);
});

//provider for news content
final contentNotifierProvider =
    StateNotifierProvider<ContentNotifier, AsyncValue<List<String>>>((ref) {
  final urlString = ref.watch(contentUrlProvider);

  return ContentNotifier(urlString: urlString);
});
