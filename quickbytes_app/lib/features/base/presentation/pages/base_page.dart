import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickbytes_app/core/navigation/routes.dart';
import 'package:quickbytes_app/core/utils/platform_channel_handler.dart';
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
    _channelHandler.initializeEventStream(onData: (notificationData) {
      context
          .read<NotificationsBloc>()
          .add(NotificationTapped(notificationData));
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
                onPressed: () => RelevancyPageRoute().go(context),
              )
            ],
          ),
        ),
      ),
      listener: (context, state) {
        // print('inside of the listener');
        if (state.notificationData.isNotEmpty) {
          print("navigating to auth page");
          AuthPageRoute().go(context);
        }
      },
    );
  }
}
