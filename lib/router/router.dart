import 'package:auto_route/auto_route.dart';
import 'package:news_app/router/router.gr.dart';

@AutoRouterConfig()
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: NewsListRoute.page, path: '/', initial: true),
        AutoRoute(page: NewsArticleRoute.page, path: '/article')
      ];
}
