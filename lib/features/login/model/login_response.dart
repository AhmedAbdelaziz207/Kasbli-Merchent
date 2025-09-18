import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class LoginResponse {
  final int? status;
  final String? msg;
  final LoginData? data;

  LoginResponse({
    this.status,
    this.msg,
    this.data,
  });

  // Manual safe parsing to avoid runtime cast exceptions
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: _asInt(json['status']),
      msg: json['msg'] as String?,
      data: json['data'] is Map<String, dynamic>
          ? LoginData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status,
        'msg': msg,
        'data': data?.toJson(),
      };
}

class LoginData {
  final int? id;
  final String? name;
  final String? phone;
  @JsonKey(name: 'second_phone')
  final String? secondPhone;
  final String? gender;
  @JsonKey(name: 'store_name')
  final String? storeName;
  @JsonKey(name: 'date_of_birth')
  final String? dateOfBirth;
  final String? fcm;
  final String? wallet;
  final String? token;

  LoginData({
    this.id,
    this.name,
    this.phone,
    this.secondPhone,
    this.gender,
    this.storeName,
    this.dateOfBirth,
    this.fcm,
    this.wallet,
    this.token,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      id: _asInt(json['id']),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      secondPhone: json['second_phone'] as String?,
      gender: json['gender'] as String?,
      storeName: json['store_name'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      fcm: json['fcm'] as String?,
      wallet: json['wallet'] as String?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'phone': phone,
        'second_phone': secondPhone,
        'gender': gender,
        'store_name': storeName,
        'date_of_birth': dateOfBirth,
        'fcm': fcm,
        'wallet': wallet,
        'token': token,
      };
}

// Helpers for safe numeric parsing
int? _asInt(dynamic v) {
  if (v == null) return null;
  if (v is num) return v.toInt();
  if (v is String) return int.tryParse(v);
  return null;
}

double? _asDouble(dynamic v) {
  if (v == null) return null;
  if (v is num) return v.toDouble();
  if (v is String) return double.tryParse(v);
  return null;
}
