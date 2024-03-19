import 'package:flutter/material.dart';
import 'package:icall/Components/SignUpComponents/emailcode.dart';
import 'package:email_auth/email_auth.dart';
import 'package:icall/Model/email_verify_model.dart';
import 'package:icall/services/api_service.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  // shape: RoundedRectangleBorder(
  //   borderRadius: BorderRadius.circular(10),
  // ),
  primary: Colors.white,
  // backgroundColor: Colors.blueAccent.shade200,
);

class EmailVerify extends StatefulWidget {
  final String name;
  final String password;
  final String cnic;

  const EmailVerify(
      {Key? key,
      required this.name,
      required this.password,
      required this.cnic})
      : super(key: key);
  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  bool submitValid = false;
  bool isApiCallProcess = false;
  EmailAuth? emailAuth;
  final _emailverifyformKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the package
    emailAuth = new EmailAuth(
      sessionName: "Verify Your Email With Icall",
    );

    /// Configuring the remote server
    // emailAuth.config(remoteServerConfiguration);
  }

  void sendOtp() async {
    print(_email.value.text);
    bool result = await emailAuth!
        .sendOtp(recipientMail: _email.value.text, otpLength: 5);
    if (result) {
      setState(() {
        submitValid = true;
        isApiCallProcess = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('OTP Send Successfully. Please Check Your Email!')),
      );
      final name = widget.name;
      final password = widget.password;
      final cnic = widget.cnic;
      final email = _email.text;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EmailCode(
              name: name,
              password: password,
              cnic: cnic,
              email: email,
              emailAuth: emailAuth ?? EmailAuth(sessionName: "random")),
        ),
      );
    } else {}
  }

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
                key: _emailverifyformKey,
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
                                  "Email Verification",
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
                                    controller: _email,
                                    keyboardType: TextInputType.emailAddress,
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
                                child: Text("Send OTP",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                onPressed: () {
                                  if (_emailverifyformKey.currentState!
                                      .validate()) {
                                    setState(() {
                                      isApiCallProcess = true;
                                    });

                                    EmailVerifyModel model = EmailVerifyModel(
                                      email: _email.text,
                                    );

                                    APIService.emailVerify(model)
                                        .then((response) {
                                      if (response) {
                                        sendOtp();
                                      } else {
                                        setState(() {
                                          isApiCallProcess = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Email Already Registered!!')),
                                        );
                                      }
                                    });

                                    // final firstname = widget.firstname;
                                    // final lastname = widget.lastname;
                                    // final password = widget.password;
                                    // final email = _email.text;

                                    // print(firstname);
                                    // print(lastname);
                                    // print(password);
                                    // print(email);

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (_) => EmailCode(
                                    //         firstname: firstname,
                                    //         lastname: lastname,
                                    //         password: password,
                                    //         email: email),
                                    //   ),
                                    // );
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
