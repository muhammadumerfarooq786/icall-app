// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:icall/Components/SignUpComponents/policycheck.dart';

// class PhoneVerify extends StatefulWidget {
//   final String firstname;
//   final String lastname;
//   final String password;
//   final String cnic;
//   final String email;
//   const PhoneVerify({
//     Key? key,
//     required this.firstname,
//     required this.lastname,
//     required this.password,
//     required this.cnic,
//     required this.email,
//   }) : super(key: key);

//   @override
//   _PhoneVerifyState createState() => _PhoneVerifyState();
// }

// class _PhoneVerifyState extends State<PhoneVerify> {
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController otpController = TextEditingController();

//   FirebaseAuth auth = FirebaseAuth.instance;

//   bool otpVisibility = false;

//   String verificationID = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Phone Auth",
//           style: TextStyle(
//             fontSize: 30,
//           ),
//         ),
//         backgroundColor: Colors.indigo[900],
//       ),
//       body: Container(
//         margin: EdgeInsets.all(10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: phoneController,
//               decoration: InputDecoration(
//                 hintText: 'Phone Number',
//                 prefix: Padding(
//                   padding: EdgeInsets.all(4),
//                   child: Text('+92'),
//                 ),
//               ),
//               maxLength: 10,
//               keyboardType: TextInputType.phone,
//             ),
//             Visibility(
//               child: TextField(
//                 controller: otpController,
//                 decoration: InputDecoration(
//                   hintText: 'OTP',
//                   prefix: Padding(
//                     padding: EdgeInsets.all(4),
//                     child: Text(''),
//                   ),
//                 ),
//                 maxLength: 6,
//                 keyboardType: TextInputType.number,
//               ),
//               visible: otpVisibility,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             MaterialButton(
//               color: Colors.indigo[900],
//               onPressed: () {
//                 if (otpVisibility) {
//                   verifyOTP();
//                 } else {
//                   loginWithPhone();
//                 }
//               },
//               child: Text(
//                 otpVisibility ? "Verify" : "Login",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void loginWithPhone() async {
//     auth.verifyPhoneNumber(
//       phoneNumber: "+92" + phoneController.text,
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await auth.signInWithCredential(credential).then((value) {
//           print("You are logged in successfully");
//         });
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         print(e.message);
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         otpVisibility = true;
//         verificationID = verificationId;
//         setState(() {});
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }

//   void verifyOTP() async {
//     PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationID, smsCode: otpController.text);

//     await auth.signInWithCredential(credential).then(
//       (value) {
//         print("You are logged in successfully");
//         Fluttertoast.showToast(
//           msg: "You are logged in successfully",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0,
//         );
//       },
//     ).whenComplete(
//       () {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PolicyCheck(
//                 firstname: widget.firstname,
//                 lastname: widget.lastname,
//                 password: widget.password,
//                 cnic: widget.cnic,
//                 email: widget.email,
//                 phone: "0" + phoneController.text),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:icall/Components/SignUpComponents/policycheck.dart';

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  // shape: RoundedRectangleBorder(
  //   borderRadius: BorderRadius.circular(10),
  // ),
  primary: Colors.white,
  // backgroundColor: Colors.blueAccent.shade200,
);

class PhoneVerify extends StatefulWidget {
  final String name;
  final String password;
  final String cnic;
  final String email;
  const PhoneVerify({
    Key? key,
    required this.name,
    required this.password,
    required this.cnic,
    required this.email,
  }) : super(key: key);

  @override
  State<PhoneVerify> createState() => _PhoneVerifyState();
}

class _PhoneVerifyState extends State<PhoneVerify> {
  final _emailverifycodeformKey = GlobalKey<FormState>();
  TextEditingController _PhoneNumber = TextEditingController();

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
                                "Phone Number",
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
                                  controller: _PhoneNumber,
                                  validator: (value) {
                                    if (value == null || value.isEmpty)
                                      return "Please Enter the Verification Code";

                                    if (value.length != 11)
                                      return "Phone Number Must be of Length 11";

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Phone Number",
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
                                  if (_emailverifycodeformKey.currentState!
                                      .validate()) {
                                    final name = widget.name;

                                    final password = widget.password;
                                    final email = widget.email;
                                    final PhoneVerify = _PhoneNumber.text;

                                    // print(firstname);
                                    // print(lastname);
                                    // print(password);
                                    // print(email);
                                    // print(PhoneVerify);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => PolicyCheck(
                                            name: name,
                                            password: password,
                                            cnic: widget.cnic,
                                            email: email,
                                            phone: PhoneVerify),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Invalid Code. Please Try Again!!')),
                                    );
                                  }
                                }),
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
