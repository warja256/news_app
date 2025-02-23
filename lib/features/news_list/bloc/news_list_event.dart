import 'dart:async';

import 'package:equatable/equatable.dart';

abstract class NewsListEvent extends Equatable {
  const NewsListEvent();

  @override
  List<Object?> get props => [];
}

class LoadNewsList extends NewsListEvent {
  final Completer? completer;
  const LoadNewsList({this.completer});
}
