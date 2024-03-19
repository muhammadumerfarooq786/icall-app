import 'package:flutter/material.dart';
import 'package:icall/Components/SignUpComponents/phoneverify.dart';
import 'package:icall/Components/SignUpComponents/policycheck.dart';
import 'package:email_auth/email_auth.dart';

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  // shape: RoundedRectangleBorder(
  //   borderRadius: BorderRadius.circular(10),
  // ),
  primary: Colors.white,
  // backgroundColor: Colors.blueAccent.shade200,
);

class EmailCode extends StatefulWidget {
  final String name;
  final String password;
  final String cnic;
  final String email;
  final EmailAuth emailAuth;
  const EmailCode(
      {Key? key,
      required this.name,
      required this.password,
      required this.cnic,
      required this.email,
      required this.emailAuth})
      : super(key: key);
  @override
  State<EmailCode> createState() => _EmailCodeState();
}

class _EmailCodeState extends State<EmailCode> {
  final _emailverifycodeformKey = GlobalKey<FormState>();
  TextEditingController _emailcode = TextEditingController();

  bool verify() {
    bool result = widget.emailAuth.validateOtp(
        recipientMail: widget.email, userOtp: _emailcode.value.text);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _emailverifycodeformKey,
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
                                      image: AssetImage('assets/light-1.png'))),
                            )),
                        Positioned(
                            left: 140,
                            width: 80,
                            height: 150,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/light-2.png'))),
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
                                "Email Veification Code",
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
                                  controller: _emailcode,
                                  validator: (value) {
                                    if (value == null || value.isEmpty)
                                      return "Please Enter the Verification Code";

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Verification Code",
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
                              child: Text("Verify And Proceed",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              onPressed: () {
                                if (_emailverifycodeformKey.currentState!
                                    .validate()) {
                                  bool validate = verify();
                                  if (validate) {
                                    final name = widget.name;
                                    final password = widget.password;
                                    final email = widget.email;
                                    final emailcode = _emailcode.text;

                                    // print(firstname);
                                    // print(lastname);
                                    // print(password);
                                    // print(email);
                                    // print(emailcode);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => PhoneVerify(
                                            name: name,
                                            password: password,
                                            cnic: widget.cnic,
                                            email: email),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Invalid Code. Please Try Again!!')),
                                    );
                                  }
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
        ));
  }
}
