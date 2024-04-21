import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:quickbytes_app/core/logs/logs.dart';
import 'package:quickbytes_app/shared/widgets/blur_view.dart';
import 'package:quickbytes_app/shared/widgets/cached_image.dart';
import 'package:quickbytes_app/features/news/presentation/widgets/article_card/article_card.dart';
import 'package:quickbytes_app/features/news/state/news_bloc.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(AllArticlesRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is NewsLoaded) {
            Logger.instance.i(state.index, stackTrace: StackTrace.empty);
            final newsBloc = context.read<NewsBloc>();

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
                  CardSwiper(
                    cardsCount: state.articles.length,
                    padding: EdgeInsets.zero,
                    controller: newsBloc.cardSwiperController,
                    isLoop: true,
                    onSwipe: (previousIndex, currentIndex, direction) {
                      if (currentIndex != null) {
                        // using a proper logging package instead of primitive print provided by dart
                        Logger.instance
                            .w(currentIndex, stackTrace: StackTrace.empty);
                        newsBloc.add(ArticleSelectedAtIndex(currentIndex));
                      }

                      return true;
                    },
                    cardBuilder: (context, index, percentThresholdX,
                            percentThresholdY) =>
                        state.articles
                            .map((e) => ArticleCard(article: e))
                            .toList()[index],
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
}
