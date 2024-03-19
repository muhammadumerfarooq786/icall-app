class LoginUserModel {
  LoginUserModel({
    required this.email,
    required this.password,
    required this.role,
  });
  late final String? email;
  late final String? password;
  late final String? role;

  LoginUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;
    _data['role'] = role;
    return _data;
  }
}
