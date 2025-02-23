import 'package:flutter/material.dart';
import 'package:news_app/repositories/news_list/models/news_article.dart';

class NewsArticleScreen extends StatelessWidget {
  final NewsArticle article;

  const NewsArticleScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.newspaper_rounded),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(article.title,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 10),
            Text(article.body, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
