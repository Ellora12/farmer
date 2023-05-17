import 'package:farmer/Dashboard.dart';
import 'package:farmer/page/previously_recommended.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:farmer/page/recommend.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../constants.dart' as globals;
import '../utils/utils.dart';
import '../widget/button_widget.dart';
import '../widget/navigation_drawer_widget.dart';

class fertilizer extends StatefulWidget {
  @override
  State<fertilizer> createState() => _fertilizerState();
}

class _fertilizerState extends State<fertilizer> {
  bool loading = false;
  final N = TextEditingController();
  final K = TextEditingController();
  final P = TextEditingController();
  final A = TextEditingController();
  TextEditingController _soilTypeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String ec = globals.my;
  final databaseRef = FirebaseDatabase.instance.ref('Username/fertilizer');
  String dropdownValu = 'Potato';

  @override
  void dispose() {
    _soilTypeController.dispose();
    N.dispose();
    K.dispose();
    P.dispose();
    A.dispose();

    super.dispose();
  }

  Future<void> frt() async {
    var nt = N.text.toString();
    var pt = K.text.toString();
    var ph = P.text.toString();
    var st = _soilTypeController.text.toString();
    var area = A.text.toString();
    double my1 = double.parse(nt);
    double my2 = double.parse(pt);
    double my3 = double.parse(ph);

    final dateTime = DateTime.now();

    final un = dateTime.millisecondsSinceEpoch.toString();

    setState(() {
      loading = true;
    });

    try {
      await databaseRef.child('$ec/$un').set({
        'Nitrogen': nt,
        'Potassium': pt,
        'Phosphorus': ph,
        'Crop Name': st,
        'Area': area,
      });
      print("Sent complete");

      final response = await http.post(
        Uri.parse('http://localhost:5000/predict'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'Crop_name': st,
          'N': my1,
          'P': my2,
          'K': my3,
        }),
      );

      if (response.statusCode == 200) {
        final output = json.decode(response.body);
        print('Predicted fertilizer recommendations:');
        print('DAP: ${output['DAP']}');
        print('Urea: ${output['Urea']}');
        print('MOP: ${output['MOP']}');
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
      return;
    }

    print(nt + "" + pt + "" + ph + "" + st + "" + area + " " + ec);
    setState(() {
      loading = false;
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => previously()));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        //drawer: NavigationDrawerWidget(),
        backgroundColor: Colors.greenAccent,
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Fertilizer Recommendation'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [(new Color(0xffffffff)), new Color(0xff00f25f)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                          opacity: 0.9,
                          image: AssetImage("assests/fartilizer.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Container(
                  color: Colors.black12,
                  child: Card(
                    color: Colors.white60,
                    elevation: 3,
                    child: ListTile(
                      title: Text(
                        "Previous Recommendations",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.blueGrey),
                      ),
                      subtitle: Text("last used 01/08/2022"),
                      trailing: Icon(Icons.label_important_outlined),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => previously()),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox.square(
                  dimension: 10,
                ),
                SingleChildScrollView(
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          'Nitrogen',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Container(
                        width: 200,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: TextField(
                          controller: N,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.teal[100],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox.square(
                  dimension: 5,
                ),
                SingleChildScrollView(
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          'Potassium  ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Container(
                        width: 200,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: TextField(
                          controller: K,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.teal[100],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox.square(
                  dimension: 5,
                ),
                SingleChildScrollView(
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          'Phosphorous',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Container(
                        width: 200,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: TextField(
                          controller: P,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.teal[100],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox.square(
                  dimension: 5,
                ),
                SingleChildScrollView(
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          'Crop Name  ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(width: 2),
                      Container(
                        width: 200,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          dropdownColor: Colors.white,
                          value: dropdownValu,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValu = newValue!;
                              _soilTypeController.text = dropdownValu;
                            });
                          },
                          items: <String>[
                            'Beans',
                            'Brinjal',
                            'Cabbage',
                            'Cauliflower',
                            'Green peas',
                            'Groundnut',
                            'Lentil',
                            'Lettuce',
                            'Linseed',
                            'Maize',
                            'Mango',
                            'Onion',
                            'Papaya',
                            'Potato',
                            'Sesame',
                            'Soybean',
                            'Spinach',
                            'Sunflower',
                            'Tomato',
                            'Wheat',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox.square(
                  dimension: 5,
                ),
                SizedBox.square(
                  dimension: 5,
                ),
                SingleChildScrollView(
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          'Field Area ',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 200,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: TextField(
                          controller: A,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.teal[100],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox.square(
                  dimension: 15,
                ),
                RoundButton(
                  title: 'Submit',
                  loading: loading,
                  onTap: () {
                    if (N.text.isNotEmpty &&
                        K.text.isNotEmpty &&
                        P.text.isNotEmpty &&
                        A.text.isNotEmpty &&
                        _soilTypeController.text.isNotEmpty) {
                      frt();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
