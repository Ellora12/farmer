import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:farmer/Login.dart';
import '../constants.dart' as globals;
import 'package:farmer/Dashboard.dart';
// import '../ui/firebase_firestore/fire_store_list.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      String? email = user.email;
      List<String>? emailParts = email?.split('@');
        globals.my = emailParts![0];


      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Gd())));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login())));
    }
  }
}
