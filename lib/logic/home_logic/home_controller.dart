import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/data/model/current_weather_data.dart';
import 'package:weather_app/data/model/five_days_data.dart';
import 'package:weather_app/data/web_services/weather_web_services.dart';

class HomeController extends GetxController {
  String? city;
  HomeController({
    required this.city,
  });
  // creating instances to be used
  CurrentWeatherData currentWeatherData = CurrentWeatherData();
  List<CurrentWeatherData> dataList = [];
  List<FiveDayData> fiveDaysData = [];
  double? latitude;
  double? longitude;
  String? cityLocation;
  // ignore: prefer_typing_uninitialized_variables
  var position;
  bool isHomeScreen = false;

  // onInit is a special method of getx to initialize these functions at run time such as the onInit of the stateful wideget
  @override
  void onInit() {
    initState();
    getTopFiveCities();

    super.onInit();
  }

  void initState() {
    getCurrentWeatherData();
    getFiveDaysData();
  }

  void getCurrentWeatherData() {
    WeatherWebServices(city: city).getCurrentweather(
        onSuccess: (data) {
          currentWeatherData = data;
          update();
        },
        onError: (error) => {
              if (isHomeScreen)
                {
                  Get.defaultDialog(
                    title: "Oops!",
                    titleStyle: const TextStyle(color: Colors.white),
                    middleTextStyle: const TextStyle(color: Colors.white),
                    backgroundColor: const Color(0xff3490dc),
                    middleText: "Something Went Wrong...",
                  ),
                  update(),
                },
            });
  }

  void getTopFiveCities() {
    List<String> cities = ['London', 'New York', 'Paris', 'Moscow', 'Tokyo'];
    // ignore: avoid_function_literals_in_foreach_calls
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
    WeatherWebServices(city: city).getFiveDaysThreeHoursForcastData(
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

  // Accessing user location and asking for permission using geocoding and geolocator packages
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
    GetStorage().write("Privacy Policy", true);

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getAddressFromLatLon(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    cityLocation = place.subAdministrativeArea;
    city = cityLocation;
    update();
    updateWeather();
  }

  void getUserCityPosition() async {
    position = await determinePosition();
    await getAddressFromLatLon(position);
  }

// a switch implementation to fetch the right photo with the weather state data comes from api
  AssetImage selectImageForWeather(String weatherImageId) {
    // ignore: unused_local_variable
    AssetImage image;
    switch (weatherImageId) {
      case "01d": //clear sky daylight
        return image = const AssetImage('assets/images/01d.png');
      case "01n": //clear sky night
        return image = const AssetImage('assets/images/01n.png');
      case "02d":
        return image = const AssetImage('assets/images/02d.png');
      case "02n":
        return image = const AssetImage('assets/images/02n.png');
      case "03d":
        return image = const AssetImage('assets/images/03d.png');
      case "03n":
        return image = const AssetImage('assets/images/03d.png');
      case "04d":
        return image = const AssetImage('assets/images/03d.png');
      case "04n":
        return image = const AssetImage('assets/images/04d.png');
      case "09d":
        return image = const AssetImage('assets/images/04d.png');
      case "09n":
        return image = const AssetImage('assets/images/09d.png');
      case "10d":
        return image = const AssetImage('assets/images/10d.png');
      case "10n":
        return image = const AssetImage('assets/images/10n.png');
      case "11d":
        return image = const AssetImage('assets/images/11d.png');
      case "11n":
        return image = const AssetImage('assets/images/11n.png');
      case "13d":
        return image = const AssetImage('assets/images/13d.png');
      case "13n":
        return image = const AssetImage('assets/images/13n.png');
      case "50d":
        return image = const AssetImage('assets/images/50d.png');
      case "50n":
        return image = const AssetImage('assets/images/50n.png');
    }
    return image = const AssetImage('assets/images/default.png');
  }
}
