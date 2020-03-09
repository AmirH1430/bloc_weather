import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather/bloc/weather_bloc.dart';
import 'package:weather/weather/models/weather.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  var bloc = WeatherBloc();
  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherBloc, WeatherState>(
        bloc: bloc,
        listener: (context, state) {},
        child: BlocProvider(
          create: (context) => WeatherBloc(),
          child: SafeArea(
            child: Scaffold(
              body: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherEmpty) {
                    return Center(child: WeatherInputCity());
                  }
                  if (state is WeatherLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is WeatherDone) {
                    return Center(child: WeatherDonePage(weather: state.weather));
                  }
                  return Center(child: Text('error'));
                },
              ),
            ),
          ),
        ));
  }
}

class WeatherInputCity extends StatefulWidget {
  @override
  _WeatherInputCityState createState() => _WeatherInputCityState();
}

class _WeatherInputCityState extends State<WeatherInputCity> {
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Material(
              color: Colors.white,
              elevation: 4,
              borderRadius: BorderRadius.circular(10),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    border: InputBorder.none,
                    hintText: 'city name ...'),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            icon: Icon(Icons.search,color: Colors.cyan,),
            onPressed: () {
              BlocProvider.of<WeatherBloc>(context)
                  .add(GetWeather(controller.text));
            },
          ),
        ),
      ],
    );
  }
}

class WeatherDonePage extends StatefulWidget {
  final Weather weather;
  WeatherDonePage({@required this.weather}) : assert(weather != null);

  @override
  _WeatherDonePageState createState() => _WeatherDonePageState();
}

class _WeatherDonePageState extends State<WeatherDonePage> {
  @override
  Widget build(BuildContext context) {
    var cityname = widget.weather.cityName;
    var temperature = widget.weather.temp;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.location_city, color: Colors.grey[900]),
            title: Text.rich(
              TextSpan(children: [
                TextSpan(text: 'city name: '),
                TextSpan(
                  text: cityname,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ]),
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text.rich(
              TextSpan(children: [
                TextSpan(text: 'temperature: '),
                TextSpan(
                  text: '$temperature °C',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ]),
              style: TextStyle(color: Colors.black),
            ),
            trailing: IconButton(
              color: Colors.cyan,
              icon: Icon(Icons.clear),
              onPressed: () {
                BlocProvider.of<WeatherBloc>(context).add(NewWeather());
              },
            ),
          ),
        ],
      ),
    );
  }
}
