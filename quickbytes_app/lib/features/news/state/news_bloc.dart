import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:news_repository/news_repository.dart';
import 'package:quickbytes_app/features/news/data/models/news_article.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc()
      : super(
          NewsState(
            articles: articleList,
            selectedArticle: articleList[0],
          ),
        ) {
    on<AddToTopRequested>(_onAddToTopRequested);
    on<CardSwitched>(_onCardSwitch);
    on<ArticleSelected>(_onArticleSelect);
  }

  final CardSwiperController cardSwiperController = CardSwiperController();

  void _onAddToTopRequested(AddToTopRequested event, Emitter<NewsState> emit) {
    emit(state.copyWith(articles: [event.article, ...state.articles]));
  }

  void _onArticleSelect(ArticleSelected event, Emitter<NewsState> emit) {
    emit(state.copyWith(selectedArticle: event.article));
  }

  void _onCardSwitch(CardSwitched event, Emitter<NewsState> emit) {
    cardSwiperController.moveTo(event.index);
    emit(state);
  }

  @override
  Future<void> close() {
    print("News Bloc Closed!!!");
    return super.close();
  }
}
