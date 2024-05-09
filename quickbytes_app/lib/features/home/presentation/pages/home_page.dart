import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickbytes_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:quickbytes_app/features/home/state/bloc/home_bloc.dart';
import 'package:quickbytes_app/features/news/presentation/pages/news_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: PageStorageBucket(),
        child: PageView(
          controller: context.read<HomeBloc>().state.pageController,
          children: const [
            DashboardPage(),
            NewsPage(),
          ],
        ),
      ),
    );
  }
}
