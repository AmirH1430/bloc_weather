import 'package:flutter/material.dart';
import 'package:weather/weather/weather_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather app',
      home: WeatherPage(),
    );
  }
}
