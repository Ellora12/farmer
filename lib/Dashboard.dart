import 'package:farmer/widget/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'landingpage.dart';
import 'page/addcrop.dart';
import 'page/fertilizer.dart';
import 'page/irrselect.dart';
import 'page/location.dart';
import 'page/weather.dart';

void main() => runApp(MaterialApp(home: Gd()));

class Gd extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Gd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFBFDFB2),
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Service list'),
        centerTitle: true,
        backgroundColor: Color(0xff1fd655),
      ),
      body: Container(
        color: Colors.white60,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Abrar045",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Home",
                          style: TextStyle(
                              color: Color(0xffa29aac),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    alignment: Alignment.topCenter,
                    icon: Image.asset(
                      "assests/notification.png",
                      width: 24,
                    ),
                    onPressed: () {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.info,
                        text:
                            'Pump is on\n\n MOISTURE LEVEL\n Field 1 :25.6 \n Field 2 :25.6 \n Field 3 :25.6',
                      );
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GridDashboard()
          ],
        ),
      ),
    );
  }
}

class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
      title: "Weather Forcast", event: "", img: "assests/wt.jpg", x: 0);

  Items item2 = new Items(
      title: "Fertilizer Recommendation",
      event: "",
      img: "assests/fartilizer.png",
      x: 1);
  Items item3 = new Items(
      title: "Agriculture Office",
      event: "",
      img: "assests/location.png",
      x: 2);
  Items item4 = new Items(
      title: "Irrigation Control", event: "", img: "assests/irrigc.png", x: 3);
  Items item5 = new Items(
      title: "Irrigation History",
      event: "4 Items",
      img: "assests/irrigh.png",
      x: 4);
  Items item6 = new Items(
      title: "Logout", event: "2 Items", img: "assests/logout.png", x: 5);

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xff453658;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return InkWell(
              onTap: () {
                selectedItem(context, data.x);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.teal[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 42,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        data.title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  int x;
  String event;
  String img;

  Items(
      {required this.title,
      required this.event,
      required this.img,
      required this.x});
}

void selectedItem(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => weather(),
      ));
      break;
    case 1:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => fertilizer(),
      ));
      break;
    case 2:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CustomMarkerInfoWindowScreen(),
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
