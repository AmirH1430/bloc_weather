import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather/models/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  @override
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeather) {
      yield WeatherLoading();
      Weather generated =
          await GenerateWeather().generateWeather(event.cityName);
      yield WeatherDone(weather: generated);
    }
    if (event is NewWeather) {
      yield WeatherEmpty();
    }
  }

  @override
  void onTransition(Transition<WeatherEvent, WeatherState> transition) {
    print(transition);
  }
}
