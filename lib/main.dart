import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/constants.dart';

import 'package:weather_app/logic/home_logic/home_controller.dart';
import 'package:weather_app/presentation/home_screen.dart';
import 'package:weather_app/presentation/splash_screen.dart';

import 'logic/home_logic/home_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HomeController(city: 'Berlin').getCurrentWeatherData;
  //checking if user accepted privacy policy and access location
  //getting the acceptance value from getx storage
  bool isPrivacyPolicyAccepted;
  await GetStorage.init();
  if (GetStorage().read(isPrivacyPolicyinStorage) != null) {
    isPrivacyPolicyAccepted = GetStorage().read(isPrivacyPolicyinStorage);
  } else {
    isPrivacyPolicyAccepted = false;
  }

  runApp(MyApp(
    isPrivacyPolicyRead: isPrivacyPolicyAccepted,
  ));
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool isPrivacyPolicyRead;
  const MyApp({
    Key? key,
    required this.isPrivacyPolicyRead,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: kPrimaryColor,
        fontFamily: 'flutterfonts'
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => SplashScreen(isPrivacyPolicyAccepted: isPrivacyPolicyRead),
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
