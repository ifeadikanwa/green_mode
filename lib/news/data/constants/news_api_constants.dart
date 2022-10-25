import 'package:green_mode/env/env.dart';

class NewsApiConstants {
  static const String baseURL = "https://newsapi.org/v2";

  static const pageSize = 10;

  static getTopArticlesInCategoryFromACountryRequestURL({
    required String countryCode,
    required String category,
    required int page,
  }) {
    return "$baseURL/top-headlines?country=$countryCode&category=$category&apiKey=${Env.newsApiKey}&pageSize=$pageSize&page=$page";
  }
}
