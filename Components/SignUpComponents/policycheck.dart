import 'package:flutter/material.dart';
import 'package:icall/Model/register_user_model.dart';

import 'package:icall/login.dart';
import 'package:icall/services/api_service.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  // shape: RoundedRectangleBorder(
  //   borderRadius: BorderRadius.circular(10),
  // ),
  primary: Colors.white,
  // backgroundColor: Colors.blueAccent.shade200,
);

class PolicyCheck extends StatefulWidget {
  final String name;
  final String password;
  final String cnic;
  final String email;
  final String phone;
  const PolicyCheck(
      {Key? key,
      required this.name,
      required this.password,
      required this.cnic,
      required this.email,
      required this.phone})
      : super(key: key);

  @override
  State<PolicyCheck> createState() => _PolicyCheckState();
}

class _PolicyCheckState extends State<PolicyCheck> {
  bool isChecked = false;
  bool isApiCallProcess = false;
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.grey;
  }

  final _policycheckformkey = GlobalKey<FormState>();

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
                key: _policycheckformkey,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 100,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            child: Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  "Policy Agreement",
                                  style: TextStyle(
                                      color: Colors.blueAccent.shade400,
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
                            width: MediaQuery.of(context).size.width,
                            height: 400,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                    child: SingleChildScrollView(
                                  child: Text(
                                    "At icall, accessible from www.icall.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by icall and how we use it. If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us. This Privacy Policy applies only to our online activities and is valid for visitors to our website with regards to the information that they shared and/or collect in icall. This policy is not applicable to any information collected offline or via channels other than this website. Our Privacy Policy was created with the help of the Free Privacy Policy Generator. Consent By using our website, you hereby consent to our Privacy Policy and agree to its terms. Information we collect the personal information that you are asked to provide, and the reasons why you are asked to provide it, will be made clear to you at the point we ask you to provide your personal information. If you contact us directly, we may receive additional information about you such as your name, email address, phone number, the contents of the message and/or attachments you may send us, and any other information you may choose to provide. When you register for an Account, we may ask for your contact information, including items such as name, company name, address, email address, and telephone number . At icall, accessible from www.icall.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by icall and how we use it. If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us. This Privacy Policy applies only to our online activities and is valid for visitors to our website with regards to the information that they shared and/or collect in icall. This policy is not applicable to any information collected offline or via channels other than this website. Our Privacy Policy was created with the help of the Free Privacy Policy Generator. Consent By using our website, you hereby consent to our Privacy Policy and agree to its terms. Information we collect the personal information that you are asked to provide, and the reasons why you are asked to provide it, will be made clear to you at the point we ask you to provide your personal information. If you contact us directly, we may receive additional information about you such as your name, email address, phone number, the contents of the message and/or attachments you may send us, and any other information you may choose to provide. When you register for an Account, we may ask for your contact information, including items such as name, company name, address, email address, and telephone number",
                                  ),
                                ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                fillColor:
                                    MaterialStateProperty.resolveWith(getColor),
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                              ),
                              Text("Please Agree With Policies")
                            ],
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
                                  if (_policycheckformkey.currentState!
                                      .validate()) {
                                    final name = widget.name;

                                    final password = widget.password;
                                    final email = widget.email;
                                    final cnic = widget.cnic;
                                    final phone = widget.phone;

                                    RegisterUserModel model = RegisterUserModel(
                                        name: name,
                                        email: email,
                                        cnic: cnic,
                                        phone: phone,
                                        password: password);

                                    print(name);
                                    print(password);
                                    print(email);
                                    print(cnic);
                                    print(phone);
                                    if (isChecked == true) {
                                      setState(() {
                                        isApiCallProcess = true;
                                      });
                                      APIService.registerUser(model)
                                          .then((response) {
                                        setState(() {
                                          isApiCallProcess = false;
                                        });
                                        if (response) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'User Registered Successfully!! Please Login..')),
                                          );
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => Login(),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Error While Registering User!!')),
                                          );
                                        }
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Please Agree With Terms And Condition')),
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
          ),
        ));
  }
}
