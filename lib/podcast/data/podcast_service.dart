import 'package:green_mode/core/data/constants/location.dart';
import 'package:podcast_search/podcast_search.dart';

class PodcastService {
  static Future<SearchResult> performSearch(
      {required String query, required Location location}) async {
    final result = await Search().search(
      query,
      country: location.country,
      limit: 10,
    );

    return result;
  }
}
