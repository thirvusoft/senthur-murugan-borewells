import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class InternetNotAvailable extends StatelessWidget {
  const InternetNotAvailable({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 18,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(230, 233, 230, 1),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        child: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: ListTile(
            leading: Icon(
              PhosphorIcons.wifi_slash,
              color: Colors.white,
            ),
            title: Text(
              'No Internet Connection !',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ));
  }
}
