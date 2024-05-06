import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_repository/news_repository.dart';
import 'package:quickbytes_app/core/navigation/routes.dart';

import 'package:quickbytes_app/features/categories/state/cubit/news_category_cubit.dart';
import 'package:quickbytes_app/features/dashboard/state/bloc/dashboard_bloc.dart';
import 'package:quickbytes_app/features/news/state/news_bloc.dart';
import 'package:quickbytes_app/features/notifications/domain/repositories/notification_service.dart';
import 'package:quickbytes_app/shared/utils/utils.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuickBytes'),
        actions: [
          IconButton(
            onPressed: () => SettingsPageRoute().go(context),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(),
      ),
    );
  }
}
