import 'package:flutter/material.dart';
import 'package:icall/Components/SignUpComponents/cnicverify.dart';
import 'package:icall/Model/nameVerifyModel.dart';
import 'package:icall/login.dart';
import 'package:icall/services/api_service.dart';
import 'home.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  // shape: RoundedRectangleBorder(
  //   borderRadius: BorderRadius.circular(10),
  // ),
  primary: Colors.white,
  // backgroundColor: Colors.blueAccent.shade200,
);

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isApiCallProcess = false;
  final _signupformKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();
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
                key: _signupformKey,
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
                                  "SignUp",
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
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: TextFormField(
                                    controller: _name,
                                    validator: (value) {
                                      if (value == null || value.isEmpty)
                                        return "Name can't be empty";

                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Username",
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade400)),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    obscureText: true,
                                    controller: _password,
                                    validator: (value) {
                                      if (value == null || value.isEmpty)
                                        return "Please Set A Password";

                                      if (value.length <= 6 ||
                                          value.length >= 16)
                                        return "Password Must be in between 7 to 15 Length Long";

                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
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
                                  if (_signupformKey.currentState!.validate()) {
                                    setState(() {
                                      isApiCallProcess = true;
                                    });
                                    NameVerifyModel model = NameVerifyModel(
                                      name: _name.text,
                                    );

                                    APIService.nameVerify(model)
                                        .then((response) {
                                      setState(() {
                                        isApiCallProcess = false;
                                      });
                                      if (response) {
                                        final name = _name.text;
                                        final password = _password.text;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => CnicVerify(
                                                name: name, password: password),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'User Name Already Exists. Please Chosse Another!!')),
                                        );
                                      }
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already Have An Account ?",
                              ),
                              Container(
                                child: Center(
                                  child: TextButton(
                                    style: flatButtonStyle,
                                    child: Text("LogIn",
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                143, 148, 251, 1))),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => Login(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
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
