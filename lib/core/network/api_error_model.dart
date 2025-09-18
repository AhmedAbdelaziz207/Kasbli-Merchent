import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final int? status;
  final String? msg;
  final dynamic data;

  ApiErrorModel({this.status, this.msg, this.data});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      // Server responded with an error
      if (error.response?.data != null) {
        try {

          return error.response?.data['msg'] ?? 'Request failed.';
        } catch (_) {
          return 'Request failed with status: ${error.response?.statusCode ?? 'Unknown'}';
        }
      } else {
        return 'Network error: ${error.message}';
      }
    }

    // Any other error
    return 'Unexpected error: ${error.toString()}';
  }
}