import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Weather extends Equatable {
  final String cityName;
  final int temp;
  Weather({@required this.cityName, @required this.temp})
      : assert(cityName != null && temp != null);

  @override
  List<Object> get props => [cityName, temp];
}

class GenerateWeather {
  Future<Weather> generateWeather(String cityName) async {
    final rndmTemp = Random().nextInt(50);
    Weather weather = Weather(cityName: cityName, temp: rndmTemp);
    await Future.delayed(Duration(milliseconds: 1500));
    return weather;
  }
}
