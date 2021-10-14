import 'dart:ffi';

import 'package:get/get_state_manager/get_state_manager.dart';

class HomeController extends GetxController {
  String? city;
  String? searchText;
  HomeController({
   required this.city,
    this.searchText,
  });
  @override
  void onInit() {
    super.onInit();
  }
}
