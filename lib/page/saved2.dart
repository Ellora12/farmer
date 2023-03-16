import 'package:farmer/page/irrigationc.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: saved2(),
    ));

class saved2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: info(),
    );
  }
}

class info extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<info> {
  bool showPassword = false;
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
              buildTextField("Field No", "1", false),
              buildTextField("Field Area", "78.88 meter square", false),
              buildTextField("Crop Name", "Guava", false),
              buildTextField("Soil Type", "Flood plain", false),
              SizedBox(
                height: 35,
              ),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => irrigationc()),
                    );
                  },
                  icon: Icon(Icons.edit),
                  label: Text("Edit"),
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

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
