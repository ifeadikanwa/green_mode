import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String? source;
  final String? author;
  final String title;
  final String? content;
  final String? description;
  final String url;
  final String? urlToImage;
  final String publishedAt;

  const News({
    required this.source,
    required this.author,
    required this.title,
    required this.content,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      source: json["source"]["name"] as String?,
      author: json["author"] as String?,
      title: json["title"] as String,
      content: json["content"] as String?,
      description: json["description"] as String?,
      url: json["url"] as String,
      urlToImage: json["urlToImage"] as String?,
      publishedAt: json["publishedAt"] as String,
    );
  }

  @override
  List<Object?> get props => [
        source,
        author,
        title,
        content,
        description,
        url,
        urlToImage,
        publishedAt,
      ];
}
