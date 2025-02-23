import 'package:flutter/material.dart';
import 'package:news_app/theme/theme.dart';
import 'features/news_list/view/news_list_screen.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NewsApp',
      theme: lightTheme,
      home: NewsListScreen(),
      // routes: Placeholder(),
    );
  }
}
