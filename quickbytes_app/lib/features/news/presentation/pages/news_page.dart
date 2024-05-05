import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:news_repository/news_repository.dart';

import 'package:quickbytes_app/core/logs/logs.dart';
import 'package:quickbytes_app/features/categories/state/cubit/news_category_cubit.dart';
import 'package:quickbytes_app/features/news/presentation/widgets/article_card/article_card.dart';
import 'package:quickbytes_app/features/news/state/news_bloc.dart';
import 'package:quickbytes_app/shared/widgets/blur_view.dart';
import 'package:quickbytes_app/shared/widgets/cached_image.dart';

final pageStorageBucket = PageStorageBucket();

final cardSwiperController = CardSwiperController();

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    _initialize();
  }

  _initialize() async {
    final newsCategoryCubit = context.read<NewsCategoryCubit>();
    final newsBloc = context.read<NewsBloc>();

    await newsCategoryCubit.queryAllCategories();
    newsBloc.add(
      UserArticlesRequested(
        userCategories:
            (newsCategoryCubit.state as NewsCategoryStateLoaded).userCategories,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is NewsLoaded) {
            return Stack(
              children: [
                // Separated out the background widget responsible for a blur background
                if (state.selectedArticle != null)
                  BlurView(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    sigmaX: 2,
                    sigmaY: 2,
                    color: Theme.of(context).cardColor.withOpacity(.3),
                    child: SizedBox(
                      child: CachedImage(
                        state.selectedArticle!.image,
                        fit: BoxFit.cover,
                        useOldImageOnUrlChange: true,
                        placeholder: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                if (state.articles.isEmpty)
                  const Center(child: Text('You are all caught up!'))
                else
                  NewsPageView(
                    articles: state.articles,
                  ),
              ],
            );
          }
          return const Center(
            child: Text('No Articles Found'),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class NewsPageView extends StatelessWidget {
  final List<Article> articles;

  const NewsPageView({
    Key? key,
    required this.articles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: articles.length,
      controller: context.read<NewsBloc>().cardSwiperController,
      padEnds: false,
      scrollDirection: Axis.vertical,
      onPageChanged: (index) {
        final newsBloc = context.read<NewsBloc>();
        newsBloc.add(ArticleSelectedAtIndex(index));
      },
      itemBuilder: (context, index) =>
          articles.map((e) => ArticleCard(article: e)).toList()[index],
    );
  }
}

class NewsSwiper extends StatelessWidget {
  final List<Article> articles;

  const NewsSwiper({
    Key? key,
    required this.articles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardSwiper(
      controller: cardSwiperController,
      cardsCount: articles.length,
      padding: EdgeInsets.zero,
      isLoop: true,
      onSwipe: (previousIndex, currentIndex, direction) {
        if (currentIndex != null) {
          final newsBloc = context.read<NewsBloc>();
          newsBloc.add(ArticleSelectedAtIndex(currentIndex));
        }

        return true;
      },
      cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
          articles.map((e) => ArticleCard(article: e)).toList()[index],
    );
  }
}
