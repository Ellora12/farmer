import 'package:farmer/Login.dart';
import 'package:farmer/utils/utils.dart';
import 'package:farmer/widget/button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'Dashboard.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<Signup> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final fullnameController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref("Users/Profile");

  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    fullnameController.dispose();
  }

  void signUp() {
    var name = fullnameController.text.toString();
    var phn_no = phoneController.text.toString();
    var em = emailController.text.toString();
    var pass = passwordController.text.toString();

    setState(() {
      loading = true;
    });

    try {
      _auth
          .createUserWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passwordController.text.toString())
          .then((value) {
        databaseRef.child(phn_no).set(
            {'name': name, 'email': em, 'password': pass, 'PhoneNo': phn_no});
        setState(() {
          loading = false;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) => Gd()));
      }).catchError((error) {
        Utils().toastMessage(error.toString());
        setState(() {
          loading = false;
        });
      });
    } catch (error) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) => initWidget();

  Widget initWidget() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
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
                margin: EdgeInsets.only(top: 50),
                child: Image.asset(
                  "assests/app_logo.png",
                  height: 150,
                  width: 150,
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20, top: 20),
                alignment: Alignment.bottomRight,
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ],
          )),
        ),
        Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 70, //54
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
                    keyboardType: TextInputType.text,
                    controller: fullnameController,
                    decoration: const InputDecoration(
                        hintText: 'Full Name',
                        prefixIcon: Icon(Icons.alternate_email)),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                        return 'Enter your Name';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 70, //54
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
                      if (value!.isEmpty ||
                          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                              .hasMatch(value!)) {
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
                  height: 70, //54
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xffEEEEEE),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 20),
                          blurRadius: 100,
                          color: Color(0xffEEEEEE)),
                    ],
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: phoneController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: 'PhoneNo',
                        prefixIcon: Icon(Icons.phone_callback)),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^(?:\+88|88)?(01[3-9]\d{8})$')
                              .hasMatch(value!)) {
                        return 'Enter your Phone Number';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 70, //54
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xffEEEEEE),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 20),
                          blurRadius: 100,
                          color: Color(0xffEEEEEE)),
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
              ],
            )),
        RoundButton(
          title: 'Signup',
          loading: loading,
          onTap: () {
            if (_formKey.currentState!.validate()) {
              signUp();
            }
          },
        ),
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Have Already Member?  "),
              GestureDetector(
                child: Text(
                  "Login Now",
                  style: TextStyle(color: Color(0xffF5591F)),
                ),
                onTap: () {
                  // Write Tap Code Here.
                  Navigator.pop(context);
                },
              )
            ],
          ),
        )
      ],
    )));
  }
}
