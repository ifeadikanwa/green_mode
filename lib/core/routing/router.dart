import 'package:green_mode/news/data/models/news.dart';
import 'package:green_mode/news/ui/news_details/news_detail_screen.dart';
import 'package:green_mode/news/ui/news_list/news_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static MaterialPageRoute newsScreen(BuildContext context) =>
      MaterialPageRoute(builder: (context) => const NewsScreen());

  static MaterialPageRoute newsDetailScreen(BuildContext context, News news) =>
      MaterialPageRoute(builder: (context) => NewsDetailScreen(news: news));
}
