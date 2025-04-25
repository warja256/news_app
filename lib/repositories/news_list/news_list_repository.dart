import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models/news_article.dart';

class NewsListRepository {
  static const String _baseUrl =
      'https://news-app-sigma-ashen.vercel.app/posts';

  Future<List<NewsArticle>> fetchNews() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');

      try {
        // Декодируем строку как список
        dynamic jsonData = jsonDecode(response.body);

        // Если jsonData это строка, превращаем её в список
        if (jsonData is String) {
          jsonData = jsonDecode(
              jsonData); // Попробуем еще раз декодировать как строку JSON
        }

        // Проверяем, что jsonData действительно является списком
        if (jsonData is List) {
          return jsonData.map((item) => NewsArticle.fromJson(item)).toList();
        } else {
          throw Exception('Получены некорректные данные');
        }
      } catch (e) {
        throw Exception('Ошибка при декодировании JSON: $e');
      }
    } else {
      throw Exception('Не удалось загрузить новости');
    }
  }
}
