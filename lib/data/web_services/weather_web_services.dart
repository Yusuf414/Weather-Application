import 'package:weather_app/data/model/current_weather_data.dart';
import 'package:weather_app/data/model/five_days_data.dart';
import 'package:weather_app/data/repository/weather_repository.dart';

class WeatherWebServices {
  String? city = 'london';

  String baseUrl = 'https://api.openweathermap.org/data/2.5';
  String apiKey = 'appid=YOUR_API_KEY';
  WeatherWebServices({
     this.city,
  });
  void getCurrentweather({
    Function()? beforeSend,
    Function(CurrentWeatherData currentWeatherData)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    final url = '$baseUrl/weather?q=$city&lang=en&$apiKey';
    ApiRepository(url: url, payload: null).getData(
        beforeSend: () => {
              if (beforeSend != null)
                {
                  beforeSend(),
                }
            },
        onSuccess: (data) => {
              onSuccess!(CurrentWeatherData.fromJson(data)),
            },
        onError: (error) => {
              if (onError != null)
                {
                  onError(error),
                }
            });
  }

  void getFiveDaysThreeHoursForcastData({
    Function()? beforSend,
    Function(List<FiveDayData> fiveDayData)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    final url = '$baseUrl/forecast?q=$city&lang=en&$apiKey';
    ApiRepository(url: url, payload: null).getData(
        beforeSend: () => {},
        onSuccess: (data) => {
              onSuccess!((data['list'] as List)
                  .map((t) => FiveDayData.fromJson(t))
                  .toList()),
            },
        onError: (error) => {
              onError!(error),
            });
  }
}
