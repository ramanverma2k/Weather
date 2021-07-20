import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weatherium/screens/secondscreen.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String assetName = 'assets/icons/wsymbol_0001_sunny.svg';
    final Widget svg = SvgPicture.asset(
      assetName,
      semanticsLabel: 'Acme Logo',
      height: 250,
    );

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SecondScreen()));
          },
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Jingalala',
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                ),
                svg,
                Text('Sunny',
                    style: TextStyle(fontSize: 30, color: Colors.white)),
                Text(
                  '28',
                  style: TextStyle(fontSize: 100, color: Colors.white),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('8km/h',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      Text('47%',
                          style: TextStyle(fontSize: 20, color: Colors.white))
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
            itemCount: 3,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                      '${DateFormat('EEE, d MMM').format(DateTime.parse('${20210719 + index}'))}',
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('${DateFormat('jm').format(DateTime.now())}',
                              style:
                                  TextStyle(fontSize: 19, color: Colors.white)),
                          Icon(Icons.wb_cloudy_outlined,
                              size: 60, color: Colors.white),
                          Text(
                            '28',
                            style: TextStyle(fontSize: 40, color: Colors.white),
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
    );
  }
}
