import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_repository/news_repository.dart';
import 'package:quickbytes_app/features/news/data/models/news_article.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsState()) {
    on<AddToTopRequested>(_onAddToTopRequested);
  }

  void _onAddToTopRequested(AddToTopRequested event, Emitter<NewsState> emit) {
    state.addArticleToTop(event.article);
    emit(state);
  }
}
