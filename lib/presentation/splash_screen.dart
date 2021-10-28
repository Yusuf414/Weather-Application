import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:weather_app/presentation/home_screen.dart';
import 'package:weather_app/presentation/privacy%20policy/notice.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class SplashScreen extends StatelessWidget {
   bool isPrivacyPolicyAccepted;
   SplashScreen({
    Key? key,
    required this.isPrivacyPolicyAccepted,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash:
          // ignore: sized_box_for_whitespace
          Container(
        height: double.infinity,
        width: double.infinity,
        child: Lottie.asset('assets/images/splash_screen/loading.json',
            fit: BoxFit.cover),
      ),
      nextScreen: isPrivacyPolicyAccepted ? HomeScreen() : Notice(),
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
