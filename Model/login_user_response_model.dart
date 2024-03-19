import 'dart:convert';

LoginUserResponseModel loginResponseJson(String str) =>
    LoginUserResponseModel.fromJson(json.decode(str));

class LoginUserResponseModel {
  LoginUserResponseModel({
    required this.id,
    required this.name,
    required this.email,
    required this.cnic,
    required this.phone,
    required this.password,
    required this.role,
    required this.friends,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });
  late final String? id;
  late final String? name;
  late final String? email;
  late final int? cnic;
  late final String? phone;
  late final String? password;
  late final String? role;
  late final List<dynamic>? friends;
  late final String? createdAt;
  late final String? updatedAt;
  late final int? v;

  LoginUserResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    cnic = json['cnic'];
    phone = json['phone'];
    password = json['password'];
    role = json['role'];
    friends = List.castFrom<dynamic, dynamic>(json['friends']);
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['cnic'] = cnic;
    _data['phone'] = phone;
    _data['password'] = password;
    _data['role'] = role;
    _data['friends'] = friends;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = v;
    return _data;
  }
}
