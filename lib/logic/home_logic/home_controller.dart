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
    getTopFiveCities();
    getFiveDaysData();
  }

  void getUserCityPosition() async {
    position = await determinePosition();
    await GetAddressFromLatLon(position);
    city = cityLocation;
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
    updateWeather();
  }

  AssetImage selectImageForWeather(int weatherId) {
    AssetImage image;
    if (weatherId >= 200 && weatherId <= 232) {
      return image = const AssetImage('assets/images/cloud-bolt.png');
    } else if (weatherId >= 300 && weatherId < 321) {
      return image = const AssetImage('assets/images/cloud-drizzle.png');
    } else if (weatherId >= 500 && weatherId < 531) {
      return image = const AssetImage('assets/images/cloud-rain.png');
    } else if (weatherId >= 600 && weatherId <= 622) {
      return image = const AssetImage('assets/images/cloud-snow.png');
    } else if (weatherId >= 701 && weatherId < 781) {
      return image = const AssetImage('assets/images/cloud-fog.png');
    } else if (weatherId == 800) {
      return image = const AssetImage('assets/images/sun-max.png');
    } else if (weatherId > 800 && weatherId <= 804) {
      return image = const AssetImage('assets/images/normal.png');
    } else {
      return image = const AssetImage('assets/images/normal.png');
    }
  }
}
