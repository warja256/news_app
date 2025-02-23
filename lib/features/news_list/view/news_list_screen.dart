import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news_list/bloc/news_list_bloc.dart';
import 'package:news_app/features/news_list/bloc/news_list_event.dart';
import 'package:news_app/features/news_list/bloc/news_list_state.dart';
import 'package:news_app/repositories/news_list/models/news_article.dart';
import 'package:news_app/repositories/news_list/news_list_repository.dart';
import 'package:news_app/features/news_list/widgets/news_list_tile.dart';

@RoutePage()
class NewsListScreen extends StatefulWidget {
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NewsListBloc>().add(LoadNewsList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Новости'),
      ),
      body: BlocBuilder<NewsListBloc, NewsListState>(
        builder: (context, state) {
          if (state is NewsListLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NewsListLoaded) {
            // Проверка, есть ли новости
            if (state.newsList.isEmpty) {
              return Center(child: Text('Новостей нет'));
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<NewsListBloc>().add(LoadNewsList());
              },
              child: ListView.separated(
                itemCount: state.newsList.length,
                itemBuilder: (context, index) {
                  return NewsListTile(article: state.newsList[index]);
                },
                separatorBuilder: (_, __) => Divider(),
              ),
            );
          } else if (state is NewsListLoadingFailure) {
            return Center(child: Text('Ошибка загрузки новостей'));
          }
          return Center(child: Text('Непредвиденная ошибка'));
        },
      ),
    );
  }
}
