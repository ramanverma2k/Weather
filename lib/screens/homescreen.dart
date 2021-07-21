import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherium/screens/secondscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.weatherData}) : super(key: key);

  final weatherData;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var temp;
  var windSpeed;
  var humidity;
  var condition;
  var date;
  var selectedIndex = 0;

  void updateWeather(Map<String, dynamic> weatherData) {
    setState(() {
      if ((DateFormat('EEE, d MMM')
              .format(
                  DateTime.fromMillisecondsSinceEpoch(weatherData['dt'] * 1000))
              .toString() ==
          DateFormat('EEE, d MMM').format(DateTime.now()).toString())) {
        temp = weatherData['temp'].toInt();
        windSpeed = weatherData['wind_speed'];
        humidity = weatherData['humidity'];
        condition = toBeginningOfSentenceCase(
            '${weatherData['weather'][0]['description']}');
        date = weatherData['dt'];
      } else {
        temp = weatherData['temp']['max'].toInt();
        windSpeed = weatherData['wind_speed'];
        humidity = weatherData['humidity'];
        condition = toBeginningOfSentenceCase(
            '${weatherData['weather'][0]['description']}');
        date = weatherData['dt'];
      }
    });
  }

  @override
  void initState() {
    super.initState();
    updateWeather(widget.weatherData['current']);
  }

  @override
  Widget build(BuildContext context) {
    final String assetName = 'assets/icons/wsymbol_0001_sunny.svg';
    final Widget svg = SvgPicture.asset(
      assetName,
      semanticsLabel: 'Acme Logo',
      height: 250,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                          () => SecondScreen(weatherData: widget.weatherData));
                    },
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity! < 0) {
                        setState(() {
                          if (selectedIndex < 8) {
                            selectedIndex++;
                            selectedIndex == 0
                                ? updateWeather(widget.weatherData['current'])
                                : updateWeather(
                                    widget.weatherData['daily'][selectedIndex]);
                          }
                        });
                      } else if (details.primaryVelocity! > 0) {
                        setState(() {
                          if (selectedIndex > 0) {
                            selectedIndex--;
                            selectedIndex == 0
                                ? updateWeather(widget.weatherData['current'])
                                : updateWeather(
                                    widget.weatherData['daily'][selectedIndex]);
                          }
                        });
                      }
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${widget.weatherData['city']}',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white)),
                        ),
                        svg,
                        Text('$condition',
                            style:
                                TextStyle(fontSize: 30, color: Colors.white)),
                        Text(
                          '$temp°',
                          style: TextStyle(fontSize: 100, color: Colors.white),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('$windSpeed km/h',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                              Text('$humidity%',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white))
                            ],
                          ),
                        ),
                        SizedBox(height: 60),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: ListView.builder(
                            itemCount: widget.weatherData['daily'].length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: 20,
                                width: 130,
                                child: ListTile(
                                  key: Key(date.toString()),
                                  selected:
                                      selectedIndex == index ? true : false,
                                  title: Text(
                                    '${DateFormat('EEE, d MMM').format(DateTime.fromMillisecondsSinceEpoch(widget.weatherData['daily'][index]['dt'] * 1000))}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: selectedIndex == index
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                ),
                              );
                            },
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget hourlyCard(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.30,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
                '${DateFormat('jm').format(DateTime.fromMillisecondsSinceEpoch(widget.weatherData['hourly']['dt'] * 1000))}',
                style: TextStyle(fontSize: 19, color: Colors.white)),
            Icon(Icons.wb_cloudy_outlined, size: 60, color: Colors.white),
            Text(
              '${widget.weatherData['hourly']['temp'].toInt()}°',
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
