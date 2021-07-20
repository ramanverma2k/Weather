import 'package:flutter/material.dart';
import 'package:weatherium/widgets/current.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                CurrentWeather(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
