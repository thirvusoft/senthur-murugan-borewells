import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:senthur_murugan/controller/apiservice.dart';
import 'package:senthur_murugan/widgets/appbar.dart';
import 'package:senthur_murugan/widgets/datepicker.dart';

class Epensedashboard extends StatefulWidget {
  const Epensedashboard({super.key});

  @override
  State<Epensedashboard> createState() => _EpensedashboardState();
}

class _EpensedashboardState extends State<Epensedashboard> {
  final ApiService apiService = ApiService();
  final TextEditingController _formdateController = TextEditingController();
  final TextEditingController _todateController = TextEditingController();

  List dashboard = [];
  @override
  void initState() {
    super.initState();
    String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    DateTime originalDate = DateFormat("yyyy-MM-dd").parse(cdate);

    DateTime subtractedDate = originalDate.subtract(Duration(days: 1));

    String fromdate = DateFormat("yyyy-MM-dd").format(subtractedDate);

    chart(fromdate, cdate);
  }

  chart(fdate, tdate) async {
   

    final response = await apiService.get(
        "ssm_bore_wells.ssm_bore_wells.utlis.api.account_amount",
        {"from_date": fdate, "to_date": tdate});
    var response_ = json.decode(response.body);
    for (var item in response_["message"]) {
      if (item["name"].contains("Food")) {
        item["icon"] = PhosphorIcons.coffee_light;
        item["container_color"] = const Color(0xFFffcccc);
        item["icon_color"] = const Color(0xFFff0000);
      } else if (item["name"].contains("Travel")) {
        item["icon"] = PhosphorIcons.airplane_takeoff_light;
        item["container_color"] = const Color(0xffccffcc);
        item["icon_color"] = const Color(0Xff00b300);
      } else if (item["name"].contains("Fule")) {
        item["icon"] = PhosphorIcons.gas_pump_light;
        item["container_color"] = const Color(0xFFeee6ff);
        item["icon_color"] = const Color(0xFF752FFF);
      } else if (item["name"].contains("Medical")) {
        item["icon"] = PhosphorIcons.first_aid_kit_light;
        item["container_color"] = const Color(0xFFfff5cc);
        item["icon_color"] = const Color(0xFFe6b800);
      } else {
        item["icon"] = PhosphorIcons.bag_light;
        item["container_color"] = const Color(0xFFccccff);
        item["icon_color"] = const Color(0xFF000099);
      }
    }
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      dashboard = response_["message"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color(0xFF752FFF)), // Provide your leading icon
          onPressed: () {
            Get.back();
          },
        ),
        title: 'Expense List',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ReusableDatePickerTextField(
                      controller: _formdateController,
                      labelText: 'Form Date',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: ReusableDatePickerTextField(
                    onTap: () {
                      chart(_formdateController.text, _todateController.text);
                    },
                    controller: _todateController,
                    labelText: 'To Date',
                  ))
                ],
              ),
            ),
            SizedBox(
              height: 250,
              child: (dashboard.isEmpty)
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: CircularProgressIndicator()),
                      ],
                    )
                  : ListView.separated(
                      itemCount: dashboard.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Divider(),
                          ),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(top: 15, left: 5, right: 5),
                          child: ListTile(
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: dashboard[index]["container_color"]
                                      as Color,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(230, 233, 230, 1),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  dashboard[index]["icon"],
                                  color: dashboard[index]["icon_color"],
                                ),
                              ),
                              trailing: Text(
                                "₹ ${dashboard[index]["value"]}",
                                style: const TextStyle(fontSize: 15),
                              ),
                              title: Text(dashboard[index]["name"]
                                  .replaceAll(" - SSMBW", ""))),
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
