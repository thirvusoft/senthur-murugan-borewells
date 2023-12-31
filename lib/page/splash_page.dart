import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/api.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    splash();
  }

  splash() async {
    final Customer customer = Get.put(Customer());
    await Future.delayed(const Duration(seconds: 3));
    customer.splash();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF752FFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SK Bore Wells",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: .3),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
                height: 35,
                width: 35,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
