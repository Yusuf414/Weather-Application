import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:weather_app/data/model/current_weather_data.dart';
import 'package:weather_app/data/model/five_days_data.dart';
import 'package:weather_app/data/web_services/weather_web_services.dart';

class HomeController extends GetxController {
  String? city = 'loading...';
  HomeController({
    required this.city,
  });

  CurrentWeatherData currentWeatherData = CurrentWeatherData();
  List<CurrentWeatherData> dataList = [];
  List<FiveDayData> fiveDaysData = [];
  double? latitude;
  double? longitude;
  String? cityLocation;
  var position;
  @override
  void onInit() {
    initState();
    getTopFiveCities();

    super.onInit();
  }

  void initState() {
    getUserCityPosition();
    getCurrentWeatherData();
    getFiveDaysData();
  }

  void getUserCityPosition() async {
    position = await determinePosition();
    await GetAddressFromLatLon(position);
  }

  void getCurrentWeatherData() {
    WeatherWebServices(city: city).getCurrentweather(
        onSuccess: (data) {
          currentWeatherData = data;
          update();
        },
        onError: (error) => {
              update(),
            });
  }

  void getTopFiveCities() {
    List<String> cities = ['London', 'New York', 'Paris', 'Moscow', 'Tokyo'];
    cities.forEach((element) {
      WeatherWebServices(city: element).getCurrentweather(onSuccess: (data) {
        dataList.add(data);
        update();
      }, onError: (error) {
        update();
      });
    });
  }

  void getFiveDaysData() {
    WeatherWebServices(city: '$city').getFiveDaysThreeHoursForcastData(
        onSuccess: (data) {
      fiveDaysData = data;
      update();
    }, onError: (error) {
      update();
    });
  }

  void updateWeather() {
    getCurrentWeatherData();
    getFiveDaysData();
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> GetAddressFromLatLon(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    cityLocation = place.subAdministrativeArea;
    city = cityLocation;
    update();
    updateWeather();
  }

  AssetImage selectImageForWeather(String weatherImageId) {
    AssetImage image;
    switch (weatherImageId) {
      case "01d": //clear sky daylight
        return image = AssetImage('assets/images/01d.png');
      case "01n": //clear sky night
        return image = AssetImage('assets/images/01n.png');
      case "02d":
        return image = AssetImage('assets/images/02d.png');
      case "02n":
        return image = AssetImage('assets/images/02n.png');
      case "03d":
        return image = AssetImage('assets/images/03d.png');
      case "03n":
        return image = AssetImage('assets/images/03d.png');
      case "04d":
        return image = AssetImage('assets/images/03d.png');
      case "04n":
        return image = AssetImage('assets/images/03d.png');
      case "09d":
        return image = AssetImage('assets/images/09d.png');
      case "09n":
        return image = AssetImage('assets/images/09d.png');
      case "10d":
        return image = AssetImage('assets/images/10d.png');
      case "10n":
        return image = AssetImage('assets/images/10n.png');
      case "11d":
        return image = AssetImage('assets/images/11d.png');
      case "11n":
        return image = AssetImage('assets/images/11d.png');
      case "13d":
        return image = AssetImage('assets/images/13d.png');
      case "13n":
        return image = AssetImage('assets/images/13d.png');
      case "50d":
        return image = AssetImage('assets/images/50d.png');
      case "50n":
        return image = AssetImage('assets/images/50d.png');
    }
    return image = AssetImage('assets/images/default.png');
  }
}
