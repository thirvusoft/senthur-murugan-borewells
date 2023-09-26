import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:senthur_murugan/controller/lazy.dart';
import 'package:senthur_murugan/controller/put.dart';

class MyWidget extends GetView<Put> {
  MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(Put());

    return Scaffold(
      body: Center(
          child: Obx(
        () => Text('Number from controller: ${controller.number.value}'),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.increment();
        },
        child: const Icon(Icons.navigation),
      ),
    );
  }
}
