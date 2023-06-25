import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../constants.dart' as globals;
import 'package:intl/intl.dart';

import 'recommend.dart';

class previously extends StatefulWidget {
  const previously({Key? key}) : super(key: key);

  @override
  State<previously> createState() => _previouslyState();
}

class _previouslyState extends State<previously> {
  String ec = globals.my;
  final databaseRef = FirebaseDatabase.instance.ref('Username/fertilizer');

  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() {
    DatabaseReference nodeRef = databaseRef.child(ec);
    nodeRef.onValue.listen((event) {
      data.clear();
      Map<dynamic, dynamic>? values =
      event.snapshot.value as Map<dynamic, dynamic>?;
      values?.forEach((key, value) {
        int millisecondsSinceEpoch = int.parse(key);
        DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
        String uni = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
        String N = value['Nitrogen'] ?? '';
        String K = value['Potassium'] ?? '';
        String P = value['Phosphorus'] ?? '';
        String A = value['Area'] ?? '';
        String ST = value['Crop Name'] ?? '';
        String DOP = value['DAP']?.toString() ?? '';
        String MOP = value['MOP']?.toString() ?? '';
        String Urea = value['Urea']?.toString() ?? '';

        data.add({
          'uni': uni,
          'nitrogen': N,
          'Potassium': K,
          'Phosphorus': P,
          'Area': A,
          'Soil Type': ST,
          'DOP': DOP,
          'MOP': MOP,
          'UREA': Urea
        });
      });
      data.sort((a, b) => b['uni'].compareTo(a['uni']));
      setState(() {}); // update the UI with the fetched data
    }, onError: (error) {
      print('Failed to fetch data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            elevation: 5,
            child: ListTile(
              contentPadding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              leading: Icon(Icons.grass, color: Colors.green),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data[index]['uni'] ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.brown[900],
                    ),
                  ),
                  Text(
                    "Area: " + (data[index]['Area'] ?? ''),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_florist, color: Colors.orange),
                      SizedBox(width: 5),
                      Text(
                        "N : P : K  VALUE " +
                            (data[index]['nitrogen'] ?? '') +
                            ":" +
                            (data[index]['Phosphorus'] ?? '') +
                            ":" +
                            (data[index]['Potassium'] ?? ''),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.emoji_nature, color: Colors.brown),
                              SizedBox(width: 5),
                              Text(
                                "DOP: " + (data[index]['DOP'] ?? ''),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.emoji_nature, color: Colors.brown),
                              SizedBox(width: 5),
                              Text(
                                "MOP: " + (data[index]['MOP'] ?? ''),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.emoji_nature, color: Colors.brown),
                              SizedBox(width: 5),
                              Text(
                                "UREA: " + (data[index]['UREA'] ?? ''),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}