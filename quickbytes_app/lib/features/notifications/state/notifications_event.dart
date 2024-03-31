part of 'notifications_bloc.dart';

@immutable
sealed class NotificationsEvent {
  const NotificationsEvent();
}

final class NotificationTapped extends NotificationsEvent {
  final String data;
  const NotificationTapped(this.data);
}
