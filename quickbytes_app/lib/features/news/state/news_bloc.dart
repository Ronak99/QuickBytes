import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_repository/news_repository.dart';
import 'package:quickbytes_app/core/logs/logs.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc({required NewsRepository newsRepository})
      : _newsRepository = newsRepository,
        super(const NewsState()) {
    on<AddToTopRequested>(_onAddToTopRequested);
    on<CardSwitchedRequested>(_onCardSwitch);
    on<ArticleSelectedAtIndex>(_onArticleSelectAtIndex);
    on<ArticleSelected>(_onArticleSelect);
    on<AllArticlesRequested>(_onAllArticlesRequest);
    on<UserArticlesRequested>(_onUserArticlesRequest);
    on<NewsEventUserCategoriesChanged>(_onCategoryChange);
  }

  final NewsRepository _newsRepository;

  final PageController cardSwiperController = PageController();

  List<Article> get getUserArticles => state.userArticles;
  List<Article> get getAllArticles => state.allArticles;

  void _onAddToTopRequested(AddToTopRequested event, Emitter<NewsState> emit) {
    emit(state.copyWith(userArticles: [event.article, ...state.allArticles]));
  }

  void _onArticleSelectAtIndex(
    ArticleSelectedAtIndex event,
    Emitter<NewsState> emit,
  ) {
    emit(state.copyWith(index: event.index));
  }

  void _onArticleSelect(ArticleSelected event, Emitter<NewsState> emit) {
    emit(state.copyWith(articleToSelect: event.selectedArticle));
  }

  void _onCardSwitch(CardSwitchedRequested event, Emitter<NewsState> emit) {
    if (!cardSwiperController.hasClients) return;
    cardSwiperController.jumpToPage(event.index);
  }

  void _onAllArticlesRequest(
    AllArticlesRequested event,
    Emitter<NewsState> emit,
  ) async {
    String? cursorId =
        state.allArticles.isNotEmpty ? state.allArticles.last.id : null;

    emit(state.copyWith(isFetchingMoreData: true));

    List<Article> allArticles = await _newsRepository.queryAllArticles(
      limit: event.limit,
      cursorId: cursorId,
    );

    List<Article> updatedArticles = [...state.allArticles, ...allArticles];
    emit(
      state.copyWith(
        allArticles: updatedArticles,
        isFetchingMoreData: false,
      ),
    );
  }

  void _onCategoryChange(
    NewsEventUserCategoriesChanged event,
    Emitter<NewsState> emit,
  ) async {
    List<Article> articles = state.userArticles;

    if (event.categoriesRemoved.isNotEmpty) {
      articles.removeWhere((article) {
        return event.categoriesRemoved.any(
            (removedCategory) => article.categories.contains(removedCategory));
      });
    }

    if (event.categoriesAdded.isNotEmpty) {
      emit(state.copyWith(userArticles: []));
      List<Article> newArticles = await _newsRepository.queryAllArticles(
        categoryIdList: event.categoriesAddedIds,
      );

      articles.addAll(newArticles);
    }

    emit(state.copyWith(
      userArticles: articles,
      articleToSelect: articles[0],
    ));
  }

  void _onUserArticlesRequest(
    UserArticlesRequested event,
    Emitter<NewsState> emit,
  ) async {
    List<Article> articles = await _newsRepository.queryAllArticles(
      categoryIdList: event.userCategoriesId,
    );

    emit(state.copyWith(userArticles: articles));
  }

  @override
  Future<void> close() {
    Logger.instance.d("News Bloc Closed!!!");
    return super.close();
  }
}
