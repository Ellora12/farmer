import 'package:farmer/page/previously_recommended.dart';
import 'package:farmer/page/recommend.dart';
import 'package:flutter/material.dart';

import '../widget/navigation_drawer_widget.dart';

class fertilizer extends StatefulWidget {
  @override
  State<fertilizer> createState() => _fertilizerState();
}

class _fertilizerState extends State<fertilizer> {
  @override
  String dropdownValue = 'food crops';
  String dropdownValu = 'Neutral';

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
                          'Soil Type  ',
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
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              //<-- SEE HERE
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              //<-- SEE HERE
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
                            });
                          },
                          items: <String>['Acidic', 'Neutral', 'Basic']
                              .map<DropdownMenuItem<String>>((String value) {
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
                SingleChildScrollView(
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          'Crop Type',
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
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              //<-- SEE HERE
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              //<-- SEE HERE
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          dropdownColor: Colors.white,
                          value: dropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>[
                            'food crops',
                            'feed crops',
                            'fiber crops',
                            'oil crops',
                            'ornamental crops',
                            'industrial crops'
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
                Container(
                  margin: EdgeInsetsDirectional.only(start: 80),
                  height: 60,
                  width: 230,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => recommend()),
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.black12))),
                      overlayColor: MaterialStateProperty.resolveWith(
                        (states) {
                          return states.contains(MaterialState.pressed)
                              ? Colors.greenAccent
                              : null;
                        },
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
