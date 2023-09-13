import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:senthur_murugan/controller/apiservice.dart';
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
  double percentage = 0.0;
  String present = "0";
  String absent = "0";
  String customercount_ = "";
  String employeecount_ = "";
  String fullname = "";
  var calcount = [];
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
        "ssm_bore_wells.ssm_bore_wells.utlis.api.employee_customers_count", {});
    var response_ = json.decode(response.body);
    calcount = (response_["message"]);
  }

  attendance() async {
    DateTime today = DateTime.now();
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = dateFormat.format(today);

    final response = await apiService
        .get("ssm_bore_wells.ssm_bore_wells.utlis.api.attendance_count_day", {
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
        .get("ssm_bore_wells.ssm_bore_wells.utlis.api.count", {});
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        customercount_ = jsonResponse["message"]["customer"].toString();
        employeecount_ = jsonResponse["message"]["employee"].toString();
        imgurl = prefs.getString('image')!;
        fullname = prefs.getString('full_name')!;
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
                                          "23",
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
                                      "              ${calcount[index]["c_count"]}"));
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
