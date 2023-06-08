import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../constants.dart' as globals;
import 'addcrop.dart';
class saved2 extends StatelessWidget {
  final String data;

  saved2({required this.data});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: info(data: data),
    );
  }
}

class info extends StatefulWidget {
  final String data; // Declare 'data' variable in 'info' class

  info({required this.data}); // Pass 'data' variable to the constructor
  @override
  _EditProfilePageState createState() => _EditProfilePageState(fieldNo:data);
}

class _EditProfilePageState extends State<info> {

  TextEditingController f1 = TextEditingController();
  TextEditingController f2 = TextEditingController();
  TextEditingController f3= TextEditingController();


  String ec = globals.my;
  String plantname = "";
  String soil = "";
  String fieldNo;
  _EditProfilePageState({required this.fieldNo});



  @override
  void initState()
  {
    super.initState();
    fetchfield();
  }

  void fetchfield() {
    final databaseRef = FirebaseDatabase.instance.ref('fieldwater');
    DatabaseReference nodeRef =
    databaseRef.child("$ec/$fieldNo/fieldName");
    nodeRef.onValue.listen((event) {
      Map<dynamic, dynamic>? values =
      event.snapshot.value as Map<dynamic, dynamic>?;
      if (values != null) {
        // Access the specific values you need
        f1.text=fieldNo;
        f2.text = values['plant'] ?? '';
        f3.text = values['soil'] ?? '';

        // Add the values to the data list

      }
    }).onError((error) {
      print('Failed to fetch data: $error');
    });
  }

  Future<void> savefield(
      String fieldNo, String cropName, String soilType) async {
    try {

      // Save the data to the document
      final databaseRef = FirebaseDatabase.instance.ref('fieldwater');
      databaseRef.child("$ec/$fieldNo/fieldName").set({
        'fieldNo': fieldNo,
        'plant': cropName,
        'soil': soilType,
      });


    } catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 1,
        title: Text(
          ' View Info',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [(new Color(0xffffffff)), new Color(0xff00f25f)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              // Center(
              //   child: Text(
              //     "View Info",
              //     style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              //   ),
              // ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField("Field No", fieldNo,f1),
              buildTextField("Crop Name", plantname,f2),
              buildTextField("Soil Type", soil,f3),
              SizedBox(
                height: 35,
              ),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await savefield(f1.text, f2.text, f3.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => addcrop()),
                    );
                  },
                  icon: Icon(Icons.edit),
                  label: Text("Save"),
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String value,TextEditingController controller) {


    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: controller,
        onChanged: (newValue) {
          value = newValue;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

}
