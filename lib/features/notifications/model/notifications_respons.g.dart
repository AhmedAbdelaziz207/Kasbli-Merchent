// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_respons.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsResponse _$NotificationsResponseFromJson(
  Map<String, dynamic> json,
) => NotificationsResponse(
  status: (json['status'] as num).toInt(),
  msg: json['msg'] as String,
  data:
      (json['data'] as List<dynamic>)
          .map((e) => NotificationData.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$NotificationsResponseToJson(
  NotificationsResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'msg': instance.msg,
  'data': instance.data,
};

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) =>
    NotificationData(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String?,
      body: json['body'] as String?,
      type: json['type'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$NotificationDataToJson(NotificationData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'type': instance.type,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
