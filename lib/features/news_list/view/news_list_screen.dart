import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news_list/bloc/news_list_bloc.dart';
import 'package:news_app/features/news_list/bloc/news_list_event.dart';
import 'package:news_app/features/news_list/bloc/news_list_state.dart';
import 'package:news_app/features/news_list/widgets/news_list_tile.dart';
import 'package:news_app/repositories/news_list/models/tag.dart';

import 'package:news_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({Key? key}) : super(key: key);

  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  bool _showTagFilter = false;
  List<String> selectedTags = [];

  @override
  void initState() {
    super.initState();
    context.read<NewsListBloc>().add(LoadNewsList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                setState(() {
                  _showTagFilter = !_showTagFilter;
                });
              },
              icon: Icon(Icons.filter_alt)),
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
          bottom: _showTagFilter
              ? PreferredSize(
                  preferredSize: Size.fromHeight(200),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: BlocBuilder<NewsListBloc, NewsListState>(
                      builder: (context, state) {
                        if (state is NewsListLoaded) {
                          final tagSet = <Tag>{};
                          for (var article in state.newsList) {
                            tagSet.addAll(article.tags);
                          }
                          final tags = tagSet.toList();
                          return Column(
                            children: [
                              SingleChildScrollView(
                                child: Wrap(
                                  spacing: 12,
                                  runSpacing: 4,
                                  children: tags.map((tag) {
                                    return FilterChip(
                                      onSelected: (selected) {
                                        setState(() {
                                          if (selected) {
                                            selectedTags.add(tag.name);
                                          } else {
                                            selectedTags.remove(tag.name);
                                          }
                                        });
                                      },
                                      selectedShadowColor: Colors.amber,
                                      selectedColor:
                                          Color(_hexToColor(tag.color)),
                                      labelPadding: EdgeInsets.zero,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: BorderSide.none,
                                      ),
                                      backgroundColor: Colors.grey,
                                      label: Text(tag.name,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      selected: selectedTags.contains(tag.name),
                                      showCheckmark: false,
                                    );
                                  }).toList(),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedTags.clear();
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(80, 30), // или fixedSize
                                    backgroundColor: Colors.white70,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10)
                                    // если хочешь убрать внутренние отступы
                                    ),
                                child: Text('Очистить',
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ))
              : null),
      body: BlocBuilder<NewsListBloc, NewsListState>(
        builder: (context, state) {
          if (state is NewsListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsListLoaded) {
            if (state.newsList.isEmpty) {
              return const Center(child: Text('Новостей нет'));
            }
            final filteredNews = selectedTags.isEmpty
                ? state.newsList
                : state.newsList.where((article) {
                    final tagNames =
                        article.tags.map((tag) => tag.name).toList();
                    return selectedTags
                        .any((selected) => tagNames.contains(selected));
                  }).toList();
            return RefreshIndicator(
              onRefresh: () async {
                context.read<NewsListBloc>().add(LoadNewsList());
              },
              child: ListView.separated(
                itemCount: filteredNews.length,
                itemBuilder: (context, index) {
                  return NewsListTile(article: filteredNews[index]);
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

int _hexToColor(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  return int.parse("FF$hexColor", radix: 16);
}
