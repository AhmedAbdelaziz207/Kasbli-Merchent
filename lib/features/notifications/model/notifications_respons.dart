import 'package:json_annotation/json_annotation.dart';
part 'notifications_respons.g.dart';
@JsonSerializable()
class NotificationsResponse {
  final int status;
  final String msg;
  final List<NotificationData> data;

  NotificationsResponse({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsResponseToJson(this);
}

@JsonSerializable()
class NotificationData {
  final int id;
  final String? title;
  final String? body;
  final String? type;
  final String? createdAt;
  final String? updatedAt;

  NotificationData({
    required this.id,
    this.title,
    this.body,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDataToJson(this);
}

