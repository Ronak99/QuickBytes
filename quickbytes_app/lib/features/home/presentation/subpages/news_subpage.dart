import 'package:api_repository/api_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:news_repository/news_repository.dart';
import 'package:quickbytes_app/core/logs/logs.dart';
import 'package:quickbytes_app/core/widgets/blur_view.dart';
import 'package:quickbytes_app/core/widgets/cached_image.dart';
import 'package:quickbytes_app/features/news/state/news_bloc.dart';

class NewsSubpage extends StatefulWidget {
  const NewsSubpage({super.key});

  @override
  State<NewsSubpage> createState() => _NewsSubpageState();
}

class _NewsSubpageState extends State<NewsSubpage> {
  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(AllArticlesRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // print('hello');
          // List response = await ApiRepository.instance.articles.queryArticles();
          // print(response.length);

          final newsBloc = context.read<NewsBloc>();
          newsBloc.add(AllArticlesRequested());
          // newsBloc.add(CardSwitched(index: 0));
          // newsBloc.add(
          //   ArticleSelectedAtIndex(0),
          // );
        },
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is NewsLoaded) {
            Logger.instance.i(state.index, stackTrace: StackTrace.empty);
            final newsBloc = context.read<NewsBloc>();

            // AllowedSwipeDirection a = state.index == 0
            //     ? const AllowedSwipeDirection.only(up: true, down: false)
            //     : const AllowedSwipeDirection.only(down: true, up: false);

            return Stack(
              children: [
                if (state.selectedArticle != null)
                  BlurView(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    sigmaX: 2,
                    sigmaY: 2,
                    color: Colors.black54,
                    child: SizedBox(
                      child: CachedImage(
                        state.selectedArticle!.image,
                        fit: BoxFit.cover,
                        useOldImageOnUrlChange: true,
                        placeholder: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xff191818),
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
                    // allowedSwipeDirection: state.index == 0
                    //     ? const AllowedSwipeDirection.only(up: true)
                    //     : const AllowedSwipeDirection.symmetric(vertical: true),
                    onSwipe: (previousIndex, currentIndex, direction) {
                      if (currentIndex != null) {
                        Logger.instance
                            .w(currentIndex, stackTrace: StackTrace.empty);
                        newsBloc.add(ArticleSelectedAtIndex(currentIndex));
                      }

                      return true;
                    },
                    cardBuilder: (context, index, percentThresholdX,
                            percentThresholdY) =>
                        state.articles
                            .map((e) => NewsCard(article: e))
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

class NewsCard extends StatelessWidget {
  final Article article;

  const NewsCard({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Transform.translate(
              offset: const Offset(0, 15),
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white30,
                      offset: Offset.zero,
                      blurRadius: 2,
                      spreadRadius: 0,
                    )
                  ],
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: CachedImage(
                    article.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xff191818),
                      ),
                      child: const AdaptiveProgressIndicator(),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff191818),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white30,
                      width: .2,
                    ),
                  ),
                ),
                Opacity(
                  opacity: .05,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image:
                            AssetImage("assets/images/article_bg_pattern.png"),
                        repeat: ImageRepeat.repeat,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        article.content,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.5,
                          color: Colors.white70,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        article.publishedOn.toIso8601String(),
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.5,
                          color: Colors.white70,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        article.sourceUrl,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.5,
                          color: Colors.white70,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        article.categories.length.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.5,
                          color: Colors.white70,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      ...article.categories
                          .map(
                            (e) => Text(
                              e.label,
                              style: const TextStyle(
                                fontSize: 18,
                                height: 1.5,
                                color: Colors.white70,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
