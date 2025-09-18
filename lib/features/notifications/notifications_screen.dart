import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/notifications_cubit.dart';
import 'model/notifications_respons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kasbli_merchant/core/utils/app_keys.dart';


// Data model stays for local UI-only needs

// --- 3. Notification Screen Widget ---
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    // If not preloaded by provider, attempt to load here
    final cubit = context.read<NotificationsCubit>();
    if (cubit.notifications.isEmpty) {
      cubit.getNotifications();
      cubit.getNotificationsCount();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background for the screen
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // No shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Example: go back
          },
        ),
        title: Text(
          AppKeys.notificationsTitle.tr(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          final cubit = context.read<NotificationsCubit>();
          final items = cubit.notifications.map(_mapToUiModel).toList();
          if (state is NotificationsLoading && items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (items.isEmpty) {
            return _buildEmptyNotificationBody();
          }
          return _buildNotificationList(items);
        },
      ),
    );
  }

  NotificationData _mapToUiModel(NotificationData n) {
    return NotificationData(
      title: n.title,
      body: n.body,
      createdAt: n.createdAt,
      id: n.id,
      type: n.type,
      updatedAt: n.updatedAt,
    );
  }

  // --- Empty Notification Body Widget ---
  Widget _buildEmptyNotificationBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/notifications.png', // Placeholder for your bell image
            width: 150,
            height: 150,
            // Add color filter or other styling if needed
          ),
          const SizedBox(height: 20),
          Text(
            AppKeys.noNotificationsYet.tr(),
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // --- Notification List Body Widget ---
  Widget _buildNotificationList(List<NotificationData> list) {
    // Group notifications by day
    final Map<String, List<NotificationData>> groupedNotifications = {};
    for (var notification in list) {
      final String groupKey = _getNotificationGroup(DateTime.parse(notification.createdAt ?? ''));
      if (!groupedNotifications.containsKey(groupKey)) {
        groupedNotifications[groupKey] = [];
      }
      groupedNotifications[groupKey]!.add(notification);
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: groupedNotifications.keys.map((groupKey) {
          final List<NotificationData> notificationsInGroup =
          groupedNotifications[groupKey]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  groupKey,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              ...notificationsInGroup.map((notification) {
                return _buildNotificationCard(notification);
              }),
              const SizedBox(height: 10), // Space between groups
            ],
          );
        }).toList(),
      ),
    );
  }

  // Helper to determine if notification is 'Today' or 'Yesterday'
  String _getNotificationGroup(DateTime notificationTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final notificationDay = DateTime(
        notificationTime.year, notificationTime.month, notificationTime.day);

    if (notificationDay.isAtSameMomentAs(today)) {
      return AppKeys.today.tr();
    } else if (notificationDay.isAtSameMomentAs(yesterday)) {
      return AppKeys.yesterday.tr();
    } else {
      // For notifications older than yesterday, you might show the date
      return AppKeys.older.tr(); // Or DateFormat('MM/dd/yyyy').format(notificationTime);
    }
  }

  // --- Individual Notification Card Widget ---
  Widget _buildNotificationCard(NotificationData notification) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 0, // Flat card as per image
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon with colored background
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: notification.type == 'order' ? Colors.green : Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(
                notification.type == 'order' ? Icons.shopping_cart : Icons.notifications,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 15),
            // Notification details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.body ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            // Time and Count
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatTimeDifference(DateTime.parse(notification.createdAt ?? '')),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
                if (notification.type == 'order') ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      notification.type.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper to format time difference (e.g., "9min ago")
  String _formatTimeDifference(DateTime time) {
    final difference = DateTime.now().difference(time);
    if (difference.inMinutes < 60) {
      return AppKeys.minutesAgo
          .tr(namedArgs: {'value': difference.inMinutes.toString()});
    } else if (difference.inHours < 24) {
      return AppKeys.hoursAgo
          .tr(namedArgs: {'value': difference.inHours.toString()});
    } else {
      return AppKeys.daysAgo
          .tr(namedArgs: {'value': difference.inDays.toString()});
    }
  }
}
