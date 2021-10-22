import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/presentation/home_screen.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 
         Container(
           
        height: double.infinity,
        width: double.infinity,
        child:
            Lottie.asset('assets/images/splash_screen/loading.json', fit: BoxFit.cover),
      ),        
      nextScreen: HomeScreen(),
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}