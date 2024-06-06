import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:news_repository/news_repository.dart';

import 'package:quickbytes_app/core/logs/logs.dart';
import 'package:quickbytes_app/core/navigation/routes.dart';
import 'package:quickbytes_app/features/categories/state/cubit/news_category_cubit.dart';
import 'package:quickbytes_app/features/news/presentation/widgets/article_card/article_card.dart';
import 'package:quickbytes_app/features/news/state/news_bloc.dart';
import 'package:quickbytes_app/shared/utils/constants.dart';
import 'package:quickbytes_app/shared/widgets/action_button.dart';
import 'package:quickbytes_app/shared/widgets/blur_view.dart';
import 'package:quickbytes_app/shared/widgets/cached_image.dart';
import 'package:quickbytes_app/shared/widgets/home_back_action_handler.dart';
import 'package:quickbytes_app/shared/widgets/quickbytes_animated_logo.dart';

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
    newsBloc.add(AllArticlesRequested());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return HomeBackActionHandler(
      child: Scaffold(
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state.isFetchingInitialData && state.userArticles.isEmpty) {
              return const QuickbytesAnimatedLogo();
            } else if (state.userArticles.isEmpty) {
              return const CaughtUpView();
            }

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
                NewsPageView(articles: state.userArticles),
              ],
            );
          },
        ),
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

        if (index == articles.length - 1) {
          final newsCategoryCubit = context.read<NewsCategoryCubit>();
          final userCategories =
              (newsCategoryCubit.state as NewsCategoryStateLoaded)
                  .userCategories;
          newsBloc.add(UserArticlesRequested(userCategories: userCategories));
        }
      },
      itemBuilder: (context, index) =>
          articles.map((e) => ArticleCard(article: e)).toList()[index],
    );
  }
}

// class NewsSwiper extends StatelessWidget {
//   final List<Article> articles;

//   const NewsSwiper({
//     Key? key,
//     required this.articles,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CardSwiper(
//       controller: cardSwiperController,
//       cardsCount: articles.length,
//       padding: EdgeInsets.zero,
//       isLoop: true,
//       onSwipe: (previousIndex, currentIndex, direction) {
//         if (currentIndex != null) {
//           final newsBloc = context.read<NewsBloc>();
//           newsBloc.add(ArticleSelectedAtIndex(currentIndex));
//         }

//         return true;
//       },
//       cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
//           articles.map((e) => ArticleCard(article: e)).toList()[index],
//     );
//   }
// }

class CaughtUpView extends StatelessWidget {
  const CaughtUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DotLottieLoader.fromAsset(
          AssetConstants.checkmark,
          frameBuilder: (ctx, dotlottie) {
            if (dotlottie != null) {
              return Lottie.memory(
                dotlottie.animations.values.single,
                height: 120,
                width: 120,
                repeat: false,
              );
            } else {
              return Container();
            }
          },
          errorBuilder: (ctx, e, s) {
            print(s);
            return Text(e.toString());
          },
        ),
        const Text(
          'You\'re all caught up',
        ),
        const Text(
          'You\'ve seen all stories from your preferred news categories',
        ),
        const SizedBox(height: 8),
        ActionButton(
          text: 'Update Preferences',
          isLoading: false,
          onTap: () => UserPreferencesHomePageRoute().go(context),
        ),
      ],
    );
  }
}
