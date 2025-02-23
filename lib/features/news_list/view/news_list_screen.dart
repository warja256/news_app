import 'package:flutter/material.dart';
import 'package:news_app/features/news_list/widgets/news_list_tile.dart';
import 'package:news_app/repositories/news_list/models/news_article.dart';
import 'package:news_app/repositories/news_list/news_list_repository.dart';

class NewsListScreen extends StatefulWidget {
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final NewsListRepository _newsService = NewsListRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Новости'),
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: _newsService.fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка загрузки данных'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Новостей нет'));
          }

          List<NewsArticle> newsList = snapshot.data!;

          return ListView.separated(
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              NewsArticle article = newsList[index];
              return NewsListTile(article: article);
            },
            separatorBuilder: (_, __) =>
                Divider(color: Theme.of(context).dividerColor),
          );
        },
      ),
    );
  }
}
