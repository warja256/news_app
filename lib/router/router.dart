import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/router/router.gr.dart';
import 'package:talker_flutter/talker_flutter.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: NewsListRoute.page, path: '/', initial: true),
        AutoRoute(page: NewsArticleRoute.page, path: '/article')
      ];

  @override
  NavigatorObserver? get navigatorObserver =>
      TalkerRouteObserver(GetIt.I<Talker>());
}
