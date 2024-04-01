import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quickbytes_app/features/notifications/data/models/base_notification.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationState> {
  NotificationsBloc() : super(NotificationState.initial()) {
    on<NotificationTapped>((event, emit) {
      emit(NotificationState.withData(notificationData: event.data));
    });
  }
}
