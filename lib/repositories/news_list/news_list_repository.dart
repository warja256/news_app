import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models/news_article.dart';

class NewsListRepository {
  static const String _baseUrl =
      'https://news-app-sigma-ashen.vercel.app/posts';

  Future<List<NewsArticle>> fetchNews() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => NewsArticle.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
