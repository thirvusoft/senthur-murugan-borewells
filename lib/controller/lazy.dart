import 'package:flutter/material.dart';
import 'package:get/get.dart';

class lazy extends GetxController {
  var number = 0.obs;

  @override
  void onInit() {
    super.onInit();
    number.value = 45454006;
    print("lazy controler ${number.value}");
  }
}
