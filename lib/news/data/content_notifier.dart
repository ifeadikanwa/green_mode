import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ContentNotifier extends StateNotifier<AsyncValue<List<String>>> {
  ContentNotifier({required String urlString})
      : super(const AsyncValue.loading()) {
    _fetchContent(urlString);
  }

  Future<void> _fetchContent(String urlString) async {
    state = await AsyncValue.guard(() async {
      final url = Uri.parse(
        urlString,
      );

      final response = await http.get(url);

      BeautifulSoup beautifulSoup = BeautifulSoup(response.body);

      final List<Bs4Element> finds = beautifulSoup.findAll("p");

      return finds.map((find) => find.string).toList();
    });
  }
}
