import 'package:flutter/material.dart';
import 'package:senthur_murugan/controller/apiservice.dart';

class PopupWidget extends StatefulWidget {
  final Widget child;
  final String title;
  final String content;

  PopupWidget(
      {super.key,
      required this.child,
      required this.title,
      required this.content});

  @override
  State<PopupWidget> createState() => _PopupWidgetState();
}

class _PopupWidgetState extends State<PopupWidget> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        title: Text(
          widget.title,
        ),
        content: Text(
          widget.content,
          textAlign: TextAlign.left,
        ),
        actions: [widget.child],
      );
    });
  }
}
