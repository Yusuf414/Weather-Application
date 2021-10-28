import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/logic/home_logic/home_controller.dart';
import 'package:weather_app/presentation/home_screen.dart';
import 'package:weather_app/presentation/privacy%20policy/privacy_policy.dart';

// ignore: use_key_in_widget_constructors
class Notice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notice"),
        centerTitle: true,
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(45.0),
            child: Column(
              children: [
                Text(
                  "Cloudy App collects location data to enable getting weather forecast of your current location even when the app is closed or not in use.",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        // color: Colors.black45,
                        fontSize: 22,
                        fontFamily: 'flutterfonts',
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                    child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => PrivacyPolicy());
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'click here\n to read \nour privacy policy',
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ))),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                         GetStorage().write(isPrivacyPolicyinStorage, false);

                          Get.off(() => HomeScreen());
                        },
                        child: const Text("Deny")),
                    ElevatedButton(
                        onPressed: () {
                          GetStorage().write(isPrivacyPolicyinStorage, false);

                          controller.getUserCityPosition();

                          Get.off(() => HomeScreen());
                        },
                        child: const Text("Accept")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
