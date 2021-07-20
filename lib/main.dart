import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherium/screens/homescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
          primaryColor: Color(0xFF252736),
          scaffoldBackgroundColor: Color(0xFF252736),
          cardColor: Colors.white.withOpacity(0.4),
          cardTheme: CardTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 0),
          textTheme:
              GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)),
      title: 'Weatherium',
      home: HomeScreen(),
    );
  }
}
