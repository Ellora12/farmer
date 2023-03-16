import 'dart:io';

import 'package:farmer/Dashboard.dart';
import 'package:farmer/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'Forgotten.dart';
import 'Signup.dart';
import 'utils/utils.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<Login> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString())
        .then((value) {
      Utils().toastMessage(value.user!.email.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context) => Gd()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  initWidget() {
    return WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
            body: SingleChildScrollView(
                child: Column(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(90)),
                color: new Color(0xffF5591F),
                gradient: LinearGradient(
                  colors: [(new Color(0xff1fd655)), new Color(0xff39e75f)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    margin: EdgeInsets.only(top: 50),
                    child: Image.asset("assests/app_logo.png"),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20, top: 20),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              )),
            ),
            Form(
                key: _formKey,
                child: Column(children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE)),
                      ],
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.alternate_email)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xff98BB9EFF),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 20),
                          blurRadius: 100,
                          color: Color(0xff98BB9EFF),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock_open)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                    ),
                  ),
                ])),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            //   alignment: Alignment.centerRight,
            //   child: GestureDetector(
            //     onTap: () {
            //       // Write Click Listener Code Here
            //       showModalBottomSheet(
            //         context: context,
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(30)),
            //         builder: (context) => Container(
            //           padding: const EdgeInsets.all(30),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(50),
            //             gradient: LinearGradient(
            //               colors: [
            //                 (new Color(0xffffffff)),
            //                 new Color(0xff00f25f)
            //               ],
            //               begin: Alignment.topCenter,
            //               end: Alignment.bottomCenter,
            //             ),
            //           ),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 "An Email has been sent to your NOKIA W60 mobile.Please Confirm",
            //                 style: TextStyle(
            //                   fontSize: 15,
            //                 ),
            //               ),
            //               SizedBox.square(
            //                 dimension: 15,
            //               ),
            //               Text(
            //                 "Please Confirm",
            //                 style: TextStyle(
            //                     fontSize: 40, fontWeight: FontWeight.w500),
            //               ),
            //               SizedBox.square(dimension: 50),
            //               Container(
            //                 padding: EdgeInsets.all(15),
            //                 decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(30),
            //                   color: Colors.grey.shade200,
            //                 ),
            //                 child: InkWell(
            //                   onTap: () {
            //                     Navigator.push(
            //                         context,
            //                         MaterialPageRoute(
            //                           builder: (context) => forgotten(),
            //                         ));
            //                   },
            //                   child: Container(
            //                     child: Row(
            //                       children: [
            //                         Icon(Icons.check_circle_outline_rounded,
            //                             size: 60,
            //                             color: Colors.lightGreenAccent),
            //                         SizedBox.square(
            //                           dimension: 10,
            //                         ),
            //                         Text(
            //                           "Email has been confirmed",
            //                           style: TextStyle(
            //                               fontSize: 20,
            //                               fontWeight: FontWeight.w900),
            //                         )
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),
            //       );
            //     },
            //     child: Text("Forget Password?"),
            //   ),
            // ),
            RoundButton(
              title: 'Login',
              loading: loading,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  login();
                }
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't Have Any Account?  "),
                  GestureDetector(
                    child: Text(
                      "Register Now",
                      style: TextStyle(color: Color(0xffF5591F)),
                    ),
                    onTap: () {
                      // Write Tap Code Here.
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Signup(),
                          ));
                    },
                  )
                ],
              ),
            )
          ],
        ))));
  }
}
