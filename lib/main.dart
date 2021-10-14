import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/route_manager.dart';
import 'package:weather_app/presentation/home_screen.dart';

import 'logic/home_logic/home_binding.dart';

void main() {
  runApp( MyApp());
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
          page: ()=> HomeScreen(),
          binding: HomeBinding(),
          ),
     ],
    );
  }
}