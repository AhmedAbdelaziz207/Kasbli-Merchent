class UniquePhoneResponse {
  final int status;
  final String msg;
  final bool data ;

  UniquePhoneResponse({required this.status, required this.msg, required this.data});

  factory UniquePhoneResponse.fromJson(Map<String, dynamic> json) {
    return UniquePhoneResponse(
      status: json['status'],
      msg: json['msg'],
      data: json['data'],
    );
  }

}