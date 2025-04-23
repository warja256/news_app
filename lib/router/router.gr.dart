// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:news_app/features/news_article/view/news_article_screen.dart'
    as _i1;
import 'package:news_app/features/news_list/view/news_list_screen.dart' as _i2;
import 'package:news_app/repositories/news_list/models/news_article.dart'
    as _i5;

/// generated route for
/// [_i1.NewsArticleScreen]
class NewsArticleRoute extends _i3.PageRouteInfo<NewsArticleRouteArgs> {
  NewsArticleRoute({
    _i4.Key? key,
    required _i5.NewsArticle article,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          NewsArticleRoute.name,
          args: NewsArticleRouteArgs(key: key, article: article),
          initialChildren: children,
        );

  static const String name = 'NewsArticleRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewsArticleRouteArgs>();
      return _i1.NewsArticleScreen(
        key: args.key,
        article: args.article,
        reactions: {},
        tileKey: _i4.GlobalKey(),
      );
    },
  );
}

class NewsArticleRouteArgs {
  const NewsArticleRouteArgs({this.key, required this.article});

  final _i4.Key? key;

  final _i5.NewsArticle article;

  @override
  String toString() {
    return 'NewsArticleRouteArgs{key: $key, article: $article}';
  }
}

/// generated route for
/// [_i2.NewsListScreen]
class NewsListRoute extends _i3.PageRouteInfo<void> {
  const NewsListRoute({List<_i3.PageRouteInfo>? children})
      : super(NewsListRoute.name, initialChildren: children);

  static const String name = 'NewsListRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return _i2.NewsListScreen();
    },
  );
}
