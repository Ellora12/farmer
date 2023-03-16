import 'package:farmer/Login.dart';
import 'package:farmer/Signup.dart';
import 'package:flutter/material.dart';
import 'package:farmer/firebase_services/splash_screen.dart';

import 'Dashboard.dart';

void main() => runApp(MaterialApp(
      home: landingpage(),
    ));

class landingpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Container(
          height: 300,
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
                height: 150,
                width: 150,
                margin: EdgeInsets.only(top: 50),
                child: Image.asset("assests/app_logo.png"),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "WELCOME ",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
              )
            ],
          )),
        ),
        GestureDetector(
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SplashScreen(),
                  ));
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 20, right: 20, top: 70),
              padding: EdgeInsets.only(left: 20, right: 20),
              height: 65,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [(new Color(0xff1fd655)), new Color(0xffF2861E)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              child: Text(
                "LOGIN",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        GestureDetector(
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Signup(),
                  ));
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 45),
              padding: EdgeInsets.only(left: 20, right: 20),
              height: 65,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [(new Color(0xff1fd655)), new Color(0xffF2861E)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              child: Text(
                "SIGNUP",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    )));
  }
}
