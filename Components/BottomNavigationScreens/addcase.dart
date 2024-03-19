import 'dart:convert';
import 'dart:io';
// import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:icall/Model/login_user_response_model.dart';
import 'package:icall/Model/user_new_post_model.dart';
import 'package:icall/home.dart';
import 'package:icall/services/api_service.dart';
import 'dart:async';
import 'package:async/async.dart';
import 'package:icall/services/shared_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:location/location.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
// import 'package:path/path.dart';
// import 'package:ffi/ffi.dart';

class AddCase extends StatefulWidget {
  @override
  State<AddCase> createState() => _AddCaseState();
}

class _AddCaseState extends State<AddCase> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 40,
              left: 30,
              right: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Add New Case",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontFamily: 'CentraleSansRegular'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Please Fill The Credentials",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontFamily: 'CentraleSansRegular',
                            fontWeight: FontWeight.w100),
                      ),
                    ],
                  )
                ],
              ),
            ),
            AddCaseForm(),
          ],
        ),
      ),
    );
  }
}

// Create a Form widget.
class AddCaseForm extends StatefulWidget {
  @override
  AddCaseFormState createState() {
    return AddCaseFormState();
  }
}

// Create a corresponding State class, which holds data related to the form.
class AddCaseFormState extends State<AddCaseForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  TextEditingController _description = TextEditingController();
  late LoginUserResponseModel loginDetails;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  LocationData? _userLocation;

  Future<void> _getUserLocation() async {
    Location location = Location();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final _locationData = await location.getLocation();
    setState(() {
      _userLocation = _locationData;
    });

    readLoginDetails();
  }

  Future<void> readLoginDetails() async {
    var Details = await SharedService.loginDetails();

    setState(() {
      loginDetails = Details!;
    });
  }

  @override
  void initState() {
    _getUserLocation();
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  String selectedCategory = "accident";
  List<DropdownMenuItem<String>> get dropdownCategory {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Accident"), value: "accident"),
      DropdownMenuItem(child: Text("Home Violence"), value: "homeviolence"),
      DropdownMenuItem(child: Text("Theft"), value: "theft"),
      DropdownMenuItem(child: Text("Murder"), value: "murder"),
      DropdownMenuItem(child: Text("Other"), value: "others"),
    ];
    return menuItems;
  }

  String selectedCity = "islamabad";
  List<DropdownMenuItem<String>> get dropdownCity {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Islamabad"), value: "islamabad"),
      DropdownMenuItem(child: Text("Peshawar"), value: "peshawar"),
      DropdownMenuItem(child: Text("Lahore"), value: "lahore"),
      DropdownMenuItem(child: Text("Karachi"), value: "karachi"),
      DropdownMenuItem(child: Text("Multan"), value: "multan"),
    ];
    return menuItems;
  }

  // Future<Image> convertFileToImage(File picture) async {
  //   List<int> imageBase64 = await picture.readAsBytesSync();
  //   String imageAsString = await base64Encode(imageBase64);
  //   Uint8List uint8list = await base64.decode(imageAsString);
  //   Image image = await Image.memory(uint8list);
  //   return image;
  // }

  File? _imageFile;
  var IsImageSet = false;
  final ImagePicker _picker = ImagePicker();
  late Image image_data;

  FilePickerResult? result;
  PlatformFile? file;
  List<File>? files;
  bool isApiCallProcess = false;

  Future<void> uploadImage() async {
    String fileName = _imageFile!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file":
          await MultipartFile.fromFile(_imageFile!.path, filename: fileName),
      "category": selectedCategory,
      "description": _description.text,
      "location": _userLocation!.latitude.toString() +
          "," +
          _userLocation!.longitude.toString() +
          "," +
          "13.567",
      "userName": loginDetails.name!,
      "cityName": selectedCity,
    });
    var response = await Dio().post(
        "http://10.7.104.33:8000/api/users/add/postfromphone",
        data: formData);

    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        isApiCallProcess = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post Added Successfully!!')),
      );

      print('image uploaded');
    } else {
      setState(() {
        isApiCallProcess = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error While Registering Post!!')),
      );
      print('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      key: UniqueKey(),
      child: Container(
        margin: EdgeInsets.only(top: 120, left: 20, right: 20),
        // margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                imageProfile(),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text("Category : \t\t\t\t\t\t\t\t",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    DropdownButton(
                        value: selectedCategory,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCategory = newValue!;
                          });
                        },
                        items: dropdownCategory),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text("Select City : \t\t\t\t\t\t\t\t",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    DropdownButton(
                        value: selectedCity,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCity = newValue!;
                          });
                        },
                        items: dropdownCity),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _description,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal)),
                    icon: const Icon(Icons.description),
                    hintText: ' Case Description',
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Case Description';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Container(
                        child: new ElevatedButton(
                      child: const Text('Submit'),
                      onPressed: () {
                        // It returns true if the form is valid, otherwise returns false
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isApiCallProcess = true;
                          });

                          // if (files!.isEmpty) {
                          //   print("Empty List");
                          // }
                          print(selectedCategory);
                          print(selectedCity);
                          print(_description.text);
                          print(_imageFile);
                          print("jj");
                          print(_picker);
                          print("jj");
                          print(base64Encode(_imageFile!.readAsBytesSync()));
                          uploadImage();
                        }
                      },
                    )),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pickFiles(String? filetype) async {
    switch (filetype) {
      case 'MultipleFile':
        result = await FilePicker.platform.pickFiles(allowMultiple: true);
        if (result == null) return;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Files Has Been Selected Successfuly')));
        setState(() {
          List<File> files = result!.paths.map((path) => File(path!)).toList();
          print(files);
        });

        break;
    }
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        _imageFile == null
            ? Image.asset(
                "assets/image3.png",
                width: 250,
                height: 200,
              )
            : Image.file(
                _imageFile!,
                width: 250,
                height: 200,
              )
        // IsImageSet
        //     ? FileImage(_imageFile!)
        //     : const AssetImage("assets/profile.jpeg")
        ,
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Feature Image",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            ElevatedButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            SizedBox(
              width: 30,
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    print(source);
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = File(pickedFile!.path);
      // image_data = pickedFile as Image;
      IsImageSet = true;
    });
  }
}
