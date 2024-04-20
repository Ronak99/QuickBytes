import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quickbytes_app/core/navigation/app_router.dart';
import 'package:quickbytes_app/core/navigation/routes.dart';
import 'package:quickbytes_app/shared/utils/platform_channel_handler.dart';
import 'package:quickbytes_app/features/home/state/bloc/home_bloc.dart';
import 'package:quickbytes_app/features/news/state/news_bloc.dart';
import 'package:quickbytes_app/features/notifications/data/models/news/news_notification.dart';
import 'package:quickbytes_app/features/notifications/state/notifications_bloc.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
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
        NotificationTapped(
          notificationList[0],
        ),
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Base Page'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: const Text('Go to relevancy page'),
                onPressed: () =>
                    context.read<HomeBloc>().add(HomePageSwitched()),
              ),
              TextButton(
                child: const Text('Go to relevancy page'),
                onPressed: () => HomePageRoute().go(context),
              )
            ],
          ),
        ),
      ),
      listener: (context, state) {
        if (state.notificationData.isNotEmpty) {
          if (state.notification is NewsNotification) {
            HomePageRoute().go(context);

            final notification = state.notification as NewsNotification;

            final newsBloc = context.read<NewsBloc>();
            newsBloc.add(AddToTopRequested(notification.article));
            newsBloc.add(ArticleSelectedAtIndex(0));

            if (GoRouter.of(context).location() == '/home') {
              context.read<HomeBloc>().add(HomePageSwitched());
            }
            // newsBloc.add(CardSwitched(index: 0));
          }
        }
      },
    );
  }
}
