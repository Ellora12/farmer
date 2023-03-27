import 'package:farmer/Login.dart';
import 'package:farmer/widget/button_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'utils/utils.dart';
import 'package:farmer/Dashboard.dart';
import 'package:flutter/services.dart';


class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<Signup> {
  bool loading = false;
  //My code Portion--Arnab
  // final _formkey =GlobalKey<FormState>();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final phoneController =TextEditingController();
  final fullnameController =TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {

    super.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    fullnameController.dispose();
  }




  void signup()
  {


      // My codeing Part-->Arnab
      var pass=passwordController.text.toString();
      var name=fullnameController.text.toString();
      var phn_no=phoneController.text.toString();
      var em=emailController.text.toString();

      if(phn_no.length ==11  && name != null && pass!=null && em!=null)
      {
        print("It is working2");
        setState(() {
          loading = true;
        });
        _auth.createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
            .then((value) {
          Utils().toastMessage(value.user!.email.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context) => Gd()));
          setState(() {
            loading = false;
          });
        }).onError((error, stackTrace) {
          debugPrint(error.toString());
          Utils().toastMessage(error.toString().substring(30,error.toString().length));
          setState(() {
            loading = false;
          });
        });

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            ));

      }


      else {
        print("It is working");

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Signup(),
            ));
      }

  }



  @override
  Widget build(BuildContext context) => initWidget();

  Widget initWidget() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
                    color: new Color(0xffF5591F),
                    gradient: LinearGradient(
                      colors: [(new Color(0xff1fd655)), new Color(0xff39e75f)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Image.asset(
                              "assests/app_logo.png",
                              height: 150,
                              width: 150,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 20, top: 20),
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "Register",
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          )
                        ],
                      )),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        height: 54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[200],
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 50,
                                color: Color(0xffEEEEEE)),
                          ],
                        ),
                        child: TextField(
                          cursorColor: Colors.purple,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Color(0xff98BB9EFF),
                            ),
                            hintText: "Full Name",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,

                          ),
                          controller: fullnameController,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        height: 54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[200],
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 50,
                                color: Color(0xffEEEEEE)),
                          ],
                        ),
                        child: TextField(
                          cursorColor: Colors.purple,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.email,
                              color: Color(0xff98BB9EFF),
                            ),
                            hintText: "Email",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          controller: emailController,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        height: 54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(0xffEEEEEE),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 20),
                                blurRadius: 100,
                                color: Color(0xffEEEEEE)),
                          ],
                        ),
                        child: TextField(
                          cursorColor: Colors.purple,
                          decoration: InputDecoration(
                            focusColor: Color(0xff98BB9EFF),
                            icon: Icon(
                              Icons.phone,
                              color: Color(0xff98BB9EFF),
                            ),
                            hintText: "Phone Number",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          controller: phoneController,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        height: 54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(0xffEEEEEE),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 20),
                                blurRadius: 100,
                                color: Color(0xffEEEEEE)),
                          ],
                        ),
                        child: TextField(
                          cursorColor: Colors.purple,
                          decoration: InputDecoration(
                            focusColor: Color(0xff98BB9EFF),
                            icon: Icon(
                              Icons.vpn_key,
                              color: Color(0xff98BB9EFF),
                            ),
                            hintText: "Enter Password",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          controller: passwordController,
                        ),
                      ),


                    ],
                  ),
                ),

                RoundButton(
                  title: 'Register',
                  loading: loading,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      signup();
                    }
                  },
                ),
                Containers(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Have Already Member?  "),
                      GestureDetector(
                        child: Text(
                          "Login Now",
                          style: TextStyle(color: Color(0xffF5591F)),
                        ),
                        onTap: () {
                          // Write Tap Code Here.
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
