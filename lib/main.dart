import 'package:farmer/Login.dart';
import 'package:farmer/landingpage.dart';
import 'package:farmer/page/fertilizer.dart';
import 'package:farmer/page/fieldadd.dart';
import 'package:farmer/page/addcrop.dart';
import 'package:farmer/page/irrigationc.dart';
import 'package:farmer/page/irrigationh.dart';
import 'package:farmer/page/irrselect.dart';
import 'package:farmer/page/previously_recommended.dart';
import 'package:farmer/page/recommend.dart';
import 'package:farmer/page/saved.dart';
import 'package:farmer/page/saved2.dart';
import 'package:flutter/material.dart';
import 'package:farmer/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Dashboard.dart';
import 'Signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(initialRoute: '/', routes: {
    '/': (context) => landingpage(),
  }));
}
