import 'package:api_repository/api_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static NotificationService? _instance;

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  ApiRepository apiRepository = ApiRepository.instance;

  static NotificationService get instance {
    _instance ??= NotificationService();
    return _instance!;
  }

  initialize() async {
    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    NotificationSettings notificationSettings = await requestPermissions();
    String? token = await getToken();

    try {
      await apiRepository.notifications.registerToken(token: token);
    } on ApiException catch (e) {
      print(e.message);
    }
  }

  Future<String?> getToken() async {
    String? token = await messaging.getToken();
    return token;
  }

  Future<NotificationSettings> requestPermissions() async {
    return await messaging.requestPermission(
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
