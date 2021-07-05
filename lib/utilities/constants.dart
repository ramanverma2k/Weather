import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
);

const kConditionTextStyle =
    TextStyle(fontSize: 100.0, decoration: TextDecoration.none);

const kInputField = InputDecoration(
  hintText: 'Enter Your City Name',
  hintStyle: TextStyle(
    color: Colors.black45,
  ),
  filled: true,
  fillColor: Colors.white60,
  hoverColor: Colors.white,
  focusColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
);
