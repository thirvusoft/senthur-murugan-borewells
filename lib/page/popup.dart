import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senthur_murugan/controller/apiservice.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PopupWidget extends StatefulWidget {
  @override
  _PopupWidgetState createState() => _PopupWidgetState();
}

class _PopupWidgetState extends State<PopupWidget> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: const Text(
        'Logout',
      ),
      content: const Text(
        'Do you want to log out from \n Sk Borewell?',
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 15),
            ),
            onPressed: () {
              Get.back();
            }),
        const SizedBox(
          width: 30,
        ),
        ElevatedButton(
          child: const Text(
            'Yes, Logout',
            style: TextStyle(fontSize: 15),
          ),
          onPressed: () async {
            final response = await apiService.get("logout", {});

            if (response.statusCode == 200) {
              Get.offAllNamed("/loginpage");
            }
          },
        ),
      ],
    );
  }
}
