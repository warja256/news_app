import 'package:equatable/equatable.dart';

class NewsArticle extends Equatable {
  final int id;
  final int userId;
  final String title;
  final String body;

  const NewsArticle(
      {required this.id,
      required this.userId,
      required this.title,
      required this.body});

  @override
  List<Object?> get props => [id, userId, title, body];

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
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
