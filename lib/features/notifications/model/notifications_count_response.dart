import 'package:json_annotation/json_annotation.dart';

part 'notifications_count_response.g.dart';

@JsonSerializable()
class NotificationsCountResponse {
  final int status;
  final String msg;
  final int data;

  NotificationsCountResponse({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory NotificationsCountResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsCountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsCountResponseToJson(this);
}
