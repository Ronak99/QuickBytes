import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_repository/news_repository.dart';

import 'package:quickbytes_app/core/theme/state/theme_cubit.dart';
import 'package:quickbytes_app/core/utils/constants.dart';
import 'package:quickbytes_app/shared/widgets/cached_image.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({
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
          ArticleImageView(image: article.image),
          // Flexible remains a part of Column instead of being separated into ArticleContentView
          // as it increases code-readability and intuitiveness.
          Flexible(
            flex: 3,
            child: ArticleContentView(
              title: article.title,
              content: article.content,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ArticleContentView extends StatelessWidget {
  final String title;
  final String content;
  const ArticleContentView({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
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
                image: AssetImage(AssetConstants.articleCardBackground),
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
                title,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 12),
              Text(
                content,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const Spacer(),
              const ArticleFooter(),
            ],
          ),
        ),
      ],
    );
  }
}

class ArticleImageView extends StatelessWidget {
  final String image;
  const ArticleImageView({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: CachedImage(
              image,
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
    );
  }
}

class ArticleFooter extends StatelessWidget {
  const ArticleFooter({super.key});

  @override
  Widget build(BuildContext context) {
    Color itemBackground = Theme.of(context).colorScheme.secondary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: itemBackground,
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.only(right: 5),
              ),
              Text(
                'Relevancy',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
              )
            ],
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => context.read<ThemeCubit>().toggleTheme(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: itemBackground,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Icon(
              Theme.of(context).brightness == Brightness.light
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
