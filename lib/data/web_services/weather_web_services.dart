class WeatherWebServices {
  final String city;
  WeatherWebServices({
    required this.city,
  });
  void getCurrentweather({
    Function()? beforeSend,
    Function(dynamic currentWeatherData)? onSuccess,
    Function(dynamic error)? onError,
  }){}
  void getTopFiveCities({
    Function()? beforeSend,
    Function(dynamic currentWeatherData)? onSuccess,
    Function(dynamic error)? onError,
  }){}
  void getFiveDaysThreeHoursForecastData({
    Function()? beforeSend,
    Function(dynamic currentWeatherData)? onSuccess,
    Function(dynamic error)? onError,
  }){}
}
