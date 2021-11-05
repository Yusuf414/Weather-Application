import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';

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
          DefaultTextStyle(
        style: const TextStyle(fontSize: 28.0),
        child: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText('Loading...'),
          ],
          isRepeatingAnimation: true,
         
        ),
      ),
      backgroundColor: kBlueColor,
      nextScreen: isPrivacyPolicyAccepted ? HomeScreen() : Notice(),
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
