import 'package:connectivity_tracker/view/connectivity_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickbytes_app/core/navigation/routes.dart';
import 'package:quickbytes_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:quickbytes_app/features/home/state/bloc/home_bloc.dart';
import 'package:quickbytes_app/features/news/presentation/pages/news_page.dart';
import 'package:quickbytes_app/shared/widgets/no_internet_view.dart';
import 'package:quickbytes_app/shared/widgets/webview.dart';
import 'package:quickbytes_app/shared/utils/platform_channel_handler.dart';
import 'package:quickbytes_app/features/news/state/news_bloc.dart';
import 'package:quickbytes_app/features/notifications/data/models/news/news_notification.dart';
import 'package:quickbytes_app/features/notifications/state/notifications_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PlatformChannelHandler _channelHandler = PlatformChannelHandler();
  int i = 0;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    final notificationsBloc = context.read<NotificationsBloc>();

    List<String> notificationList =
        await _channelHandler.getPendingNotifications();

    if (notificationList.isNotEmpty) {
      notificationsBloc.add(
        NotificationTapped(notificationList[0]),
      );
    }

    _channelHandler.initializeEventStream(onData: (notificationData) {
      notificationsBloc.add(NotificationTapped(notificationData));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationsBloc, NotificationState>(
      bloc: context.read<NotificationsBloc>(),
      listener: (context, state) {
        if (state.notificationData.isNotEmpty) {
          if (state.notification is NewsNotification) {
            HomePageRoute().go(context);

            final notification = state.notification as NewsNotification;

            final newsBloc = context.read<NewsBloc>();
            final homeBloc = context.read<HomeBloc>();

            newsBloc.add(AddToTopRequested(notification.article));
            newsBloc.add(ArticleSelectedAtIndex(0));

            homeBloc.add(SwitchToNewsPageRequested());
            newsBloc.add(CardSwitchedRequested(index: 0));
          }
        }
      },
      child: ConnectivityTracker(
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
      ),
    );
  }
}
