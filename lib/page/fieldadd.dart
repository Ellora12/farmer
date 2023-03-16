import 'package:farmer/Login.dart';
import 'package:farmer/page/addcrop.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: fieldadd(),
    ));

class fieldadd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Field Info ',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff1fd655),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 50),
          height: 700,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [(new Color(0xffffffff)), new Color(0xff00f25f)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 250,
                    width: 340,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                          opacity: 0.9,
                          image: NetworkImage(
                              "https://media.istockphoto.com/id/1139693585/vector/cartoon-farmer-in-front-of-colorful-farm-with-barn.jpg?s=612x612&w=is&k=20&c=D8G7T8eCdLxRnyfcwbos06SXnlGXQqmF0yZSVRxRF1I="),
                          fit: BoxFit.cover),
                    ),
                  )
                ],
              ),
              Divider(
                color: Colors.white10,
                height: 26.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white54,
                    border: OutlineInputBorder(),
                    hintText: 'Field No',
                  ),
                ),
              ),
              Divider(
                color: Colors.white60,
                height: 20.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white54,
                    border: OutlineInputBorder(),
                    hintText: 'Field Area',
                  ),
                ),
              ),
              Divider(
                color: Colors.white60,
                height: 30.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white54,
                    border: OutlineInputBorder(),
                    hintText: 'Soil Type',
                  ),
                ),
              ),
              Divider(
                color: Colors.white60,
                height: 20.0,
              ),
              Center(
                  child: Container(
                height: 60,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => addcrop()),
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
                            ? Colors.red
                            : null;
                      },
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
