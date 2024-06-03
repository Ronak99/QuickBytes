import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_repository/news_repository.dart';
import 'package:quickbytes_app/shared/utils/utils.dart';
import 'package:quickbytes_app/shared/widgets/home_back_action_handler.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:quickbytes_app/features/home/state/bloc/home_bloc.dart';
import 'package:quickbytes_app/features/news/state/news_bloc.dart';
import 'package:quickbytes_app/shared/widgets/cached_image.dart';

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  WebViewController? controller;
  bool isLoaded = false;
  int loadingProgress = 0;
  Article? selectedArticle;

  @override
  void initState() {
    super.initState();

    selectedArticle = context.read<NewsBloc>().state.selectedArticle;

    if (selectedArticle == null) return;

    try {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
              if (mounted) {
                setState(() {
                  loadingProgress = progress;
                });
              }
            },
            onPageFinished: (String url) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    isLoaded = true;
                  });
                }
              });
            },
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              String domain = Utils.extractDomain(request.url);
              switch (domain) {
                case 'instagram.com':
                case 'facebook.com':
                case 'twitter.com':
                  Utils.handleUrlExternally(Uri.parse(request.url));
                  return NavigationDecision.prevent;
                default:
                  return NavigationDecision.navigate;
              }
            },
          ),
        )
        ..loadRequest(Uri.parse(selectedArticle!.sourceUrl));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedArticle == null) return const Scaffold();
    if (controller == null) return const Scaffold();

    return HomeBackActionHandler(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () =>
                context.read<HomeBloc>().add(SwitchToNewsPageRequested()),
          ),
          actions: [
            if (loadingProgress < 100)
              AdaptiveProgressIndicator(
                  value: loadingProgress.toDouble() / 100),
            const SizedBox(width: 20),
          ],
          title: Column(
            children: [
              Text(
                Utils.extractDomain(selectedArticle!.sourceUrl),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Flexible(
                  child: WebViewWidget(
                    controller: controller!,
                    gestureRecognizers: {
                      Factory(() => PlatformViewVerticalGestureRecognizer()),
                    },
                  ),
                ),
              ],
            ),
            IgnorePointer(
              ignoring: true,
              child: AnimatedOpacity(
                opacity: isLoaded ? 0 : 1,
                duration: const Duration(milliseconds: 100),
                child: const LoadingView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  Widget _headline(double width) => Container(
        height: 16,
        width: width,
        margin: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(12),
        ),
      );
  Widget _content(double width) => Container(
        height: 8,
        width: width,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(6),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Theme.of(context).cardColor,
        highlightColor: Colors.grey[900]!,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height * .35,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(height: 16),
              _headline(width * .9),
              _headline(width * .6),
              const SizedBox(height: 12),
              _content(width * .8),
              _content(width * .7),
              _content(width * .8),
              _content(width * .4),
              const SizedBox(height: 12),
              _content(width * .4),
              _content(width * .6),
              _content(width * .2),
              _content(width * .8),
            ],
          ),
        ),
      ),
    );
  }
}

class PlatformViewVerticalGestureRecognizer
    extends VerticalDragGestureRecognizer {
  PlatformViewVerticalGestureRecognizer() : super();

  Offset _dragDistance = Offset.zero;

  @override
  void addPointer(PointerEvent event) {
    startTrackingPointer(event.pointer);
  }

  @override
  void handleEvent(PointerEvent event) {
    _dragDistance = event.delta;
    if (event is PointerMoveEvent) {
      final double dy = _dragDistance.dy.abs();
      final double dx = _dragDistance.dx.abs();

      if ((dy > dx && dy > kTouchSlop) || dx < kTouchSlop) {
        resolve(GestureDisposition.accepted);
      }

      // else if (dx > kTouchSlop * 20 && dx > dy) {
      //   // horizontal drag - stop tracking
      //   stopTrackingPointer(event.pointer);
      //   _dragDistance = Offset.zero;
      // }
    }
  }

  @override
  String get debugDescription => 'horizontal drag (platform view)';

  @override
  void didStopTrackingLastPointer(int pointer) {}
}
