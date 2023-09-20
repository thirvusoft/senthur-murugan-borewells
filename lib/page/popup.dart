import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senthur_murugan/controller/apiservice.dart';

class PopupWidget extends StatelessWidget {
  final ApiService apiService = ApiService();

  final Widget child;
  final String title;
  final String content;

  PopupWidget(
      {super.key,
      required this.child,
      required this.title,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Text(
        title,
      ),
      content: Text(
        content,
        textAlign: TextAlign.left,
      ),
      actions: [child],
    );
  }
}
