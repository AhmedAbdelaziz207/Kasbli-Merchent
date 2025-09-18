// import 'package:flutter/material.dart';
// import '../services/notification_service.dart';
//
// class NotificationHelper {
//   static final NotificationService _notificationService = NotificationService();
//
//   // Show immediate local notification
//   static Future<void> showNotification({
//     required String title,
//     required String body,
//     String? payload,
//     String channelId = 'default_channel',
//     int id = 0,
//   }) async {
//     await _notificationService.showLocalNotification(
//       title: title,
//       body: body,
//       payload: payload,
//       channelId: channelId,
//       id: id,
//     );
//   }
//
//   // // Schedule local notification
//   // static Future<void> scheduleNotification({
//   //   required String title,
//   //   required String body,
//   //   required DateTime scheduledDate,
//   //   String? payload,
//   //   String channelId = 'default_channel',
//   //   int id = 0,
//   // }) async {
//   //   await _notificationService.scheduleLocalNotification(
//   //     title: title,
//   //     body: body,
//   //     scheduledDate: scheduledDate,
//   //     payload: payload,
//   //     channelId: channelId,
//   //     id: id,
//   //   );
//   // }
//
//   // Show order update notification
//   static Future<void> showOrderUpdateNotification({
//     required String orderId,
//     required String status,
//     int id = 0,
//   }) async {
//     await _notificationService.showLocalNotification(
//       title: 'Order Update',
//       body: 'Your order #$orderId is now $status',
//       payload: 'order_update:$orderId',
//       channelId: 'order_updates_channel',
//       id: id,
//     );
//   }
//
//   // Show promotion notification
//   static Future<void> showPromotionNotification({
//     required String title,
//     required String description,
//     String? discountCode,
//     int id = 0,
//   }) async {
//     String body = description;
//     if (discountCode != null) {
//       body += '\nUse code: $discountCode';
//     }
//
//     await _notificationService.showLocalNotification(
//       title: title,
//       body: body,
//       payload: discountCode != null ? 'promotion:$discountCode' : 'promotion',
//       channelId: 'promotions_channel',
//       id: id,
//     );
//   }
//
//   // Show high importance notification
//   static Future<void> showHighImportanceNotification({
//     required String title,
//     required String body,
//     String? payload,
//     int id = 0,
//   }) async {
//     await _notificationService.showLocalNotification(
//       title: title,
//       body: body,
//       payload: payload,
//       channelId: 'high_importance_channel',
//       id: id,
//     );
//   }
//
//   // Cancel specific notification
//   static Future<void> cancelNotification(int id) async {
//     await _notificationService.cancelNotification(id);
//   }
//
//   // Cancel all notifications
//   static Future<void> cancelAllNotifications() async {
//     await _notificationService.cancelAllNotifications();
//   }
//
//   // Get FCM token
//   static Future<String?> getFCMToken() async {
//     return await _notificationService.getFCMToken();
//   }
//
//   // Subscribe to topic
//   static Future<void> subscribeToTopic(String topic) async {
//     await _notificationService.subscribeToTopic(topic);
//   }
//
//   // Unsubscribe from topic
//   static Future<void> unsubscribeFromTopic(String topic) async {
//     await _notificationService.unsubscribeFromTopic(topic);
//   }
//
//   // Subscribe to order updates
//   static Future<void> subscribeToOrderUpdates() async {
//     await _notificationService.subscribeToTopic('order_updates');
//   }
//
//   // Subscribe to promotions
//   static Future<void> subscribeToPromotions() async {
//     await _notificationService.subscribeToTopic('promotions');
//   }
//
//   // Subscribe to general notifications
//   static Future<void> subscribeToGeneralNotifications() async {
//     await _notificationService.subscribeToTopic('general');
//   }
// }
