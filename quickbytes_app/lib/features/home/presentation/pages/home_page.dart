import 'package:connectivity_tracker/view/connectivity_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickbytes_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:quickbytes_app/features/home/state/bloc/home_bloc.dart';
import 'package:quickbytes_app/features/news/presentation/pages/news_page.dart';
import 'package:quickbytes_app/shared/widgets/no_internet_view.dart';
import 'package:quickbytes_app/shared/widgets/webview.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ConnectivityTracker(
      whenDisconnected: const NoInternetView(),
      whenConnected: Scaffold(
        body: PageStorage(
          bucket: PageStorageBucket(),
          child: PageView(
            controller: context.read<HomeBloc>().state.pageController,
            children: const [
              DashboardPage(),
              NewsPage(),
              WebView(),
            ],
          ),
        ),
      ),
    );
  }
}
