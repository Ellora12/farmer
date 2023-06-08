import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import '../widget/navigation_drawer_widget.dart';

class weather extends StatefulWidget {
  @override
  _weatherState createState() => _weatherState();
}

class _weatherState extends State<weather> {
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

        final temperature = columns[2].text.trim();
        final wind = columns[3].text.trim();
        final humidity = columns[4].text.trim();
        final chance = columns[5].text.trim();
        final amount = columns[6].text.trim();

        final forecast = {
          'Time': time,
          'Temperature': temperature,
          'Wind': wind,
          'Humidity': humidity,
          'Chance': chance,
          'Amount': amount,
        };
        print({forecast['Amount']});
        hourlyForecastData.add(forecast);
      }

      setState(() {});
    }
  }

  @override

  Widget build(BuildContext context) {
    final firstForecast = hourlyForecastData.isNotEmpty ? hourlyForecastData[0] : null;
    final remainingForecasts = hourlyForecastData.length > 1 ? hourlyForecastData.sublist(1) : [];
    int height, width;
    height = 500 ;  width = 200;
    double _extractTemperature(String temperatureString) {
      final String numericValue = temperatureString.substring(temperatureString.length - 2);
      try {
        return double.parse(numericValue);
      } catch (e) {
        return 0.0; // Return a default value or handle the error according to your needs
      }
    }

    return Scaffold(
      backgroundColor: Colors.black12,
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Weather forecast hourly'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[200],
      ),
      body: Column(
        children: [
          if (firstForecast != null) ...[
            Padding(
              padding: EdgeInsets.only(top: height * 0.005),
              child: Align(
                child: Text(
                  'Today', //day
                  style: GoogleFonts.questrial(
                    color: Colors.black54,
                    fontSize: height * 0.035,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.03),
              child: Align(
                child: Text(
                  '${firstForecast['Temperature']}°C', //current temperature
                  style: GoogleFonts.questrial(
                    color: _extractTemperature(firstForecast['Temperature']!) <= 0
                        ? Colors.blue
                        : _extractTemperature(firstForecast['Temperature']!)  > 0 && double.parse(firstForecast['Temperature']!) <= 15
                        ? Colors.indigo
                        : _extractTemperature(firstForecast['Temperature']!) > 15 && double.parse(firstForecast['Temperature']!) < 30
                        ? Colors.deepPurple
                        : Colors.pink,
                    fontSize: height * 0.13,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.25),
              child: Divider(
                color: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.005),
              child: Align(
                child: Text(
                  'Sunny', // weather
                  style: GoogleFonts.questrial(
                    color: Colors.black54,
                    fontSize: height * 0.03,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.03, bottom: height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${firstForecast['TemperatureMin']}°C', // min temperature
                    style: GoogleFonts.questrial(
                      color: _extractTemperature(firstForecast['Temperature']!) <= 0
                          ? Colors.blue
                          : _extractTemperature(firstForecast['Temperature']!)  > 0 && double.parse(firstForecast['Temperature']!) <= 15
                          ? Colors.indigo
                          : _extractTemperature(firstForecast['Temperature']!) > 15 && double.parse(firstForecast['Temperature']!) < 30
                          ? Colors.deepPurple
                          : Colors.pink,
                      fontSize: height * 0.03,
                    ),
                  ),
                  Text(
                    '/',
                    style: GoogleFonts.questrial(
                      color: Colors.black54,
                      fontSize: height * 0.03,
                    ),
                  ),
                  Text(
                    '${firstForecast['TemperatureMax']}°C', //max temperature
                    style: GoogleFonts.questrial(
                      color: _extractTemperature(firstForecast['Temperature']!) <= 0
                          ? Colors.blue
                          : _extractTemperature(firstForecast['Temperature']!)  > 0 && double.parse(firstForecast['Temperature']!) <= 15
                          ? Colors.indigo
                          : _extractTemperature(firstForecast['Temperature']!) > 15 && double.parse(firstForecast['Temperature']!) < 30
                          ? Colors.deepPurple
                          : Colors.pink,
                      fontSize: height * 0.03,
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: remainingForecasts.length,
              itemBuilder: (context, index) {
                final forecast = remainingForecasts[index];
                final time = forecast['Time'];
                final isNight = _isNightTime(time!);

                return Container(
                  width: 200,
                  child: Card(
                    color: Colors.transparent,
                    elevation: 4,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: isNight
                              ? NetworkImage(
                            'https://thumbs.dreamstime.com/b/dark-cloudy-night-sky-stars-nebula-abstract-blue-background-155788446.jpg',
                          )
                              : NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr3fkcKZpcpgVnVvAtqLCyPbNLsXFUqXxaSA&usqp=CAU',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        title: Text(
                          'Time: ${forecast['Time']}',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Temperature',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${forecast['Temperature']}',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Wind',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${forecast['Wind']}',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Humidity',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${forecast['Humidity']}',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Chance',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.purple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${forecast['Chance']}',
                                      style

                                          : TextStyle(
                                        fontSize: 22,
                                        color: Colors.purple,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Amount',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.teal,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${forecast['Amount']}',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.teal,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  bool _isNightTime(String time) {
    final hour = int.tryParse(time.split(':')[0]) ?? 0;
    return hour < 6 || hour > 18;
  }
}





























//
// void main() {
//   runApp(MaterialApp(
//     title: 'Weather App',
//     home: MyWidget(),
//   ));
// }
//
// class MyWidget extends StatefulWidget {
//   @override
//   _MyWidgetState createState() => _MyWidgetState();
// }
//
// class _MyWidgetState extends State<MyWidget> {
//   String weatherData = '';
//   @override
//   void initState() {
//     super.initState();
//     fetchWebsiteData();
//   }
//
//   Future fetchWebsiteData() async {
//     final url = Uri.parse(
//         'https://www.accuweather.com/en/bd/dhaka/28143/hourly-weather-forecast/28143');
//     final response = await http.get(url);
//     dom.Document document = dom.Document.html(response.body);
//
//     final hourlyCard = document.querySelector('.hourly-card-nfl-header');
//
//     if (hourlyCard != null) {
//       final timeElement = hourlyCard.querySelector('.date span');
//       final temperatureElement = hourlyCard.querySelector('.temp');
//       final weatherElement = hourlyCard.querySelector('.real-feel__text');
//
//       final time = timeElement?.text ?? '';
//       final temperature = temperatureElement?.text ?? '';
//       final weather = weatherElement?.text ?? '';
//       print('$time - Temperature: $temperature, Weather: $weather');
//       setState(() {
//         weatherData = '$time - Temperature: $temperature, Weather: $weather';
//       });
//     } else {
//       setState(() {
//         weatherData = 'No data found';
//       });
//       print('No data found');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Weather Recommendation'),
//         centerTitle: true,
//         backgroundColor: Colors.green,
//       ),
//       body: Center(
//         child: Container(
//           child: Text(weatherData), // Display the fetched weather data
//         ),
//       ),
//     );
//   }
// }
