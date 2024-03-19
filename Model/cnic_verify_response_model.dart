import 'dart:convert';

CnicVerifyResponseModel registerResponseJson(String str) =>
    CnicVerifyResponseModel.fromJson(json.decode(str));

class CnicVerifyResponseModel {
  CnicVerifyResponseModel({
    required this.CnicSuccess,
    required this.message,
    required this.stack,
  });
  late final String? CnicSuccess;
  late final String? message;
  late final String? stack;

  CnicVerifyResponseModel.fromJson(Map<String, dynamic> json) {
    CnicSuccess = json['CnicSuccess'] != null ? json['CnicSuccess'] : null;
    message = json['message'] != null ? json['message'] : null;
    stack = json['stack'] != null ? json['stack'] : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['CnicSuccess'] = CnicSuccess;
    _data['message'] = message;
    _data['stack'] = stack;
    return _data;
  }
}
