import 'dart:ffi';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:weather_app/data/model/current_weather_data.dart';
import 'package:weather_app/data/web_services/weather_web_services.dart';

class HomeController extends GetxController {
  String? city;
  String? searchText;
  HomeController({
    required this.city,
    this.searchText,
  });

  CurrentWeatherData currentWeatherData = CurrentWeatherData();

  @override
  void onInit() {
    initState();
    super.onInit();
  }

  void initState() {
    WeatherWebServices(city: '$city').getCurrentweather(onSuccess: (data) {
      currentWeatherData = data;
      update();
    });
  }
}
