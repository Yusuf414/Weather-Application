import 'package:weather_app/data/model/sys.dart';
import 'package:weather_app/data/model/weather.dart';
import 'package:weather_app/data/model/wind.dart';

import 'clouds.dart';
import 'coord.dart';
import 'main_weather.dart';

class CurrentWeatherData {
  Coord? coord;
  List<Weather>? weather = [];
  String? base;
  MainWeather? main;
  int? visibility = 0;
  Wind? wind;
  Clouds? clouds;
  int? dt = 0;
  Sys? sys;
  int? timezone = 0;
  int? id = 0;
  String? name = '';
  int? cod = 0;

  CurrentWeatherData(
      {this.coord,
      this.weather,
      this.base,
      this.main,
      this.visibility,
      this.wind,
      this.clouds,
      this.dt,
      this.sys,
      this.timezone,
      this.id,
      this.name,
      this.cod});

  factory CurrentWeatherData.fromJson(dynamic json) {
    if (json == null) {
      return CurrentWeatherData();
    }

    return CurrentWeatherData(
      coord: Coord.fromJson(json['coord']),
      weather:
          (json['weather'] as List).map((w) => Weather.fromJson(w)).toList(),
      base: json['base'],
      main: MainWeather.fromJson(json['main']),
      visibility: json['visibility'],
      wind: Wind.fromJson(json['wind']),
      clouds: Clouds.fromJson(json['clouds']),
      dt: json['dt'],
      sys: Sys.fromJson(json['sys']),
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }
}
