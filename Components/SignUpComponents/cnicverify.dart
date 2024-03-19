import 'package:flutter/material.dart';
import 'package:icall/Components/SignUpComponents/emailverify.dart';
import 'package:icall/Model/cnic_verify_model.dart';
import 'package:icall/services/api_service.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  // shape: RoundedRectangleBorder(
  //   borderRadius: BorderRadius.circular(10),
  // ),
  primary: Colors.white,
  // backgroundColor: Colors.blueAccent.shade200,
);

class CnicVerify extends StatefulWidget {
  final String name;
  final String password;

  const CnicVerify({Key? key, required this.name, required this.password})
      : super(key: key);
  @override
  State<CnicVerify> createState() => _CnicVerifyState();
}

class _CnicVerifyState extends State<CnicVerify> {
  bool isApiCallProcess = false;
  bool submitValid = false;
  final _CnicVerifyformKey = GlobalKey<FormState>();
  TextEditingController _cnic = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ProgressHUD(
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: SingleChildScrollView(
            child: Container(
              child: Form(
                key: _CnicVerifyformKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 400,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/background.png'),
                              fit: BoxFit.fill)),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                              left: 30,
                              width: 80,
                              height: 200,
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage('assets/light-1.png'))),
                              )),
                          Positioned(
                              left: 140,
                              width: 80,
                              height: 150,
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage('assets/light-2.png'))),
                              )),
                          Positioned(
                            right: 40,
                            top: 40,
                            width: 80,
                            height: 150,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/clock.png'))),
                            ),
                          ),
                          Positioned(
                            child: Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  "CNIC Verification",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    controller: _cnic,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty)
                                        return "CNIC can't be empty";

                                      if (value.length != 13)
                                        return "CNIC must be of length 13";

                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "xxxxxxxxxxxxx",
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade400)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, .6),
                                ])),
                            child: Center(
                              child: TextButton(
                                style: flatButtonStyle,
                                child: Text("Next",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                onPressed: () {
                                  if (_CnicVerifyformKey.currentState!
                                      .validate()) {
                                    setState(() {
                                      isApiCallProcess = true;
                                    });

                                    CnicVerifyModel model = CnicVerifyModel(
                                      cnic: _cnic.text,
                                    );

                                    APIService.cnicVerify(model)
                                        .then((response) {
                                      setState(() {
                                        isApiCallProcess = false;
                                      });
                                      if (response) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => EmailVerify(
                                              name: widget.name,
                                              password: widget.password,
                                              cnic: _cnic.text,
                                            ),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'CNIC Already Registered!!')),
                                        );
                                      }
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
