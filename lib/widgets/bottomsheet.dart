import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget child; // Content to be displayed in the bottom sheet
  final String title;
  const CustomBottomSheet({required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Close the bottom sheet when tapped outside of it
          Navigator.of(context).pop();
        },
        child: Container(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // SizedBox(height: 16.0), // Add spacing from the bottom
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Divider(), // Add a divider
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: child, // Content passed to the bottom sheet
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
