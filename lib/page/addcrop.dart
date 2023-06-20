import 'package:farmer/Login.dart';
import 'package:farmer/page/irrigationc.dart';
import 'package:farmer/page/saved2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../widget/navigation_drawer_widget.dart';

void main() => runApp(MaterialApp(
  home: addcrop(),
));

Future<Map<String, bool>> checkNodesExist(List<String> nodePaths) async {
  DatabaseReference reference = FirebaseDatabase.instance.ref();
  Map<String, bool> nodeExistence = {};

  for (String path in nodePaths) {
    DataSnapshot snapshot = await reference.child(path).once() as DataSnapshot;
    nodeExistence[path] = snapshot.value != null;
  }

  return nodeExistence;
}

class addcrop extends StatefulWidget {
  const addcrop({Key? key}) : super(key: key);

  @override
  State<addcrop> createState() => _addcropState();
}

class _addcropState extends State<addcrop> {
  Map<String, bool> nodeExistence = {};

  @override
  void initState() {
    super.initState();
    fetchuser();
    List<String> nodePaths = [
      'fieldwater/sayedulabrar14045/field1/fieldName',
      'fieldwater/sayedulabrar14045/field2/fieldName'
    ];
    checkNodesExist(nodePaths).then((Map<String, bool> existence) {
      setState(() {
        nodeExistence = existence;
      });
    });
  }

  void fetchuser(){

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      backgroundColor: Colors.white60,
      appBar: AppBar(
        title: Text(
          ' Set Crop For The Field ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff1fd655),
        elevation: 0.0,
      ),
      body: Container(
        height: 800,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffffffff), Color(0xff00f25f)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 100.0), // Add spacing from the top
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
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 70.0), // Add spacing between the image and the next widget
              Column(
                children: [
                  Row(
                    children: [
                      _buildFieldItem(
                        image: nodeExistence['fieldwater/sayedulabrar14045/field1/fieldName'] == true
                            ? 'assests/addcrop.png'
                            : 'assests/crop.png',
                        title: 'Field 1',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => saved2(data: "field1")),
                          );
                        },
                      ),
                      SizedBox(width: 50),
                      _buildFieldItem(
                        image: nodeExistence['fieldwater/sayedulabrar14045/field2/fieldName'] == true
                            ? 'assests/addcrop.png'
                            : 'assests/crop.png',
                        title: 'Field 2',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => saved2(data: "field2")),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0), // Add spacing after the fields
                ],
              ),
              SizedBox(height: 16.0), // Add spacing from the bottom
            ],
          ),
        ),
      ),
    );
  }

}

Widget _buildFieldItem({
  required String image,
  required String title,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 40),
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              opacity: 0.9,
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 40, top: 10),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
          ),
        ),
      ],
    ),
  );
}