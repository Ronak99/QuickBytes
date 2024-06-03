import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quickbytes_app/shared/utils/constants.dart';

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
              AutoSizeText(
                title,
                style: TextStyle(
                  color: ColorConstants.primaryDarkContrast,
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: AutoSizeText(
                  content,
                  style: TextStyle(
                    color: ColorConstants.primaryDarkContrast.withOpacity(.7),
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
