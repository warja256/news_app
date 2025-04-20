import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/theme/theme.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:news_app/features/news_list/bloc/news_list_bloc.dart';
import 'package:news_app/repositories/news_list/news_list_repository.dart';
import 'router/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'theme/theme_provider.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NewsListBloc(NewsListRepository()),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp.router(
              title: 'NewsApp',
              theme: themeProvider.isDarkMode ? darkTheme : lightTheme,
              debugShowCheckedModeBanner: false,
              routerDelegate: _appRouter.delegate(
                navigatorObservers: () => [
                  TalkerRouteObserver(GetIt.I<Talker>()),
                ],
              ),
              routeInformationParser: _appRouter.defaultRouteParser(),
            );
          },
        ),
      ),
    );
  }
}
