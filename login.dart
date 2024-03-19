import 'package:flutter/material.dart';
import 'package:icall/Components/GuestMode/guestbottombar.dart';
import 'package:icall/Model/login_user_model.dart';
import 'package:icall/services/api_service.dart';
import 'package:icall/signup.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import 'home.dart';

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  // shape: RoundedRectangleBorder(
  //   borderRadius: BorderRadius.circular(10),
  // ),
  primary: Colors.white,
  // backgroundColor: Colors.blueAccent.shade200,
);

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isApiCallProcess = false;
  final _loginformKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String email;
    String password;
    return Scaffold(
        backgroundColor: Colors.white,
        body: ProgressHUD(
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: SingleChildScrollView(
            child: Container(
              child: Form(
                key: _loginformKey,
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
                                  "Login",
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
                                              color: Colors.grey.shade100))),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _email,
                                    validator: (value) {
                                      if (value == null || value.isEmpty)
                                        return "Email can't be empty";

                                      if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(value) ==
                                          false) return "Enter a Valid Email";

                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email Address",
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
                                        return "Please Enter A Valid Password";

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
                                child: Text("Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                onPressed: () {
                                  if (_loginformKey.currentState!.validate()) {
                                    setState(() {
                                      email = _email.text;
                                      password = _password.text;
                                      isApiCallProcess = true;
                                    });

                                    print(_email.text);
                                    print(_password.text);

                                    LoginUserModel model = LoginUserModel(
                                        email: _email.text,
                                        password: _password.text,
                                        role: "public");

                                    APIService.loginUser(model)
                                        .then((response) {
                                      setState(() {
                                        isApiCallProcess = false;
                                      });
                                      if (response) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => HomePage(),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Invalid Email Or Password!!')),
                                        );
                                      }
                                    });

                                    // final formData = _loginformKey.currentState?._;
                                    // If the form is valid, display a Snackbar.
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //     SnackBar(content: Text('Processing...')));

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
                                "New User ?",
                              ),
                              Container(
                                child: Center(
                                  child: TextButton(
                                    style: flatButtonStyle,
                                    child: Text("SignUp",
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                143, 148, 251, 1))),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => SignUp(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Guest User ?",
                              ),
                              Container(
                                child: Center(
                                  child: TextButton(
                                    style: flatButtonStyle,
                                    child: Text("Try Our System",
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                143, 148, 251, 1))),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => GuestBottomBar(),
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
