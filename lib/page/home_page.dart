import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:senthur_murugan/controller/apiservice.dart';
import 'package:senthur_murugan/widgets/internet_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ApiService apiService = ApiService();
  String customercount_ = "";
  String employeecount_ = "";
  String fullname = "";
  String imgurl =
      "https://i.pinimg.com/736x/87/67/64/8767644bc68a14c50addf8cb2de8c59e.jpg";
  @override
  void initState() {
    super.initState();

    count();
  }

  Future count() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await apiService
        .get("ssm_bore_wells.ssm_bore_wells.utlis.api.count", {});
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      setState(() {
        customercount_ = jsonResponse["message"]["customer"].toString();
        employeecount_ = jsonResponse["message"]["employee"].toString();
        imgurl = prefs.getString('image')!;
        fullname = prefs.getString('full_name')!;
        print(fullname);
      });
    }
  }

  @override
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15));
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFFFFFFFF),
        leading: Padding(
          padding: const EdgeInsets.only(left: 2),
          child: ClipOval(
            child: Image.network(
              imgurl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: ListTile(
            title: Text(fullname),
            subtitle: const Text(
              "vigneshmanimsc@gmail.com",
              style: TextStyle(color: Color(0xFF752FFF)),
            )),
        actions: [
          IconButton(
            onPressed: () async {
              final response = await apiService.get("logout", {});
              print(response.statusCode);
              print(response.body);
              if (response.statusCode == 200) {
                Get.offAllNamed("/loginpage");
              }
            },
            icon: const Icon(Icons.exit_to_app_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Visibility(
                visible: Provider.of<InternetConnectionStatus>(context) ==
                    InternetConnectionStatus.disconnected,
                child: const InternetNotAvailable(),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(230, 233, 230, 1),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: ListTile(
                              title: Text(
                                customercount_,
                                style: const TextStyle(
                                  color: Color(0xFF752FFF),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: const Text(
                                "Customer",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(230, 233, 230, 1),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: ListTile(
                            title: Text(
                              employeecount_,
                              style: const TextStyle(
                                color: Color(0xFF752FFF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: const Text(
                              "Employee",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(230, 233, 230, 1),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("    Attendance"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CircularPercentIndicator(
                            radius: 50,
                            animation: true,
                            animationDuration: 1200,
                            lineWidth: 15.0,
                            percent: 0.4,
                            // center: new Text(
                            //   "40 hours",
                            //   style: new TextStyle(
                            //       fontWeight: FontWeight.bold, fontSize: 20.0),
                            // ),
                            circularStrokeCap: CircularStrokeCap.round,
                            backgroundColor: const Color(0xFF752FFF),
                            progressColor: Colors.red,
                          ),
                        ),
                        const Expanded(
                            child: ListTile(
                                title: Text(
                                  "50",
                                  style: TextStyle(color: Color(0xFF752FFF)),
                                ),
                                subtitle: Text("Present"))),
                        const Expanded(
                            child: ListTile(
                                title: Text(
                                  "20",
                                  style: TextStyle(color: Colors.red),
                                ),
                                subtitle: Text("Absent"))),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(230, 233, 230, 1),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("    Attendance Details"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Month"),
                        Text("Customer"),
                        Text("Employee")
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      // The ListView
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ListView.separated(
                            itemCount: 12,
                            separatorBuilder: (BuildContext context,
                                    int index) =>
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Divider(),
                                ),
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                  leading: Container(
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xFF752FFF),
                                      boxShadow: const [
                                        BoxShadow(
                                          color:
                                              Color.fromRGBO(230, 233, 230, 1),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: const Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Fri",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "23",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: const Text(
                                    "GFG",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 15),
                                  ),
                                  title: Text("           List item $index"));
                            }),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
