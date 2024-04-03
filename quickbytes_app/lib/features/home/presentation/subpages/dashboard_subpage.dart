import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quickbytes_app/core/navigation/app_router.dart';
import 'package:quickbytes_app/features/home/state/bloc/home_bloc.dart';
import 'package:quickbytes_app/features/news/state/news_bloc.dart';

class DashboardSubpage extends StatelessWidget {
  const DashboardSubpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Dashboard Subpage'),
            TextButton(
              child: const Text('Change Page'),
              onPressed: () {
                context.read<HomeBloc>().add(HomePageSwitched());
              },
            ),
          ],
        ),
      ),
    );
  }
}
