import 'package:flutter/material.dart';
import 'package:quickbytes_app/shared/widgets/cached_image.dart';

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
