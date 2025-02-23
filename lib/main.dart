import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/news_app.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Инициализируем Talker для логирования
    final talker = TalkerFlutter.init();
    // Регистрация объекта talker в сервис-локатор GetIt
    GetIt.I.registerSingleton(talker);
    // Логируем запуск Talker
    GetIt.I<Talker>().debug('Talker started...');

    // Настройка Dio (HTTP-клиент) с логированием запросов и ответов через Talker
    final dio = Dio();
    dio.interceptors.add(
      TalkerDioLogger(
        talker: talker, // Передаем Talker для логирования
        settings: TalkerDioLoggerSettings(
            printResponseData: false), // Настройки логирования
      ),
    );

    // Настройка обработки ошибок Flutter
    FlutterError.onError =
        (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

    runApp(const NewsApp());
  },
      // Обработчик ошибок зоны
      (e, st) => GetIt.I<Talker>().handle(e, st));
}
