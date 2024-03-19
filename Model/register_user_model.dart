class RegisterUserModel {
  RegisterUserModel({
    required this.name,
    required this.email,
    required this.cnic,
    required this.phone,
    required this.password,
  });
  late final String? name;
  late final String? email;
  late final String? cnic;
  late final String? phone;
  late final String? password;

  RegisterUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    cnic = json['cnic'];
    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    _data['cnic'] = cnic;
    _data['phone'] = phone;
    _data['password'] = password;
    return _data;
  }
}
