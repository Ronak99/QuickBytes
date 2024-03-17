import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  try {
                    await FirebaseMessaging.instance
                        .subscribeToTopic('example');
                    print('user has been subscribed to topic');
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text('Subscribe to notification'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
