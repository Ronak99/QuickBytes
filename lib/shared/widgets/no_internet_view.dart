import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:quickbytes_app/shared/utils/utils.dart';
import 'package:quickbytes_app/shared/widgets/action_button.dart';
import 'package:quickbytes_app/shared/widgets/cached_image.dart';

class NoInternetView extends StatefulWidget {
  const NoInternetView({super.key});

  @override
  State<NoInternetView> createState() => _NoInternetViewState();
}

class _NoInternetViewState extends State<NoInternetView> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: .8,
              child: SvgPicture.asset('assets/images/no_internet.svg'),
            ),
            const SizedBox(height: 22),
            const Text(
              'Ooops!',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 40,
                color: Colors.white70,
              ),
            ),
            const Text(
              "Check your connection 👀",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: Colors.white54),
            ),
            ActionButton(
              text: 'Try Again!',
              isLoading: _isLoading,
              onTap: () async {
                setState(() {
                  _isLoading = true;
                });

                await Future.delayed(const Duration(seconds: 1));

                if (mounted) {
                  setState(() {
                    _isLoading = false;
                  });

                  Utils.showSnackbar(message: 'No internet connection found.');
                }
              },
            ),
            // DotLottieLoader.fromAsset(
            //   "assets/lottie/no-internet.lottie",
            //   frameBuilder: (ctx, dotlottie) {
            //     if (dotlottie != null) {
            //       return Lottie.memory(dotlottie.animations.values.single);
            //     } else {
            //       return Container();
            //     }
            //   },
            //   errorBuilder: (ctx, e, s) {
            //     print(s);
            //     return Text(e.toString());
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
