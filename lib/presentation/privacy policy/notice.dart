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
        title: const Text("Notice",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: kBlueColor,
      ),
      backgroundColor: kBlueColor,
      
      body: GetBuilder<HomeController>(
        builder: (controller) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(45.0),
            child: Column(

              children: [

                Text(
                  "Cloudy App collects location data to enable getting weather forecast of your current location even when the app is closed or not in use.",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'flutterfonts',
                      ),
                      textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: GestureDetector(
                    onTap: (){
                                                Get.to(() => PrivacyPolicy());

                    },
                    child: 
                    Text(
                            'click for privacy policy',
                            
                            style: TextStyle(fontSize: 14,color: Colors.white,
                            decoration: TextDecoration.combine([
                              TextDecoration.underline
                              ]
                            ),
                            ),
                          ),
                  ),
                    // child: ElevatedButton(
                    //     onPressed: () {
                    //       Get.to(() => PrivacyPolicy());
                    //     },
                    //        style: ElevatedButton.styleFrom(
                    //         primary: Colors.white,
                    //         elevation: 0.0
                    //       ),
                    //     child: const Padding(
                    //       padding: EdgeInsets.all(10.0),
                    //       child: Text(
                    //         'click for privacy policy',
                    //         style: TextStyle(fontSize: 14,color: kBlueColor),
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),),
                        ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ignore: sized_box_for_whitespace
                    Container(
                      width: 110,
                      child: ElevatedButton(
                          onPressed: () {
                           GetStorage().write(isPrivacyPolicyinStorage, false);

                            Get.off(() => HomeScreen());
                          },
                           style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          child: const Text("Deny",style: TextStyle(color: kBlueColor))),
                    ),
                    const SizedBox(width: 10,),
                    // ignore: sized_box_for_whitespace
                    Container(
                      width: 110,
                      child: ElevatedButton(
                          onPressed: () {
                            GetStorage().write(isPrivacyPolicyinStorage, false);

                            controller.getUserCityPosition();

                            Get.off(() => HomeScreen());
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          child: const Text("Accept",style: TextStyle(color: kBlueColor),)),
                    ),
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
