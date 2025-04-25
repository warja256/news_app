import 'package:news_app/repositories/news_list/models/tag.dart';

class NewsArticle {
  final int id;
  final int userId;
  final String title;
  final String body;
  String? reaction;
  final List<Tag> tags; // Убедитесь, что это тип List<Tag>

  NewsArticle({
    required this.tags,
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    this.reaction,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    // Получаем список тэгов из json
    final tagsJson = json['tags'] as List;

    // Преобразуем список JSON объектов в список Tag
    List<Tag> tagsList = tagsJson.map((tag) => Tag.fromJson(tag)).toList();

    return NewsArticle(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      tags: tagsList, // Убедитесь, что tagsList правильно передан
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'tags': tags
          .map((tag) => tag?.toJson())
          .toList(), // Преобразуем теги обратно в JSON
    };
  }
}
