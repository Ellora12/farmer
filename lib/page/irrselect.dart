import 'package:farmer/Login.dart';
import 'package:farmer/page/irrigationc.dart';
import 'package:flutter/material.dart';

import '../widget/navigation_drawer_widget.dart';
import 'irrigationh.dart';

void main() => runApp(MaterialApp(
      home: irrselect(),
    ));

class irrselect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text(
          ' See Irrigation History ',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff1fd655),
        elevation: 0.0,
      ),
      body: Container(
        height: 700,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [(new Color(0xffffffff)), new Color(0xff00f25f)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                            opacity: 0.9,
                            image: AssetImage('assests/ff1.png'),
                            fit: BoxFit.cover),
                      ),
                    )
                  ],
                ),
                Divider(
                  color: Colors.white10,
                  height: 16.0,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => irrigationh()),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 40),
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                      opacity: 0.9,
                                      image: AssetImage('assests/crop.png'),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 40, top: 10),
                              child: Text(
                                "  Field 1",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 20),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => irrigationh()),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 30),
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                      opacity: 0.9,
                                      image: AssetImage('assests/crop.png'),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 40, top: 10),
                              child: Text(
                                "  Field 2",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox.square(
                      dimension: 20,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            InkWell(
                              child: Container(
                                margin: EdgeInsets.only(left: 40),
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                      opacity: 0.9,
                                      image: AssetImage('assests/crop.png'),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => irrigationh()),
                                );
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 40, top: 10),
                              child: Text(
                                "Field 3",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Colors.white60,
                  height: 16.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
