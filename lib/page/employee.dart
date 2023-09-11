import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:searchfield/searchfield.dart';
import 'package:senthur_murugan/controller/api.dart';
import 'package:senthur_murugan/controller/apiservice.dart';
import 'package:senthur_murugan/widgets/appbar.dart';
import 'package:senthur_murugan/widgets/bottomsheet.dart';
import 'package:senthur_murugan/widgets/custom_button.dart';
import 'package:senthur_murugan/widgets/datepicker.dart';
import 'package:senthur_murugan/widgets/textformfield.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  final ApiService apiService = ApiService();
  final Customer customer = Get.put(Customer());
  final _attendanceFormKey = GlobalKey<FormState>();
  final TextEditingController _dojcontroller = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  List gender = ["Male", "Female"];
  @override
  void initState() {
    super.initState();
    customer.employeelist_();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReusableAppBar(
        title: 'Employee List',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height / 1.4,
                child: Obx(
                  () => ListView.builder(
                      itemCount: customer.employeelist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Container(
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
                            child: ListTile(
                                leading: Text((index + 1).toString()),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF752FFF),
                                      ),
                                      onPressed: () async {
                                        final response = await apiService.get(
                                            "ssm_bore_wells.ssm_bore_wells.utlis.api.employee_attendance",
                                            {
                                              "employee": customer
                                                  .employeelist[index]['name'],
                                              "status": "Present"
                                            });
                                      

                                        final message =
                                            json.decode(response.body);
                                        Get.snackbar(
                                          "Success",
                                          message['message'],
                                          icon: const HeroIcon(HeroIcons.check,
                                              color: Colors.white),
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor:
                                              const Color(0x0ff35394E),
                                          borderRadius: 20,
                                          margin: const EdgeInsets.all(15),
                                          colorText: Colors.white,
                                          duration: const Duration(seconds: 4),
                                          isDismissible: true,
                                          forwardAnimationCurve:
                                              Curves.easeOutBack,
                                        );
                                      },
                                      child: const Text(
                                        'Attendance',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle:
                                    Text(customer.employeelist[index]['name']),
                                title: Text(customer.employeelist[index]
                                    ['first_name'])),
                          ),
                        );
                      }),
                )),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  setState(() {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: CustomBottomSheet(
                              title: 'Employee Creation',
                              child: SingleChildScrollView(
                                  child: Form(
                                key: _attendanceFormKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ReusableTextField(
                                      labelText: 'Name',
                                      controller: _nameController,
                                      obscureText: false,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please select name';
                                        }

                                        return null;
                                      },
                                      suffixIcon: HeroIcons.user,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SearchField(
                                      controller: _genderController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please select gender';
                                        }

                                        return null;
                                      },
                                      suggestions: gender
                                          .map((String) =>
                                              SearchFieldListItem(String))
                                          .toList(),
                                      suggestionState: Suggestion.expand,
                                      suggestionsDecoration:
                                          SuggestionDecoration(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0,
                                                  left: 5,
                                                  bottom: 20),
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10))),
                                      textInputAction: TextInputAction.next,
                                      marginColor: Colors.white,
                                      searchStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                      onSearchTextChanged: (p0) {},
                                      searchInputDecoration:
                                          const InputDecoration(
                                              labelText: "Gender",
                                              suffixIcon:
                                                  HeroIcon(HeroIcons.users),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Color(0x0ff2d2e4)))),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ReusableDatePickerTextField(
                                        controller: _dateController,
                                        labelText: 'Date Of Brith',
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select date';
                                          }

                                          return null;
                                        }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ReusableDatePickerTextField(
                                      controller: _dojcontroller,
                                      labelText: 'Date Of Join',
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please select date';
                                        } else if (_dateController.text ==
                                            _dojcontroller.text) {
                                          return "DOB & DOJ are same";
                                        }

                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomFormButton(
                                        innerText: 'Submit',
                                        onPressed: () async {
                                          if (_attendanceFormKey.currentState!
                                              .validate()) {
                                            final response = await apiService.get(
                                                "ssm_bore_wells.ssm_bore_wells.utlis.api.employee_creation",
                                                {
                                                  "name": _nameController.text,
                                                  "gender":
                                                      _genderController.text,
                                                  "dob": _dateController.text,
                                                  "doj": _dojcontroller.text,
                                                  "status": "Active"
                                                });
                                            if (response.statusCode == 200) {
                                              customer.employeelist_();
                                              _nameController.clear();
                                              _genderController.clear();
                                              _dateController.clear();
                                              _dojcontroller.clear();
                                              Get.back();
                                              final message =
                                                  json.decode(response.body);
                                              Get.snackbar(
                                                "Success",
                                                message['message'],
                                                icon: const HeroIcon(
                                                    HeroIcons.check,
                                                    color: Colors.white),
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                backgroundColor:
                                                    const Color(0x0ff35394E),
                                                borderRadius: 20,
                                                margin:
                                                    const EdgeInsets.all(15),
                                                colorText: Colors.white,
                                                duration:
                                                    const Duration(seconds: 4),
                                                isDismissible: true,
                                                forwardAnimationCurve:
                                                    Curves.easeOutBack,
                                              );
                                             
                                            }
                                          }
                                        })
                                  ],
                                ),
                              )),
                            ));
                      },
                    );
                  });
                },
                child: const Icon(
                  Icons.add,
                  color: Color(0xFF752FFF),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
