import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_repository/news_repository.dart';
import 'package:quickbytes_app/core/navigation/routes.dart';
import 'package:quickbytes_app/features/dashboard/state/bloc/dashboard_bloc.dart';
import 'package:quickbytes_app/features/news/state/news_bloc.dart';
import 'package:quickbytes_app/shared/utils/constants.dart';
import 'package:quickbytes_app/shared/widgets/cached_image.dart';

class StaggeredConfig {
  final int crossAxisCellCount;
  final int mainAxisCellCount;

  StaggeredConfig(
      {required this.crossAxisCellCount, required this.mainAxisCellCount});
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    final dashboardBloc = context.read<DashboardBloc>();
    await dashboardBloc.initialize(onReachingEndOfTheList: _queryMoreData);
  }

  _queryMoreData() {
    final newsBloc = context.read<NewsBloc>();
    newsBloc.add(AllArticlesRequested());
  }

  List<Widget> getChildren(BuildContext context) {
    List<Widget> widgets = [];
    List<StaggeredConfig> staggeredConfig = [
      StaggeredConfig(crossAxisCellCount: 2, mainAxisCellCount: 2),
      StaggeredConfig(crossAxisCellCount: 2, mainAxisCellCount: 2),
      StaggeredConfig(crossAxisCellCount: 4, mainAxisCellCount: 4),
      StaggeredConfig(crossAxisCellCount: 2, mainAxisCellCount: 2),
      StaggeredConfig(crossAxisCellCount: 2, mainAxisCellCount: 2),
    ];

    int index = 0;

    for (Article article in context.read<NewsBloc>().getAllArticles) {
      if (index > staggeredConfig.length - 1) {
        index = index - staggeredConfig.length;
        index = 0;
      }

      print('adding to the list again!');
      widgets.add(
        StaggeredGridTile.count(
          crossAxisCellCount: staggeredConfig[index].crossAxisCellCount,
          mainAxisCellCount: staggeredConfig[index].mainAxisCellCount,
          child: NewsTile(article: article),
        ),
      );

      index++;
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final dashboardBloc = context.read<DashboardBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QuickBytes',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        leading: GestureDetector(
          onTap: () => SettingsPageRoute().go(context),
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(18.0),
            child: SvgPicture.asset(
              AssetConstants.setting,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(.8),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: dashboardBloc.scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) => Column(
              children: [
                StaggeredGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: getChildren(context),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: state.isFetchingMoreData
                      ? const AdaptiveProgressIndicator(color: Colors.white54)
                      : const SizedBox(
                          height: 20,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class NewsTile extends StatelessWidget {
  const NewsTile({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // final homeBloc = context.read<HomeBloc>();
        // final newsBloc = context.read<NewsBloc>();

        // homeBloc.add(SwitchToNewsPageRequested());
        // newsBloc.add(
        //   CardSwitchedRequested(
        //     index: newsBloc.articles.indexOf(article),
        //   ),
        // );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white24,
            width: .5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: CachedImage(
                article.image,
                radius: 16,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  article.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
