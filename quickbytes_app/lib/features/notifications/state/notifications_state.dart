part of 'notifications_bloc.dart';

final class NotificationState extends Equatable {
  const NotificationState._({
    required this.notificationData,
  });

  const NotificationState.withData({required String notificationData})
      : this._(notificationData: notificationData);

  const NotificationState.initial() : this._(notificationData: '');

  final String notificationData;

  @override
  List<Object> get props => [notificationData];
}
