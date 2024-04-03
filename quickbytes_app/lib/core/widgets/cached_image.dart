import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final bool isRound;
  final double radius;
  final double? height;
  final double? width;
  final BoxFit fit;
  final bool useOldImageOnUrlChange;
  final Widget? placeholder;

  const CachedImage(
    this.url, {
    super.key,
    this.isRound = false,
    this.radius = 0,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.useOldImageOnUrlChange = false,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isRound ? radius : height,
      width: isRound ? radius : width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: fit,
          placeholderFadeInDuration: const Duration(milliseconds: 10),
          useOldImageOnUrlChange: useOldImageOnUrlChange,
          placeholder: (context, url) => placeholder != null
              ? placeholder!
              : const AdaptiveProgressIndicator(
                  strokeWidth: 2,
                ),
          errorWidget: (context, url, error) {
            return Container(
              height: isRound ? radius : height,
              width: isRound ? radius : width,
              color: Colors.black,
            );
          },
        ),
      ),
    );
  }
}

class AdaptiveProgressIndicator extends StatelessWidget {
  final double? value;
  final double strokeWidth;

  const AdaptiveProgressIndicator({
    super.key,
    this.value,
    this.strokeWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: const AlwaysStoppedAnimation<Color?>(Colors.white),
          value: value,
        ),
      ),
    );
  }
}