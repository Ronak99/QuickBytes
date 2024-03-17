import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quickbytes_app/service/notification_service.dart';
import 'package:quickbytes_app/ui/pages/news_page.dart';
import 'package:quickbytes_app/ui/pages/notification_page.dart';

//export PATH="/Users/ronakpustack/.shorebird/bin:$PATH"
//  asia-south1

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.notification);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  NotificationService().initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (kDebugMode) {
    try {
      print("setting up firestore settings");

      // FirebaseFirestore.instance.settings = const Settings(
      //   host: 'localhost',
      //   sslEnabled: false,
      //   persistenceEnabled: false,
      // );

      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    } catch (e) {
      print(e);
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickBytes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const NotificationPage(),
    );
  }
}

class Intermediate extends StatelessWidget {
  const Intermediate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text('Go Go QuickBytes'),
          // onPressed: () async {
          //   try {
          //     FirebaseFirestore.instance
          //         .collection('test')
          //         .add({'emulator': true});
          //   } catch (e) {
          //     print(e);
          //   }
          // },
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => const NewsPage(),
            ),
          ),
        ),
      ),
    );
  }
}
