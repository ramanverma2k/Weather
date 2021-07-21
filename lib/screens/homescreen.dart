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
  var selectedIndex;

  void updateWeather(Map<String, dynamic> weatherData) {
    setState(() {
      if ((DateFormat('EEE, d MMM')
              .format(DateTime.fromMillisecondsSinceEpoch(
                  widget.weatherData['current']['dt'] * 1000))
              .toString() ==
          DateFormat('EEE, d MMM').format(DateTime.now()).toString())) {
        temp = widget.weatherData['current']['temp'].toInt();
        windSpeed = widget.weatherData['current']['wind_speed'];
        humidity = widget.weatherData['current']['humidity'];
        condition = toBeginningOfSentenceCase(
            '${widget.weatherData['current']['weather'][0]['description']}');
      } else {
        temp = widget.weatherData['daily']['temp']['max'].toInt();
        windSpeed = widget.weatherData['daily']['wind_speed'];
        humidity = widget.weatherData['daily']['humidity'];
        condition = toBeginningOfSentenceCase(
            '${widget.weatherData['daily']['weather'][0]['description']}');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    updateWeather(widget.weatherData);
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
                          if (selectedIndex <= 8) {
                            selectedIndex++;
                            updateWeather(widget.weatherData);
                          }
                        });
                      } else if (details.primaryVelocity! > 0) {
                        setState(() {
                          if (selectedIndex > 0) {
                            selectedIndex--;
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
                                  key: Key(date),
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
