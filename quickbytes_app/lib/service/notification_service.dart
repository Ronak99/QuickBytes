import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  initialize() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
