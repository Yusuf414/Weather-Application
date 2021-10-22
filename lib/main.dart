import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:weather_app/logic/home_logic/home_controller.dart';
import 'package:weather_app/presentation/home_screen.dart';
import 'package:weather_app/presentation/splash_screen.dart';

import 'logic/home_logic/home_binding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HomeController(city: 'Berlin').getCurrentWeatherData;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => SplashScreen(),
         binding: HomeBinding(),

        ),
        GetPage(
          name: '/home_screen',
          page: () => HomeScreen(),
          binding: HomeBinding(),
        ),
      ],
    );
  }
}
