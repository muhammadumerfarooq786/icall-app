class AdminNewsModel {
  AdminNewsModel({
    required this.id,
    required this.subject,
    required this.location,
    required this.description,
    required this.userName,
    required this.timestamp,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
  late final String? id;
  late final String? subject;
  late final String? location;
  late final String? description;
  late final String? userName;
  late final String? timestamp;
  late final String? createdAt;
  late final String? updatedAt;
  late final int? V;

  AdminNewsModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    subject = json['subject'];
    location = json['location'];
    description = json['description'];
    userName = json['userName'];
    timestamp = json['timestamp'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['subject'] = subject;
    _data['location'] = location;
    _data['description'] = description;
    _data['userName'] = userName;
    _data['timestamp'] = timestamp;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
  }
}
