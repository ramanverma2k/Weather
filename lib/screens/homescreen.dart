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
  List<dynamic> hourly = [];
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
        updateHourlyWeather(widget.weatherData['hourly'], date);
      } else {
        temp = weatherData['temp']['max'].toInt();
        windSpeed = weatherData['wind_speed'];
        humidity = weatherData['humidity'];
        condition = toBeginningOfSentenceCase(
            '${weatherData['weather'][0]['description']}');
        date = weatherData['dt'];
        updateHourlyWeather(widget.weatherData['hourly'], date);
      }
    });
  }

  void updateHourlyWeather(List<dynamic> weatherData, int date) {
    hourly.clear();
    weatherData.forEach((e) => ((DateFormat('EEE, d MMM')
                .format(DateTime.fromMillisecondsSinceEpoch(e['dt'] * 1000))
                .toString() ==
            DateFormat('EEE, d MMM')
                .format(DateTime.fromMillisecondsSinceEpoch(date * 1000))
                .toString())
        ? hourly.add(e)
        : null));
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
                    onHorizontalDragEnd: (DragEndDetails details) {
                      if (details.primaryVelocity! < 1) {
                        setState(() {
                          if (selectedIndex < 8) {
                            selectedIndex++;
                            selectedIndex == 0
                                ? updateWeather(widget.weatherData['current'])
                                : updateWeather(
                                    widget.weatherData['daily'][selectedIndex]);
                          }
                        });
                      } else if (details.primaryVelocity! > 1) {
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
                        SizedBox(height: 40),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: ListView.builder(
                            itemCount: hourly.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: 20,
                                width: 130,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${DateFormat('jm').format(DateTime.fromMillisecondsSinceEpoch(hourly[index]['dt'] * 1000))}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          '${hourly[index]['temp'].toInt()}°',
                                          style: TextStyle(
                                              fontSize: 40,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
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
}

// DateFormat('jm')
