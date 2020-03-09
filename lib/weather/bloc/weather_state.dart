part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => null;
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherDone extends WeatherState {
  final Weather weather;
  WeatherDone({@required this.weather}) : assert(weather != null);

  @override
  List<Object> get props => [weather];
}
