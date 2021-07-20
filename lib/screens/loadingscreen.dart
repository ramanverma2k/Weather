import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherium/screens/homescreen.dart';
import 'package:weatherium/services/openweather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    setWeatherData();
  }

  void setWeatherData() async {
    Map<String, dynamic>? weatherData = await getWeatherData();

    Get.to(() => HomeScreen(weatherData: weatherData));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
