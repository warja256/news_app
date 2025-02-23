import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news_list/bloc/news_list_bloc.dart';
import 'package:news_app/features/news_list/bloc/news_list_event.dart';
import 'package:news_app/features/news_list/bloc/news_list_state.dart';
import 'package:news_app/features/news_list/widgets/news_list_tile.dart';

import 'package:news_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({Key? key}) : super(key: key);

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
        title: const Text('Новости'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
            icon: Icon(
              context.watch<ThemeProvider>().isDarkMode
                  ? Icons.nightlight_round
                  : Icons.wb_sunny,
            ),
          ),
        ],
      ),
      body: BlocBuilder<NewsListBloc, NewsListState>(
        builder: (context, state) {
          if (state is NewsListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsListLoaded) {
            if (state.newsList.isEmpty) {
              return const Center(child: Text('Новостей нет'));
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
                separatorBuilder: (_, __) => const Divider(),
              ),
            );
          } else if (state is NewsListLoadingFailure) {
            return const Center(child: Text('Ошибка загрузки новостей'));
          }
          return const Center(child: Text('Непредвиденная ошибка'));
        },
      ),
    );
  }
}
