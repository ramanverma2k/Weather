import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget getIcon(String description, {double? height}) {
  String assetName = 'assets/icons/';
  if (description == 'clear sky') {
    assetName = assetName + 'sunny.svg';
  } else if (description == 'few clouds') {
    assetName = assetName + 'sunny_intervals.svg';
  } else if (description == 'scattered clouds') {
    assetName = assetName + 'white_cloud.svg';
  } else if (description == 'mist') {
    assetName = assetName + 'mist.svg';
  } else if (description == 'fog') {
    assetName = assetName + 'fog.svg';
  } else if (description == 'light rain') {
    assetName = assetName + 'light_rain_showers.svg';
  } else if (description == 'moderate rain') {
    assetName = assetName + 'light_rain_showers.svg';
  } else if (description == 'heavy intensity rain') {
    assetName = assetName + 'heavy_rain_showers.svg';
  } else if (description == 'light intensity shower rain') {
    assetName = assetName + 'cloudy_with_light_rain.svg';
  } else if (description == 'heavy intensity shower rain') {
    assetName = assetName + 'cloudy_with_heavy_rain.svg';
  } else if (description == 'broken clouds') {
    assetName = assetName + 'cloudy_with_sleet.svg';
  } else {
    return Icon(Icons.error_outline_rounded, color: Colors.white);
  }

  final Widget svg = SvgPicture.asset(assetName, height: height);
  return svg;
}
