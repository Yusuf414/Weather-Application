import 'package:weather_app/data/model/current_weather_data.dart';
import 'package:weather_app/data/repository/weather_repository.dart';

class WeatherWebServices {
  final String city;

  String baseUrl = 'http://api.openweathermap.org/data/2.5';
  String apiKey = 'appid=5d57a4f248641b52b0cc09e606db8162';
  WeatherWebServices({
    required this.city,
  });
  void getCurrentweather({
    Function()? beforeSend,
    Function(CurrentWeatherData currentWeatherData)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    final url = '$baseUrl/weather?q=$city&lang=en&$apiKey';
    ApiRepository(url: '$url').getData(
      beforeSend: ()=> {
        if (beforeSend !=null){
          beforeSend(),
        }
      },
      onSuccess: (data)=> {
        onSuccess!(CurrentWeatherData.fromJson(data)),
      },
      onError: (error)=> {
        if (onError != null) {
          print(error),
          onError(error),
        }
      }
    );
  }

  void getTopFiveCities({
    Function()? beforeSend,
    Function(dynamic currentWeatherData)? onSuccess,
    Function(dynamic error)? onError,
  }) {}
  void getFiveDaysThreeHoursForecastData({
    Function()? beforeSend,
    Function(dynamic currentWeatherData)? onSuccess,
    Function(dynamic error)? onError,
  }) {}
}
