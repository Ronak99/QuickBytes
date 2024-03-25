import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickbytes_app/app/bloc/app_bloc.dart';
import 'package:quickbytes_app/ui/pages/home/home.dart';
import 'package:quickbytes_app/utils/platform_channel_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _platformChannel = PlatformChannelHandler();

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  _initialize() async {
    List<String> pendingNotifications =
        await _platformChannel.getPendingNotifications();
    print("Pending List: $pendingNotifications");

    _platformChannel.initializeEventStream(onData: (data) {
      print("Init Event Stream: $data");
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AppBloc>().add(const AppLogoutRequested());
            },
          ),
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Avatar(photo: user.photo),
            const SizedBox(height: 4),
            Text(user.email ?? '', style: textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(user.name ?? '', style: textTheme.headlineSmall),
            TextButton(
              onPressed: () async {
                try {
                  await FirebaseMessaging.instance
                      .subscribeToTopic('entertainment_all');
                  print('user has been subscribed to topic');
                } catch (e) {
                  print(e);
                }
              },
              child: const Text("Subscribe to entertainment_all"),
            ),
            TextButton(
              onPressed: () async {
                // String id =
                //     FirebaseFirestore.instance.collection('news').doc().id;

                // NewsArticle(
                //     title: 'test Title',
                //     content: 'my content',
                //     image: 'https://www.picsum.photos/800',
                //     categoryList: ['entertainment'],
                //     publishedOn: DateTime.now(),
                //     relevancy: Relevancy.all,
                //     sourceUrl: 'https://www.google.com');
              },
              child: const Text("Publish News"),
            ),
          ],
        ),
      ),
    );
  }
}
