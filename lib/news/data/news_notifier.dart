import 'dart:convert';

import 'package:green_mode/core/data/constants/location.dart';
import 'package:green_mode/news/data/constants/news_api_constants.dart';
import 'package:green_mode/news/data/constants/news_category.dart';
import 'package:green_mode/news/data/models/news.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class NewsNotifier extends StateNotifier<AsyncValue<List<News>>> {
  final Location _location;
  final NewsCategory _category;

  NewsNotifier(
    this._location,
    this._category,
  ) : super(const AsyncValue.loading()) {
    _fetchFirstLoad(_location, _category);
  }

  int _currentPage = 1;
  int _totalResults = 0;

  //we want to do a fresh load if location or category changes
  Future<void> _fetchFirstLoad(
    Location location,
    NewsCategory category,
  ) async {
    state = await AsyncValue.guard(
      () => _fetch(
        location,
        category,
        _currentPage,
      ),
    );
  }

  Future<List<News>> _fetch(
    Location location,
    NewsCategory category,
    int page,
  ) async {
    final Uri url = Uri.parse(
      NewsApiConstants.getTopArticlesInCategoryFromACountryRequestURL(
        countryCode: location.countryCode,
        category: category.name,
        page: page,
      ),
    );


    final response = await http.get(url);

    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);


    _totalResults = jsonResponse["totalResults"];

    final List<dynamic> articles = jsonResponse["articles"];

    return articles.map((article) => News.fromJson(article)).toList();
  }

  //when load more button is clicked we want to increment page number and fetch data
  //can i have variables for result max size and current page in here or do i need to watch an external provider in here?
  Future<void> loadMore() async {
    if (_currentPage * NewsApiConstants.pageSize < _totalResults) {
      //there is more to load
      state = await AsyncValue.guard(() async {
        _currentPage++;


        final List<News> newNewsList = await _fetch(
          _location,
          _category,
          _currentPage,
        );

        return [
          ...?state.value,
          ...newNewsList,
        ];
      });
    }
  }

  bool canLoadMore() {
    return (_currentPage * NewsApiConstants.pageSize) < _totalResults;
  }
}
