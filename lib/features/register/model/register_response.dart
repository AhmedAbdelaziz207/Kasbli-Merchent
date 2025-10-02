import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  final int status;
  final String msg;
  final RegisterData data;

  RegisterResponse({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}

@JsonSerializable()
class RegisterData {
  final String? name;
  final String? phone;
  @JsonKey(name: 'second_phone')
  final String? secondPhone;
  final String? gender;
  @JsonKey(name: 'store_name')
  final String? storeName;
  @JsonKey(name: 'date_of_birth')
  final String? dateOfBirth;
  final String ?fcm;
  final int id;
  final String? lat;
  final String? long;
  final String? address;
  @JsonKey(name: "confirmed_otp")
  final bool? confirmedOtp;

  RegisterData({
    this.name,
    this.phone,
    this.secondPhone,
    this.gender,
    this.storeName,
    this.dateOfBirth,
    this.fcm,
    required this.id,
    this.lat,
    this.long,
    this.address,
    this.confirmedOtp,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) =>
      _$RegisterDataFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDataToJson(this);
}
