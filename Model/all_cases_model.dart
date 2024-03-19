class AllCasesModel {
  AllCasesModel({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.reportername,
    required this.reporterphonenumber,
    required this.evidencebox,
    required this.location,
    required this.departmentId,
    required this.status,
    required this.cityName,
    required this.timestamp,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
  late final String? id;
  late final String? title;
  late final String? category;
  late final String? description;
  late final String? reportername;
  late final String? reporterphonenumber;
  late final List<String>? evidencebox;
  late final String? location;
  late final String? departmentId;
  late final String? status;
  late final String? cityName;
  late final String? timestamp;
  late final String? createdAt;
  late final String? updatedAt;
  late final int? V;

  AllCasesModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    category = json['category'];
    description = json['description'];
    reportername = json['reportername'];
    reporterphonenumber = json['reporterphonenumber'];
    evidencebox = List.castFrom<dynamic, String>(json['evidencebox']);
    location = json['location'];
    departmentId = json['department_id'];
    status = json['status'];
    cityName = json['cityName'];
    timestamp = json['timestamp'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['title'] = title;
    _data['category'] = category;
    _data['description'] = description;
    _data['reportername'] = reportername;
    _data['reporterphonenumber'] = reporterphonenumber;
    _data['evidencebox'] = evidencebox;
    _data['location'] = location;
    _data['department_id'] = departmentId;
    _data['status'] = status;
    _data['cityName'] = cityName;
    _data['timestamp'] = timestamp;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
  }
}
