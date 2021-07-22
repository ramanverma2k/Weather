import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:weatherium/services/location.dart';

Future<Map<String, dynamic>?> getWeatherData() async {
  Location location = new Location();
  Position position = await location.determinePosition();
  String? cityName = await location.getCityNameFromCoordinates(
      position.latitude, position.longitude);

  String _apiKey = '';
  String _url =
      'https://api.openweathermap.org/data/2.5/onecall?lat=${position.latitude}&lon=${position.longitude}&units=metric&exclude=minutely,alerts&appid=$_apiKey';

  Response response = await get(Uri.parse(_url));
  if (response.statusCode == 200) {
    Map<String, dynamic> weatherData = jsonDecode(response.body);
    weatherData['city'] = cityName;
    return weatherData;
  } else {
    debugPrint('${response.statusCode}');
  }
}
