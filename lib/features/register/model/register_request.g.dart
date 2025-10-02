// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      name: json['name'] as String,
      phone: json['phone'] as String,
      secondPhone: json['second_phone'] as String?,
      gender: json['gender'] as String,
      dateOfBirth: json['date_of_birth'] as String,
      storeName: json['store_name'] as String,
      password: json['password'] as String,
      passwordConfirmation: json['password_confirmation'] as String,
      fcm: json['fcm'] as String,
      lat: json['lat'] as String,
      long: json['long'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'second_phone': instance.secondPhone,
      'gender': instance.gender,
      'date_of_birth': instance.dateOfBirth,
      'store_name': instance.storeName,
      'password': instance.password,
      'password_confirmation': instance.passwordConfirmation,
      'fcm': instance.fcm,
      'lat': instance.lat,
      'long': instance.long,
      'address': instance.address,
    };
