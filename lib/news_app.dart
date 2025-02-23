import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/theme/theme.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:news_app/features/news_list/bloc/news_list_bloc.dart'; // Импортируйте ваш Bloc
import 'package:news_app/repositories/news_list/news_list_repository.dart'; // Импортируйте репозиторий
import 'router/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Импорт для Bloc

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NewsListBloc(NewsListRepository()),
        ),
      ],
      child: MaterialApp.router(
        title: 'NewsApp',
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.config(
          navigatorObservers: () => [
            TalkerRouteObserver(GetIt.I<Talker>()),
          ],
        ),
      ),
    );
  }
}
