import 'package:equatable/equatable.dart';
import 'package:news_app/repositories/news_list/models/tag.dart';

class NewsArticle extends Equatable {
  final int id;
  final int userId;
  final String title;
  final String body;
  String? reaction;
  final List<Tag> tags;

  NewsArticle({
    required this.tags,
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    this.reaction,
  });

  @override
  List<Object?> get props => [id, userId, title, body];

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    final tagsJson = json['tags'] as List;
    List<Tag> tagsList = tagsJson.map((tag) => Tag.fromJson(tag)).toList();
    return NewsArticle(
        id: json['id'] as int,
        userId: json['userId'] as int,
        title: json['title'] as String,
        body: json['body'] as String,
        tags: tagsList);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }
}
