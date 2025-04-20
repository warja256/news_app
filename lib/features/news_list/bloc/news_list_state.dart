import 'package:equatable/equatable.dart';
import 'package:news_app/repositories/news_list/models/news_article.dart';

abstract class NewsListState extends Equatable {
  const NewsListState();

  @override
  List<Object?> get props => [];
}

class NewsListInitial extends NewsListState {} // Новости ещё не загружены

class NewsListLoading extends NewsListState {} // Состояни загрузки данных

class NewsListLoaded extends NewsListState {
  final List<NewsArticle> newsList;

  const NewsListLoaded({required this.newsList});

  @override
  List<Object?> get props => [newsList];
}

class NewsListLoadingFailure extends NewsListState {
  final Object exception;

  const NewsListLoadingFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
