import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:heroicons/heroicons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:senthur_murugan/controller/apiservice.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ApiService apiService = ApiService();

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
              "https://images.pexels.com/photos/810775/pexels-photo-810775.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: const ListTile(
            title: Text("Vignesh M"),
            subtitle: Text(
              "vigneshmanimsc@gmail.com",
              style: TextStyle(color: Color(0xFF752FFF)),
            )),
        actions: const [
          HeroIcon(HeroIcons.arrowLeft),
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
              Container(
                height: 100,
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
                      child: Text("    Check In/out"),
                    ),
                    Row(
                      children: [
                        const Expanded(
                            child: ListTile(
                          title: Text(
                            "00:00: Hrs",
                            style: TextStyle(color: Color(0xFF752FFF)),
                          ),
                          subtitle: Text("Check In 8:00 AM"),
                        )),
                        Expanded(
                          child: ElevatedButton(
                            style: style,
                            onPressed: () async {
                              // final response = await apiService.get("login", {
                              //   "usr": "barath@gmail.com",
                              //   "pwd": "admin@123"
                              // });
                              // print(response.statusCode);
                              // print(response.body);
                              // print(response.header);
                              // Get.toNamed("/attendance");
                            },
                            child: const Text('Check In'),
                          ),
                        )
                      ],
                    )
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
                        Text("Date"),
                        Text("Check In"),
                        Text("Check Out")
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
                            itemCount: 5,
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
