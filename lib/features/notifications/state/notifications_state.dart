part of 'notifications_bloc.dart';

// ignore: must_be_immutable
final class NotificationState extends Equatable {
  NotificationState._({
    required this.notificationData,
  }) {
    if (notificationData.isEmpty) return;
    notification = BaseNotification.fromJson(jsonDecode(notificationData));
  }

  NotificationState.withData({required String notificationData})
      : this._(notificationData: notificationData);

  NotificationState.initial() : this._(notificationData: '');

  final String notificationData;
  late BaseNotification notification;

  @override
  List<Object> get props => [notificationData];
}
