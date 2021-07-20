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
                GestureDetector(
                  onTap: () {
                    Get.to(() => SecondScreen(weatherData: widget.weatherData));
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${widget.weatherData['city']}',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white)),
                        ),
                        svg,
                        Text(
                            '${widget.weatherData['current']['weather'][0]['main']}',
                            style:
                                TextStyle(fontSize: 30, color: Colors.white)),
                        Text(
                          '${widget.weatherData['current']['temp'].toInt()}°',
                          style: TextStyle(fontSize: 100, color: Colors.white),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                  '${widget.weatherData['current']['wind_speed']} km/h',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                              Text(
                                  '${widget.weatherData['current']['humidity']}%',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 60),
                Container(
                  height: MediaQuery.of(context).size.height * 0.342,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: widget.weatherData['daily'].length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                              '${DateFormat('EEE, d MMM').format(DateTime.fromMillisecondsSinceEpoch(widget.weatherData['daily'][index]['dt'] * 1000))}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          SizedBox(height: 30),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.30,
                            child: Card(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                      '${DateFormat('jm').format(DateTime.fromMillisecondsSinceEpoch(widget.weatherData['hourly'][index]['dt'] * 1000))}',
                                      style: TextStyle(
                                          fontSize: 19, color: Colors.white)),
                                  Icon(Icons.wb_cloudy_outlined,
                                      size: 60, color: Colors.white),
                                  Text(
                                    '${widget.weatherData['hourly'][index]['temp'].toInt()}°',
                                    style: TextStyle(
                                        fontSize: 40, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
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
