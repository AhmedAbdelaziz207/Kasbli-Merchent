part of 'notifications_cubit.dart';

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationData> notifications;
  NotificationsLoaded(this.notifications);
}

class NotificationsFailure extends NotificationsState {
  final String message;
  NotificationsFailure(this.message);
}

class NotificationsCountLoaded extends NotificationsState {
  final int count;
  NotificationsCountLoaded(this.count);
}

class NotificationsCountFailure extends NotificationsState {
  final String message;
  NotificationsCountFailure(this.message);
}

class UpdateFcmSuccess extends NotificationsState {}

class UpdateFcmFailure extends NotificationsState {
  final String message;
  UpdateFcmFailure(this.message);
}
