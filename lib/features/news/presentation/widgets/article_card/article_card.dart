import 'package:flutter/material.dart';
import 'package:news_repository/news_repository.dart';

import 'components/article_content_view.dart';
import 'components/article_image_view.dart';

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
          Expanded(
            flex: 2,
            child: ArticleImageView(image: article.image),
          ),
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
