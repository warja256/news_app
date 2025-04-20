import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:news_app/features/news_list/bloc/news_list_event.dart';
import 'package:news_app/features/news_list/bloc/news_list_state.dart';
import 'package:news_app/repositories/news_list/news_list_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  final NewsListRepository newsListRepository;
  final Talker talker = GetIt.I<Talker>();

  NewsListBloc(this.newsListRepository) : super(NewsListInitial()) {
    on<LoadNewsList>(_onLoadNewsList);
  }

  Future<void> _onLoadNewsList(
      LoadNewsList event, Emitter<NewsListState> emit) async {
    try {
      talker.debug("Загружаем список новостей...");
      if (state is! NewsListLoaded) {
        emit(NewsListLoading());
      }
      final newsList = await newsListRepository.fetchNews();
      talker.debug("Загружено: ${newsList.length} новостей");
      emit(NewsListLoaded(newsList: newsList));
    } catch (e, st) {
      talker.debug("Ошибка при загрузке новостей: $e\n$st");
      emit(NewsListLoadingFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }
}
