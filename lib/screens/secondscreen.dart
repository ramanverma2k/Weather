import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherium/utilites/getIcon.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key, required this.weatherData}) : super(key: key);

  final weatherData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('${weatherData['city']}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: 40,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 45.0, horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white.withOpacity(0.4)),
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('15 minutes ago',
                              style: TextStyle(color: Colors.white)),
                          SizedBox(height: 15),
                          Text(
                              'The Wind is very strong today! This is not the time for a yacht trip.',
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Next Week',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        Divider(color: Colors.transparent),
                    itemCount: 7,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${DateFormat('EEEEE').format(DateTime.fromMillisecondsSinceEpoch(weatherData['daily'][index]['dt'] * 1000))}',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              getIcon(
                                  '${weatherData['daily'][index]['weather'][0]['description']}',
                                  height: 30)
                            ],
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              '${weatherData['daily'][index]['temp']['max'].toInt()}°    ${weatherData['daily'][index]['temp']['min'].toInt()}°',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Align(
                  alignment: Alignment.topRight,
                  child: getIcon(
                      '${weatherData['current']['weather'][0]['description']}',
                      height: 125)),
            ),
          ],
        ),
      ),
    );
  }
}
