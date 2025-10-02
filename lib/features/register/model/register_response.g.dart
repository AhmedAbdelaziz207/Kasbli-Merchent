// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      status: (json['status'] as num).toInt(),
      msg: json['msg'] as String,
      data: RegisterData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'data': instance.data,
    };

RegisterData _$RegisterDataFromJson(Map<String, dynamic> json) => RegisterData(
  name: json['name'] as String?,
  phone: json['phone'] as String?,
  secondPhone: json['second_phone'] as String?,
  gender: json['gender'] as String?,
  storeName: json['store_name'] as String?,
  dateOfBirth: json['date_of_birth'] as String?,
  fcm: json['fcm'] as String?,
  id: (json['id'] as num).toInt(),
  lat: json['lat'] as String?,
  long: json['long'] as String?,
  address: json['address'] as String?,
  confirmedOtp: json['confirmed_otp'] as bool?,
);

Map<String, dynamic> _$RegisterDataToJson(RegisterData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'second_phone': instance.secondPhone,
      'gender': instance.gender,
      'store_name': instance.storeName,
      'date_of_birth': instance.dateOfBirth,
      'fcm': instance.fcm,
      'id': instance.id,
      'lat': instance.lat,
      'long': instance.long,
      'address': instance.address,
      'confirmed_otp': instance.confirmedOtp,
    };
