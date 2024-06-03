import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:quickbytes_app/shared/utils/constants.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

class QuickbytesAnimatedLogo extends StatelessWidget {
  const QuickbytesAnimatedLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: .8,
        child: SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  color: Colors.black,
                  child: AnimatedMeshGradient(
                    colors: const [
                      Color(0xff4495B3),
                      Colors.black,
                      Colors.black,
                      Color(0xff642E55),
                    ],
                    options: AnimatedMeshGradientOptions(
                      speed: 4,
                      amplitude: 50,
                      frequency: 5,
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 24,
                        right: 20,
                        bottom: 20,
                        left: 20,
                      ),
                      child: SvgPicture.asset(AssetConstants.logoForeground),
                    ),
                  ),
                ),
              ),
              SquareProgressIndicator(
                width: 100,
                height: 100,
                borderRadius: 20,
                startPosition: StartPosition.topLeft,
                strokeCap: StrokeCap.round,
                color: Colors.white.withOpacity(.5),
                emptyStrokeColor: Colors.transparent,
                strokeWidth: 2,
                emptyStrokeWidth: 4,
                strokeAlign: SquareStrokeAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
