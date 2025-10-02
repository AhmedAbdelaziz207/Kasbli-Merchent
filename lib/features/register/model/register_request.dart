import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'phone')
  final String phone;

  @JsonKey(name: 'second_phone')
  final String? secondPhone;

  @JsonKey(name: 'gender')
  final String gender;

  @JsonKey(name: 'date_of_birth')
  final String dateOfBirth;

  @JsonKey(name: 'store_name')
  final String storeName;

  @JsonKey(name: 'password')
  final String password;

  @JsonKey(name: 'password_confirmation')
  final String passwordConfirmation;

  @JsonKey(name: 'fcm')
  final String fcm;

  @JsonKey(name: 'lat')
  final String lat;

  @JsonKey(name: 'long')
  final String long;

  @JsonKey(name: 'address')
  final String address;

  RegisterRequest({
    required this.name,
    required this.phone,
    this.secondPhone,
    required this.gender,
    required this.dateOfBirth,
    required this.storeName,
    required this.password,
    required this.passwordConfirmation,
    required this.fcm,
    required this.lat,
    required this.long,
    required this.address,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
