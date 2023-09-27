import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:senthur_murugan/controller/apiservice.dart';
import 'package:senthur_murugan/controller/put.dart';
import 'package:senthur_murugan/page/tesr.dart';
import 'package:senthur_murugan/widgets/reusable_popup.dart';
import 'package:senthur_murugan/widgets/internet_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ApiService apiService = ApiService();
  final List points = [];

  double percentage = 0.0;
  String present = "0";
  String absent = "0";
  String customercount_ = "";
  String employeecount_ = "";
  String fullname = "";
  String email = "";
  var calcount = [];

  // List<FlSpot> dummyData5 = [];
  // final List<FlSpot> dummyData1 = List.generate(7, (index) {
  //   return FlSpot(index.toDouble(), index * Random().nextDouble());
  // });

  // // This will be used to draw the orange line
  // final List<FlSpot> dummyData2 = List.generate(7, (index) {
  //   return FlSpot(index.toDouble(), index * Random().nextDouble());
  // });

  // // This will be used to draw the blue line
  // final List<FlSpot> dummyData3 = List.generate(7, (index) {
  //   return FlSpot(index.toDouble(), index * Random().nextDouble());
  // });

  // final List<FlSpot> dummyData4 = List.generate(7, (index) {
  //   return FlSpot(index.toDouble(), index * Random().nextDouble());
  // });

  String imgurl =
      "https://i.pinimg.com/736x/87/67/64/8767644bc68a14c50addf8cb2de8c59e.jpg";
  @override
  void initState() {
    super.initState();
    count();
    attendance();
    creationcreate();
  }

  creationcreate() async {
    final response = await apiService.get(
        "/api/method/ssm_bore_wells.ssm_bore_wells.utlis.api.employee_customers_count",
        {});
    var response_ = json.decode(response.body);
    setState(() {
      calcount = (response_["message"]);
    });
  }

  // chart() async {
  //   final response = await apiService.get(
  //       "ssm_bore_wells.ssm_bore_wells.utlis.api.account_amount",
  //       {"from_date": "2023-09-19", "to_date": "2023-09-20"});
  //   print("sdsfddsndsnvjdnvvsvnsdvnsdv");
  //   var response_ = json.decode(response.body);
  //   List<FlSpot> jsonData = [];
  //   jsonData.add(FlSpot(0.0, 0.0));

  //   print(response.statusCode);
  //   for (var item in response_['message']) {
  //     print(item['name']);
  //     double value = item['value'].toDouble();
  //     double roundedValue = 0;
  //     if (value >= 1000) {
  //       roundedValue = (value / 10000.round());
  //     } else {
  //       roundedValue = (value / 1000.round());
  //     }

  //     print("sssssssssssss" + "" + roundedValue.toString());
  //     // Create FlSpot objects and add them tpo the list
  //     jsonData.add(FlSpot(
  //       response_['message'].indexOf(item).toDouble(),
  //       roundedValue,
  //     ));
  //   }
  //   setState(() {
  //     dummyData5 = jsonData;
  //   });
  //   print(jsonData);
  //   print(dummyData5);
  // }

  attendance() async {
    DateTime today = DateTime.now();
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = dateFormat.format(today);

    final response = await apiService.get(
        "/api/method/ssm_bore_wells.ssm_bore_wells.utlis.api.attendance_count_day",
        {
          "filters": jsonEncode({"attendance_date": formattedDate})
        });
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      var temp = jsonResponse["message"];
      setState(() {
        double pCount = temp[0]["p_count"];
        double aCount = temp[0]["a_count"];
        present = temp[0]["p_count"].toString();
        absent = temp[0]["a_count"].toString();
        double total = pCount + aCount;
        percentage = (pCount / total) * 100;
      });
    }
  }

  Future count() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await apiService
        .get("/api/method/ssm_bore_wells.ssm_bore_wells.utlis.api.count", {});
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        customercount_ = jsonResponse["message"]["customer"].toString();
        employeecount_ = jsonResponse["message"]["employee"].toString();
        imgurl = prefs.getString('image')!;
        fullname = prefs.getString('full_name')!;
        email = prefs.getString('email')!;
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
            subtitle: Text(
              email,
              style: const TextStyle(color: Color(0xFF752FFF)),
            )),
        actions: [
          IconButton(
            onPressed: () async {
              Get.toNamed('/dashboard');
            },
            icon: const HeroIcon(HeroIcons.wallet),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            width: 45,
            height: 45,
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
            child: IconButton(
              onPressed: () async {
                showPopup(context);

                // PopupWidget();
                // final response = await apiService.get("logout", {});

                // if (response.statusCode == 200) {
                //   Get.offAllNamed("/loginpage");
                // }
                // },
              },
              icon: const Icon(
                PhosphorIcons.sign_out_light,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // SizedBox(
              //   height: 300,
              //   child: LineChart(
              //     LineChartData(
              //       borderData: FlBorderData(
              //           border: const Border(
              //               bottom: BorderSide(), left: BorderSide())),
              //       titlesData: FlTitlesData(
              //         bottomTitles: AxisTitles(
              //             sideTitles: SideTitles(
              //           showTitles: true,
              //           reservedSize: 30,
              //           getTitlesWidget: (value, meta) {
              //             String text = '';

              //             switch (value.toInt()) {
              //               case 1:
              //                 text = 'Medical';
              //                 break;
              //               case 3:
              //                 text = 'Others';
              //                 break;
              //               case 5:
              //                 text = 'Travel';
              //                 break;
              //               case 7:
              //                 text = 'Fule';
              //                 break;
              //               case 9:
              //                 text = 'Food';
              //                 break;
              //             }

              //             return Text(
              //               text,
              //               style: const TextStyle(
              //                 color: Colors.black,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             );
              //           },
              //         )),
              //         leftTitles: AxisTitles(
              //             sideTitles: SideTitles(
              //           showTitles: true,
              //           getTitlesWidget: (value, meta) {
              //             String text = '';
              //             switch (value.toInt()) {
              //               case 1:
              //                 text = '100';
              //                 break;
              //               case 2:
              //                 text = '500';
              //                 break;
              //               case 3:
              //                 text = '1000';
              //                 break;
              //               case 4:
              //                 text = '1500';
              //                 break;
              //               case 5:
              //                 text = '2000';
              //                 break;
              //             }

              //             return Text(
              //               text,
              //               style: const TextStyle(
              //                 color: Colors.black,
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 12,
              //               ),
              //             );
              //           },
              //         )),
              //         topTitles:
              //             AxisTitles(sideTitles: SideTitles(showTitles: false)),
              //         rightTitles:
              //             AxisTitles(sideTitles: SideTitles(showTitles: false)),
              //       ),
              //       lineBarsData: [
              //         // The red line
              //         LineChartBarData(
              //           spots: dummyData1,
              //           isCurved: true,
              //           barWidth: 3,
              //           color: Colors.indigo,
              //         ),
              //         // The orange line
              //         LineChartBarData(
              //           spots: dummyData2,
              //           isCurved: true,
              //           barWidth: 3,
              //           color: Colors.red,
              //         ),
              //         // The blue line
              //         LineChartBarData(
              //           preventCurveOverShooting: true,
              //           isStrokeCapRound: true,
              //           curveSmoothness: 0.35,
              //           spots: dummyData3,
              //           isCurved: true,
              //           barWidth: 3,
              //           color: Colors.blue,
              //         ),
              //         LineChartBarData(
              //           spots: dummyData5,
              //           isCurved: true,
              //           barWidth: 3,
              //           color: Colors.black,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
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
                            percent: percentage / 100,
                            circularStrokeCap: CircularStrokeCap.round,
                            backgroundColor: Colors.red,
                            progressColor: const Color(0xFF752FFF),
                          ),
                        ),
                        Expanded(
                            child: ListTile(
                                title: Text(
                                  present.replaceAll('.0', ''),
                                  style:
                                      const TextStyle(color: Color(0xFF752FFF)),
                                ),
                                subtitle: const Text("Present"))),
                        Expanded(
                            child: ListTile(
                                title: Text(
                                  absent.replaceAll('.0', ''),
                                  style: const TextStyle(color: Colors.red),
                                ),
                                subtitle: const Text("Absent"))),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2.3,
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
                      child: Text("    Creation Count"),
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
                            itemCount: calcount.length,
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
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          calcount[index]["month_name"]
                                              .substring(0, 3),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          "1",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Text(
                                    "              ${calcount[index]["e_count"]}",
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  title: Text(
                                    "              ${calcount[index]["c_count"]}",
                                    style: TextStyle(
                                        color: (calcount[index]["c_count"] <= 5)
                                            ? Colors.red
                                            : Colors.black),
                                  ));
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

  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopupWidget(
          title: 'Logout',
          content:
              '    Do you want to log out from \n                   Sk Borewell?',
          child: Column(
            children: [
              Row(
                children: [
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
                      final response =
                          await apiService.get("/api/method/logout", {});

                      if (response.statusCode == 200) {
                        Get.offAllNamed("/loginpage");
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // SideTitles get _bottomTitles => SideTitles(
  //       showTitles: true,
  //       getTitlesWidget: (value, meta) {
  //         String text = '';
  //         switch (value.toInt()) {
  //           case 1:
  //             text = 'Jan';
  //             break;
  //           case 3:
  //             text = 'Mar';
  //             break;
  //           case 5:
  //             text = 'May';
  //             break;
  //           case 7:
  //             text = 'Jul';
  //             break;
  //           case 9:
  //             text = 'Sep';
  //             break;
  //           case 11:
  //             text = 'Nov';
  //             break;
  //         }

  //         return Text(text);
  //       },
  //     );
}
