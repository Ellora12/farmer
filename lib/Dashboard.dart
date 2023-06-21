import 'dart:async';
import 'dart:io';

import 'package:farmer/Login.dart';
import 'package:farmer/page/fertilizer.dart';
import 'package:farmer/widget/navigation_drawer_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import '../constants.dart' as globals;
import 'landingpage.dart';
import 'page/addcrop.dart';

import 'page/irrselect.dart';
import 'page/location.dart';
import 'page/weather2.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

// User? user = FirebaseAuth.instance.currentUser;
// DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
// Query query = databaseRef.child('Users/Profile').orderByChild('name');


void main() => runApp(MaterialApp(home: Gd()));

class Gd extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Gd> {
  String ec = globals.my;
  final databaseRef = FirebaseDatabase.instance.ref('fieldwater');
  final databaseRef2 = FirebaseDatabase.instance.ref('Users/Profile');
  String Email="";
  String Name="";
  String pumpValue = '';
  String sensor1Value = '';
  String pumpValue2 = '';
  String sensor2Value = '';

  String dataString = '';
  bool showAlert = false;
  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() {
    DatabaseReference nodeRef = databaseRef2.child(ec);

    nodeRef.onValue.listen((event) {
      Map<dynamic, dynamic>? values =
      event.snapshot.value as Map<dynamic, dynamic>?;
      if (values != null) {
        // Access the specific values you need
        setState(() {
          Email = values['email'].toString() ?? '';
          Name = values['name'].toString() ?? '';
        });





      }
    }).onError((error) {
      print('Failed to fetch data: $error');

    });

  }


  void checkCompletion() {
    DatabaseReference nodeRef = databaseRef.child('$ec/field1/fieldinfo');
    DatabaseReference nodeRef2 = databaseRef.child('$ec/field2/fieldinfo');
    nodeRef.onValue.listen((event) {
      Map<dynamic, dynamic>? values =
      event.snapshot.value as Map<dynamic, dynamic>?;
      if (values != null) {
        // Access the specific values you need
        setState(() {
          pumpValue = values['pump'].toString() ?? '';
          sensor1Value = values['sensor1'].toString() ?? '';
        });
      }
    });

    nodeRef2.onValue.listen((event) {
      Map<dynamic, dynamic>? values2 =
      event.snapshot.value as Map<dynamic, dynamic>?;
      if (values2 != null) {
        // Access the specific values you need
        setState(() {
          pumpValue2 = values2['pump'].toString() ?? '';
          sensor2Value = values2['sensor2'].toString() ?? '';
        });
      }
    });
  }


  void info() {

        // Both listeners have completed fetching data
        String dataString =
            'Pump: $pumpValue\n\nSensor1: $sensor1Value\n\nPump: $pumpValue2\n\nSensor2: $sensor2Value\n\n';


        if (showAlert) {

          QuickAlert.show(
            type: QuickAlertType.info,
            title: 'Firebase Data',
            text: dataString,
            context: context,
            onConfirmBtnTap: () {
              checkCompletion();
              Future.delayed(Duration(seconds: 0), () {
                Navigator.pop(context);
                setState(() {
                  showAlert = false; // Dismiss the QuickAlert when the user clicks "Okay"
                });
              });
            },
          );

        }





  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFBFDFB2),
       drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Service list'),
        centerTitle: true,
        backgroundColor: Color(0xff1fd655),
      ),
      body: Container(
        color: Colors.white60,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          Name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Home",
                          style: TextStyle(
                              color: Color(0xffa29aac),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),

                  IconButton(
                    alignment: Alignment.topCenter,
                    icon: Image.asset(
                      "assests/notification.png",
                      width: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        showAlert = true;
                      });
                      info();
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GridDashboard()
          ],
        ),
      ),
    );
  }
}

class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
      title: "Weather Forcast", event: "", img: "assests/wt.jpg", x: 0);

  Items item2 = new Items(
      title: "Fertilizer Recommendation",
      event: "",
      img: "assests/fartilizer.png",
      x: 1);
  Items item3 = new Items(
      title: "Area Calc From GoogleMap",
      event: "",
      img: "assests/location.png",
      x: 2);
  Items item4 = new Items(
      title: "Irrigation Info", event: "", img: "assests/irrigc.png", x: 3);
  Items item5 = new Items(
      title: "Irrigation History",
      event: "4 Items",
      img: "assests/irrigh.png",
      x: 4);
  Items item6 = new Items(
      title: "Logout", event: "2 Items", img: "assests/logout.png", x: 5);

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];

    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return InkWell(
              onTap: () {
                selectedItem(context, data.x);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.teal[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 42,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        data.title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  int x;
  String event;
  String img;

  Items(
      {required this.title,
        required this.event,
        required this.img,
        required this.x});
}

void selectedItem(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => weather2(),
      ));
      break;
    case 1:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => fertilizer(),
      ));
      break;
    case 2:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MapSample(),
      ));
      break;
    case 3:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => addcrop(),
      ));
      break;
    case 4:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => irrselect(),
      ));
      break;
    case 5:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Login(),
      ));
      break;
  }
}