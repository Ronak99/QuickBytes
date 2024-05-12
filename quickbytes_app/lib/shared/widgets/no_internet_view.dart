import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          const Text(
            'Whoops',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 45,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            "Connection's gone, where did it go? 👀",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.white54),
          ),
          const SizedBox(height: 100),
          DotLottieLoader.fromAsset(
            "assets/lottie/no-internet.lottie",
            frameBuilder: (ctx, dotlottie) {
              if (dotlottie != null) {
                return Lottie.memory(dotlottie.animations.values.single);
              } else {
                return Container();
              }
            },
            errorBuilder: (ctx, e, s) {
              print(s);
              return Text(e.toString());
            },
          ),
        ],
      ),
    );
  }
}
