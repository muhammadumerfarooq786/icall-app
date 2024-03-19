class NameVerifyModel {
  NameVerifyModel({
    required this.name,
  });
  late final String? name;

  NameVerifyModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    return _data;
  }
}
