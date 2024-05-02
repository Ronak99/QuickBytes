import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static NotificationService? _instance;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  static NotificationService get instance {
    _instance ??= NotificationService();
    return _instance!;
  }

  initialize() {
    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    requestPermissions();
  }

  requestPermissions() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  subscribeToTopic(String topic) async {
    await messaging.subscribeToTopic(topic);
  }

  unsubscribeFromTopic(String topic) async {
    await messaging.unsubscribeFromTopic(topic);
  }
}
