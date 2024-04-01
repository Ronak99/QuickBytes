import 'package:flutter/material.dart';
import 'package:quickbytes_app/core/navigation/routes.dart';
import 'package:quickbytes_app/features/home/presentation/subpages/dashboard_subpage.dart';
import 'package:quickbytes_app/features/home/presentation/subpages/news_subpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: PageController(initialPage: 1),
        children: const [
          DashboardSubpage(),
          NewsSubpage(),
        ],
      ),
    );
  }
}
