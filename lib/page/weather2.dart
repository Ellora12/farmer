import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import '../widget/navigation_drawer_widget.dart';
import 'dart:math' as math;
import 'package:farmer/page/rain.dart';
import 'package:jiffy/jiffy.dart';

var now = Jiffy();
String currentDate = (now.yMMMMd).toString();

String dayOfWeek = now.EEEE;


class weather2 extends StatefulWidget {
  @override
  _weatherState createState() => _weatherState();
}


class _weatherState extends State<weather2> {
  bool isLoading = true;
  List<Map<String, String>> hourlyForecastData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://www.timeanddate.com/weather/bangladesh/dhaka/hourly'));
    if (response.statusCode == 200) {
      final document = parser.parse(response.body);
      final table =
      document.getElementById('wt-hbh')?.getElementsByTagName('tbody')[0];
      final rows = table?.getElementsByTagName('tr');
      for (final row in rows!) {
        final columns = row.getElementsByTagName('td');
        final time = row.getElementsByTagName('th')[0].text.trim();

        final temperature = columns[1].text.trim();
        final wind = columns[4].text.trim();
        final humidity = columns[6].text.trim();
        final chance = columns[7].text.trim();
        final amount = columns[8].text.trim();

        final forecast = {
          'Time': time,
          'Temperature': temperature,
          'Wind': wind,
          'Humidity': humidity,
          'Chance': chance,
          'Amount': amount,
        };

        hourlyForecastData.add(forecast);
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingScreen()
        : NormalScreen(hourlyForecastData: hourlyForecastData);
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class NormalScreen extends StatefulWidget {
  List<Map<String, String>> hourlyForecastData;
  final Key parallaxOne = GlobalKey();
  bool showDate = true;

  NormalScreen({required this.hourlyForecastData});

  @override
  _NormalScreenState createState() => _NormalScreenState(hourlyForecastData: hourlyForecastData);
}

class _NormalScreenState extends State<NormalScreen> {
  List<Map<String, String>> hourlyForecastData;
  final Key parallaxOne = GlobalKey();
  bool showdate = true;

  _NormalScreenState({required this.hourlyForecastData});

  @override
  Widget build(BuildContext context) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;
    debugShowCheckedModeBanner:
    false;
    final first = hourlyForecastData[0];
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white54,
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          setState(() {
            showdate = false;
          });
          showModalBottomSheet(
              context: context,
              elevation: 0,
              barrierColor: Colors.black.withAlpha(1),
              backgroundColor: Colors.transparent,
              builder: (builder) {
                return Container(
                  height: 600.0,
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.0),
                              topRight: Radius.circular(50.0))),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: res_height * 0.04,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assests/clock.png',
                                  width: 25,
                                ),
                                SizedBox(
                                  width: res_width * 0.04,
                                ),
                                Text(
                                  "Today's changes",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: res_height * 0.04,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: hourlyForecastData.length,
                                  itemBuilder: (context, index) {
                                    final forecast = hourlyForecastData[index];

                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              child: Icon(Icons.access_time,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(width: 5),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text('Time',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                Text(
                                                    '${forecast['Time']?.substring(0, 5)}',
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                              ],
                                            ),
                                            SizedBox(width: 20),
                                            Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              child: Icon(Icons.thermostat,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(width: 5),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text('Temp',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                Text(
                                                    '${forecast['Temperature']}',
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                              ],
                                            ),
                                            SizedBox(width: 20),
                                            Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              child: Icon(Icons.waves,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(width: 5),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text('${forecast['Amount']}',
                                                    style: TextStyle(
                                                        fontSize: 14)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Divider(color: Colors.grey)
                                      ],
                                    );
                                  }),
                            )
                          ],
                        ),
                      )),
                );
              }).whenComplete(() {
            setState(() {
              showdate = true;
            });
          });
        },
        child: Container(
          //add ClipRRect widget for Round Corner
          color: Color(0xff763bd7),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(24),
              topLeft: Radius.circular(24),
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding:
                EdgeInsets.only(left: 13, right: 13, top: 13, bottom: 26),
                child: ListTile(
                  leading: SizedBox(
                      height: 30.0,
                      width: 30.0,
                      child: Image.asset('assests/clock.png')),
                  title: Text(
                    "Today's Changes",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  trailing: SizedBox(
                      height: 30.0,
                      width: 30.0,
                      child: Image.asset('assests/calendar.png')),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: res_height * 1,
        color: Color(0xff763bd7),
        child: Stack(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 600),
              height: showdate ? res_height * 0.125 : res_height * 0.100,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(50))),
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    SizedBox(
                        height: 35.0,
                        width: 33.0,
                        child: Image.asset('assests/sun.png')),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Weather',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: ClipRRect(
                borderRadius:
                BorderRadius.only(bottomLeft: Radius.circular(50)),
                child: Column(
                  children: [
                    AnimatedContainer(
                      width: 70,
                      height: showdate ? 110 : 0,
                      color: Color(0xfff7446f),
                      duration: Duration(milliseconds: 400),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Text(
                            currentDate.substring(0, currentDate.length - 4),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(dayOfWeek.substring(0,3),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                height: res_height * 1,
                child: ParallaxRain(
                  key: parallaxOne,
                  dropColors: [
                    Colors.white,
                  ],
                  trail: true,
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: res_height * 0.275,
              child: Image.asset(
                'assests/sun.png',
                height: res_height * 0.5,
              ),
            ),
            Positioned(
              left: 20,
              top: res_height * 0.175,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${first['Temperature']}',
                    style: TextStyle(fontSize: 50, color: Colors.white),
                  ),
                  // Text(
                  //   'Feels like 17°',
                  //   style: TextStyle(fontSize: 20, color: Colors.white),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Icon(
                    Icons.cloudy_snowing,
                    color: Colors.white,
                    size: 40,
                  )
                ],
              ),
            ),
            Positioned(
              bottom: res_height * 0.02,
              left: 20,
              child: Text(
                'Dhaka',
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}