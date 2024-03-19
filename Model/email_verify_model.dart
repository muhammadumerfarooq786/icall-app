class EmailVerifyModel {
  EmailVerifyModel({
    required this.email,
  });
  late final String? email;

  EmailVerifyModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    return _data;
  }
}
