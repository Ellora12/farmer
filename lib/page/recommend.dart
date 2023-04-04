import 'package:farmer/page/saved.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/material.dart';

import '../widget/navigation_drawer_widget.dart';

class recommend extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fertilizer Recommendation',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Necessary Information of the pesticides'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          backgroundColor: Colors.green),
      body: SingleChildScrollView(
        child: Container(
          height: 1000,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [(new Color(0xffffffff)), new Color(0xff00f25f)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              SizedBox.square(
                dimension: 10,
              ),
              Center(
                  child: Container(
                height: 220,
                width: 340,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                      opacity: 0.9,
                      image: NetworkImage(
                          "https://cdn.britannica.com/18/139418-050-03B7A1F4/Larvae-potato-beetle-feeding-leaves-Colorado.jpg"),
                      fit: BoxFit.cover),
                ),
              )),
              Divider(
                color: Colors.white10,
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: buildTextField("Type", "Harmful", 1),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: buildTextField(
                    "Suggestion",
                    "pest name is BRITANICA. \n\n1.Collect the plant you want to use, let it dry, and grind the dried plant to a powder"
                        "\n\n2.Soak the powder in water overnight (1 handful of powder to 1 liter of water)."
                        "\n\n3.Pour the mixture through a screen or cloth to remove solids. "
                        "\n\n4.Add a little bit of mild soap to help the pesticide stick to plants."
                        "\n\n5.Spray or sprinkle the mixture on plants.Test your mixture on 1 or 2 plants first. If it seems to hurt the plants, it may be too strong."
                        " Add more water and test it until it seems good."
                        "\n\n6.Repeat as needed, and after it rains",
                    20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildTextField(String labelText, String placeholder, int n) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: TextFormField(
      maxLines: n,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          )),
    ),
  );
}
