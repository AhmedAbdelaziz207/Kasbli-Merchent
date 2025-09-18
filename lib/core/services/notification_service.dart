import 'dart:io';
import 'package:easy_notify/easy_notify.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer';
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await Firebase.initializeApp();
    await EasyNotify.init();
    await EasyNotifyPermissions.requestAll();
    await _requestPermissions();
    await _setupFCMHandlers();
    log("Fcm Token : ${await _firebaseMessaging.getToken()}"); 
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS) {
      final settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      debugPrint('iOS permission: ${settings.authorizationStatus}');
    } else if (Platform.isAndroid) {
      if (await Permission.notification.request().isGranted) {
        debugPrint('Android notification permission granted');
      } else {
        debugPrint('Notification permission denied');
      }
    }
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp();
    debugPrint('Background FCM message: ${message.messageId}');
  }

  Future<void> _setupFCMHandlers() async {
    _firebaseMessaging.onTokenRefresh.listen((token) {
      debugPrint('FCM Token refreshed: $token');
      // TODO: Send token to server
    });

    final token = await _firebaseMessaging.getToken();
    debugPrint('FCM Token: $token');

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('Foreground FCM Message: ${message.data}');
    if (message.notification != null) {
      EasyNotify.showBasicNotification(
        id: message.hashCode,
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
      );
    }
  }

  void _handleNotificationTap(RemoteMessage message) {
    debugPrint('Notification Tapped: ${message.data}');
    // TODO: Navigate based on message data
  }

  // Public methods
  Future<void> showLocalNotification({
    required String title,
    required String body,
    String? payload,
    int id = 0,
  }) async {
    await EasyNotify.showBasicNotification(id: id, title: title, body: body);
  }

  Future<void> showScheduledNotification({
    required String title,
    required String body,
    required Duration delay,
    int id = 1,
  }) async {
    await EasyNotify.showScheduledNotification(
      id: id,
      title: title,
      body: body,
      duration: delay,
    );
  }

  Future<void> showRepeatedNotification({
    required String title,
    required String body,
    Duration interval = const Duration(days: 1),
    int id = 2,
  }) async {
    await EasyNotify.showRepeatedNotification(id: id, title: title, body: body);
  }

  Future<void> cancelNotification(int id) async {
    await EasyNotify.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await EasyNotify.cancelAll();
  }

  Future<String?> getFCMToken() async {
    return await _firebaseMessaging.getToken();
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}
