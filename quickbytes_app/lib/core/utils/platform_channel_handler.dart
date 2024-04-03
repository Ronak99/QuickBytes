import 'package:flutter/services.dart';
import 'package:quickbytes_app/core/logs/logs.dart';

class PlatformChannelHandler {
  final _platformChannel =
      const MethodChannel("com.quickbytes.quickbytes_app/platformChannel");

  void initializeEventStream({
    required Function(String data) onData,
  }) async {
    dynamic val =
        await _platformChannel.invokeMethod("initialize_event_stream");
    if (val) {
      const EventChannel("platform_to_flutter")
          .receiveBroadcastStream()
          .listen((_) {})
        ..onData((data) => onData(data))
        ..onError((err) {
          Logger.instance.e("FlutterLog: $err");
        });
    }
  }

  Future<List<String>> getPendingNotifications() async {
    List<dynamic> pendingNotificationList =
        await _platformChannel.invokeMethod("get_pending_notifications");

    if (pendingNotificationList.isEmpty) return [];

    return pendingNotificationList.map((e) => e.toString()).toList();
  }
}
