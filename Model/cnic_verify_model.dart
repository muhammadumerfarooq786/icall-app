class CnicVerifyModel {
  CnicVerifyModel({
    required this.cnic,
  });
  late final String? cnic;

  CnicVerifyModel.fromJson(Map<String, dynamic> json) {
    cnic = json['cnic'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cnic'] = cnic;
    return _data;
  }
}
