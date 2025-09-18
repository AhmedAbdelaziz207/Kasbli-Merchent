// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_count_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsCountResponse _$NotificationsCountResponseFromJson(
  Map<String, dynamic> json,
) => NotificationsCountResponse(
  status: (json['status'] as num).toInt(),
  msg: json['msg'] as String,
  data: (json['data'] as num).toInt(),
);

Map<String, dynamic> _$NotificationsCountResponseToJson(
  NotificationsCountResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'msg': instance.msg,
  'data': instance.data,
};
