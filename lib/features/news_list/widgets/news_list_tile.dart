import 'package:flutter/material.dart';
import 'package:news_app/features/news_article/view/news_article_screen.dart';
import 'package:news_app/repositories/news_list/models/news_article.dart';

class NewsListTile extends StatelessWidget {
  const NewsListTile({
    super.key,
    required this.article,
  });

  final NewsArticle article;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(article.title, style: Theme.of(context).textTheme.bodyMedium),
      subtitle: Text(article.body.substring(0, 100) + '...'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsArticleScreen(article: article),
          ),
        );
      },
    );
  }
}
