import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/features/news_list/bloc/news_list_event.dart';
import 'package:news_app/features/news_list/bloc/news_list_state.dart';
import 'package:news_app/repositories/news_list/news_list_repository.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  final NewsListRepository newsListRepository;

  NewsListBloc(this.newsListRepository) : super(NewsListInitial()) {
    on<LoadNewsList>(_onLoadNewsList);
  }

  Future<void> _onLoadNewsList(
      LoadNewsList event, Emitter<NewsListState> emit) async {
    try {
      print("Загружаем список новостей...");
      if (state is! NewsListLoaded) {
        emit(NewsListLoading());
      }
      final newsList = await newsListRepository.fetchNews();
      print("Загружено: ${newsList.length} новостей");
      emit(NewsListLoaded(newsList: newsList));
    } catch (e, st) {
      print("Ошибка при загрузке новостей: $e\n$st");
      emit(NewsListLoadingFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }
}
