import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:senthur_murugan/widgets/appbar.dart';
import 'package:intl/intl.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color(0xFF752FFF)), // Provide your leading icon
          onPressed: () {
            // Add your leading icon functionality here
          },
        ),
        title: 'Attendance',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: IconButton(
                  iconSize: 50,
                  icon: const Icon(
                    PhosphorIcons.user_focus,
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Date : ${DateFormat.yMMMEd()

                    // displaying formatted date
                    .format(DateTime.now())}",
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                  "123, Jain Cambrae East, Avinashi Rd, near SMS Hotel, Peelamedu, Coimbatore, Tamil Nadu 641004"),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(
                            0xFF752FFF), // Change the button color to blue
                        minimumSize: Size(double.infinity,
                            50), // Increase the button height to 50 pixels
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Check In',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: OutlinedButton(
                    child: Text('Check Out'),
                    onPressed: () {
                      print('Pressed');
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color:
                              Color(0xFF752FFF)), // Set the border color to red
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
