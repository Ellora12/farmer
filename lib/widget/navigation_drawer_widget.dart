import 'package:farmer/landingpage.dart';
import 'package:farmer/page/addcrop.dart';
import 'package:farmer/page/fertilizer.dart';
import 'package:farmer/page/irrselect.dart';
import 'package:farmer/page/location.dart';
import 'package:farmer/page/weather.dart';
import 'package:farmer/page/weather2.dart';
import '../constants.dart' as globals;
import 'package:farmer/profile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:farmer/page/user_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
User? user = FirebaseAuth.instance.currentUser;
class NavigationDrawerWidget extends StatefulWidget {
  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final databaseRef2 = FirebaseDatabase.instance.ref('Users/Profile');
  String ec = globals.my;
  // Add the necessary variables for name and email
  String name = '';
  String email = '';
  String _imageUrl = " ";
  final padding = EdgeInsets.symmetric(horizontal: 20);


  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  String getImageUrl() {
    final dbRef = FirebaseDatabase.instance.ref().child("Username/name/$ec");
    dbRef.onValue.listen((event) => {
      event.snapshot.children.forEach((child) {
        if (child.key == "pro") {
          setState(() {
            _imageUrl = child.value.toString();
          });
        }
      })
    });
    return _imageUrl;
  }


  // Implement the fetchUsers method to fetch the name and email data
  void fetchUsers() {
    DatabaseReference nodeRef = databaseRef2.child(ec);

    nodeRef.onValue.listen((event) {
      Map<dynamic, dynamic>? values =
      event.snapshot.value as Map<dynamic, dynamic>?;
      if (values != null) {
        // Access the specific values you need
        setState(() {
          email = values['email'].toString() ?? '';
          name = values['name'].toString() ?? '';
        });
      }
    }).onError((error) {
      print('Failed to fetch data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {

    final urlImage =
        getImageUrl();

    return Drawer(
      child: Material(
        color: Colors.green,
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Profile(),
              )),
            ),
            Container(

              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Weather Forcast',
                    icon: Icons.cloud_circle,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Fertilizer Recommendation',
                    icon: Icons.recommend,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Office location',
                    icon: Icons.workspaces_outline,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Irrigation Control',
                    icon: Icons.settings_input_antenna,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Irrigation History',
                    icon: Icons.history,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Logout',
                    icon: Icons.logout,
                    onClicked: () => selectedItem(context, 5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        splashColor: Colors.black26,
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40,horizontal: -10)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => weather2(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => fertilizer(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MapSample(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => addcrop(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => irrselect(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => landingpage(),
        ));
        break;
    }
  }
}

