import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasbli_merchant/core/di/di.dart';
import 'package:kasbli_merchant/core/network/api_error_model.dart';
import 'package:kasbli_merchant/core/network/api_service.dart';
import 'package:kasbli_merchant/features/notifications/model/notifications_respons.dart';
import 'package:kasbli_merchant/features/notifications/model/notifications_count_response.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dio/dio.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  final ApiService _api = getIt<ApiService>();

  List<NotificationData> notifications = [];
  int notificationsCount = 0;

  Future<void> getNotifications() async {
    emit(NotificationsLoading());
    try {
      final res = await _api.getNotifications();
      notifications = res.data;
      emit(NotificationsLoaded(notifications));
    } catch (e) {
    if (isClosed) return;
      emit(NotificationsFailure(ApiErrorModel.getErrorMessage(e)));
    }
  }

  Future<void> getNotificationsCount() async {
    try {
      final NotificationsCountResponse res = await _api.getNotificationsCount();
      notificationsCount = res.data;
      emit(NotificationsCountLoaded(notificationsCount));
    } catch (e) {
      if (isClosed) return;
      emit(NotificationsCountFailure(ApiErrorModel.getErrorMessage(e)));
    }
  }

  Future<void> updateFcmToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await _api.updateFcm(FormData.fromMap({"fcm": token}));
        emit(UpdateFcmSuccess());
      } else {
        emit(UpdateFcmFailure('FCM token is null'));
      }
    } catch (e) {
      emit(UpdateFcmFailure(e.toString()));
    }
  }
}

