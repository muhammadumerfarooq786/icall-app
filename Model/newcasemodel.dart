import 'dart:io';

class NewCaseModel {
  int? id;
  File? imageFile;
  String title;
  String description;
  String name;
  String phone;
  String city;
  List<File>? files;
  NewCaseModel(
      {this.id,
      required this.imageFile,
      required this.title,
      required this.description,
      required this.name,
      required this.phone,
      required this.city,
      required this.files});

  factory NewCaseModel.fromMap(Map<String, dynamic> json) => NewCaseModel(
      id: json['id'],
      imageFile: json["imageFile"],
      title: json["title"],
      description: json["description"],
      name: json["name"],
      phone: json["phone"],
      city: json["city"],
      files: json["files"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "imageFile": imageFile,
        "title": title,
        "description": description,
        "name": name,
        "phone": phone,
        "city": city,
        "files": files,
      };
}
