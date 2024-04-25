import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:news_repository/news_repository.dart';
import 'package:quickbytes_app/core/logs/logs.dart';

part 'news_event.dart';
part 'news_state.dart';

const businessAll = '6616ae11754e1ade06474027';
const technologyAll = '6616ae12754e1ade06474029';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc({required NewsRepository newsRepository})
      : _newsRepository = newsRepository,
        super(NewsInitial()) {
    on<AddToTopRequested>(_onAddToTopRequested);
    on<CardSwitchedRequested>(_onCardSwitch);
    on<ArticleSelectedAtIndex>(_onArticleSelect);
    on<AllArticlesRequested>(_onAllArticlesRequest);
  }

  final NewsRepository _newsRepository;

  final PageController cardSwiperController = PageController();

  void _onAddToTopRequested(AddToTopRequested event, Emitter<NewsState> emit) {
    if (state is NewsLoaded) {
      NewsLoaded s = state as NewsLoaded;
      emit(s.copyWith(articles: [event.article, ...s.articles]));
    }
  }

  void _onArticleSelect(ArticleSelectedAtIndex event, Emitter<NewsState> emit) {
    if (state is NewsLoaded) {
      Logger.instance.d(
        'class NewsBloc, function _onArticleSelect: Article selected at index: ${event.index}',
        stackTrace: StackTrace.empty,
      );
      NewsLoaded s = state as NewsLoaded;
      emit(s.copyWith(index: event.index));
    }
  }

  void _onCardSwitch(CardSwitchedRequested event, Emitter<NewsState> emit) {
    if (!cardSwiperController.hasClients) return;
    cardSwiperController.jumpToPage(event.index);
  }

  void _onAllArticlesRequest(
    AllArticlesRequested event,
    Emitter<NewsState> emit,
  ) async {
    emit(NewsLoading());
    List<String> categoryIdList = [businessAll, technologyAll];
    List<Article> articles =
        await _newsRepository.queryAllArticles(categoryIdList: categoryIdList);
    emit(NewsLoaded(articles: articles));
  }

  @override
  Future<void> close() {
    Logger.instance.d("News Bloc Closed!!!");
    return super.close();
  }
}
