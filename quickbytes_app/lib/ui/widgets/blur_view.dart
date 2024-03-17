import 'dart:ui';

import 'package:flutter/material.dart';

class BlurView extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final double sigmaX;
  final double sigmaY;
  final Color color;
  const BlurView({
    Key? key,
    required this.child,
    required this.height,
    required this.width,
    this.sigmaX = 0,
    this.sigmaY = 0,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: child,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: sigmaX,
              sigmaY: sigmaY,
            ),
            child: Container(
              height: height,
              width: width,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
