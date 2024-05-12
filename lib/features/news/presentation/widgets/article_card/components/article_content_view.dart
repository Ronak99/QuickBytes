import 'package:flutter/material.dart';
import 'package:quickbytes_app/features/news/presentation/widgets/article_card/components/article_footer_two.dart';
import 'package:quickbytes_app/shared/utils/constants.dart';

import 'article_footer.dart';

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
              const ArticleFooterTwo(),
            ],
          ),
        ),
      ],
    );
  }
}
