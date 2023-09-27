import 'package:get/get.dart';

class Put extends GetxController {
  var number = 0.obs;
  @override
  void onInit() {
    super.onInit();
    number.value = 1;
    print("put controler ${number.value}");
  }

  increment() {
    number.value += 1;
  }
}
