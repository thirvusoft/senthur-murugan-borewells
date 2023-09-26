import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:searchfield/searchfield.dart';
import 'package:senthur_murugan/controller/api.dart';
import 'package:senthur_murugan/controller/apiservice.dart';
import 'package:senthur_murugan/widgets/reusable_appbar.dart';
import 'package:senthur_murugan/widgets/reusable_bottomsheet.dart';
import 'package:senthur_murugan/widgets/reusable_custom_button.dart';
import 'package:senthur_murugan/widgets/reusable_datepicker.dart';
import 'package:senthur_murugan/widgets/reusable_textformfield.dart';

class Cusomerlist extends StatefulWidget {
  const Cusomerlist({super.key});

  @override
  State<Cusomerlist> createState() => _CusomerlistState();
}

class _CusomerlistState extends State<Cusomerlist> {
  final Customer customer = Get.put(Customer());
  var sort = "";
  final _attendanceFormKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();
  final TextEditingController searchcontroller = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _talukController = TextEditingController();

  @override
  void initState() {
    super.initState();
    customer.customerlist_();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReusableAppBar(
        title: 'Customer List',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 50,
              child: ReusableTextField(
                labelText: 'Search',
                controller: searchcontroller,
                obscureText: false,
                suffixIcon: HeroIcons.magnifyingGlass,
                onChange: ((value) {
                  setState(() {
                    sort = value;
                  });
                  customer.customerfliter(sort);
                }),
                readyonly: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.45,
              child: Obx(
                () {
                  if (customer.customerlistisLoading.value) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: CircularProgressIndicator()),
                      ],
                    );
                  } else {
                    return RefreshIndicator(
                        onRefresh: () async {
                          await Future.delayed(Duration(seconds: 2));
                          customer.customerlist_();
                        },
                        child: ListView.builder(
                            itemCount: (sort.isEmpty)
                                ? customer.customerlist.length
                                : customer.customerfliterlist.length,
                            itemBuilder: (BuildContext context, int index) {
                              final user = (sort.isEmpty)
                                  ? customer.customerlist[index]
                                  : customer.customerfliterlist[index];
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
                                      leading: Text(
                                        (index + 1).toString(),
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                      title: Text(user['customer_name']),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: const Color(0xFFeee6ff),
                                              ),
                                              child: IconButton(
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Padding(
                                                          padding: EdgeInsets.only(
                                                              bottom: MediaQuery
                                                                      .of(
                                                                          context)
                                                                  .viewInsets
                                                                  .bottom),
                                                          child:
                                                              CustomBottomSheet(
                                                            title: user[
                                                                'customer_name'],
                                                            child:
                                                                SingleChildScrollView(
                                                                    child: Form(
                                                              key:
                                                                  _attendanceFormKey,
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: <Widget>[
                                                                  ReusableTextField(
                                                                    maxLength:
                                                                        10,
                                                                    labelText:
                                                                        'Mobile Number',
                                                                    controller:
                                                                        _mobileController,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .phone,
                                                                    obscureText:
                                                                        false,
                                                                    suffixIcon:
                                                                        HeroIcons
                                                                            .devicePhoneMobile,
                                                                    readyonly:
                                                                        false,
                                                                    autovalidateMode:
                                                                        AutovalidateMode
                                                                            .onUserInteraction,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  ReusableDatePickerTextField(
                                                                    controller:
                                                                        _dateController,
                                                                    labelText:
                                                                        'Date Of Brith',
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Obx(() =>
                                                                      SearchField(
                                                                        controller:
                                                                            _areaController,
                                                                        suggestions: customer
                                                                            .territorylist_
                                                                            .map((String) =>
                                                                                SearchFieldListItem(String))
                                                                            .toList(),
                                                                        suggestionState:
                                                                            Suggestion.expand,
                                                                        onSuggestionTap:
                                                                            (f) async {
                                                                          FocusScope.of(context)
                                                                              .unfocus();
                                                                          final response =
                                                                              await apiService.get("/api/method/ssm_bore_wells.ssm_bore_wells.utlis.api.state_district_list", {
                                                                            "territory":
                                                                                _areaController.text,
                                                                          });

                                                                          if (response.statusCode ==
                                                                              200) {
                                                                            final district =
                                                                                json.decode(response.body);

                                                                            final state =
                                                                                json.decode(response.body);

                                                                            setState(() {
                                                                              List<String> parts = _areaController.text.split('-');
                                                                              _pincodeController.text = parts[1];
                                                                              _districtController.text = district["message"]['district'];
                                                                              _talukController.text = state["message"]['state'];
                                                                            });
                                                                          }
                                                                        },
                                                                        suggestionsDecoration: SuggestionDecoration(
                                                                            padding: const EdgeInsets.only(
                                                                                top: 10.0,
                                                                                left: 5,
                                                                                bottom: 20),
                                                                            color: Colors.white,
                                                                            borderRadius: const BorderRadius.all(Radius.circular(10))),
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        marginColor:
                                                                            Colors.white,
                                                                        searchStyle:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(0.8),
                                                                        ),
                                                                        onSearchTextChanged:
                                                                            (p0) {
                                                                          customer
                                                                              .territory(_areaController.text);
                                                                        },
                                                                        searchInputDecoration: const InputDecoration(
                                                                            labelText:
                                                                                "Area",
                                                                            suffixIcon:
                                                                                HeroIcon(HeroIcons.mapPin),
                                                                            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0x0ff2d2e4)))),
                                                                      )),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  ReusableTextField(
                                                                    readyonly:
                                                                        true,
                                                                    labelText:
                                                                        'District',
                                                                    controller:
                                                                        _districtController,
                                                                    obscureText:
                                                                        false,
                                                                    suffixIcon:
                                                                        HeroIcons
                                                                            .globeEuropeAfrica,
                                                                    autovalidateMode:
                                                                        AutovalidateMode
                                                                            .onUserInteraction,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  ReusableTextField(
                                                                    readyonly:
                                                                        true,
                                                                    labelText:
                                                                        'State',
                                                                    controller:
                                                                        _talukController,
                                                                    obscureText:
                                                                        false,
                                                                    suffixIcon:
                                                                        HeroIcons
                                                                            .buildingOffice,
                                                                    autovalidateMode:
                                                                        AutovalidateMode
                                                                            .onUserInteraction,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  ReusableTextField(
                                                                    readyonly:
                                                                        true,
                                                                    labelText:
                                                                        'Pincode',
                                                                    maxLength:
                                                                        6,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .phone,
                                                                    controller:
                                                                        _pincodeController,
                                                                    obscureText:
                                                                        false,
                                                                    suffixIcon:
                                                                        HeroIcons
                                                                            .newspaper,
                                                                    autovalidateMode:
                                                                        AutovalidateMode
                                                                            .onUserInteraction,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  CustomFormButton(
                                                                      innerText:
                                                                          'Submit',
                                                                      onPressed:
                                                                          () async {
                                                                        if (_attendanceFormKey
                                                                            .currentState!
                                                                            .validate()) {
                                                                          final response =
                                                                              await apiService.get("/api/method/ssm_bore_wells.ssm_bore_wells.utlis.api.customer_update", {
                                                                            "customer":
                                                                                jsonEncode({
                                                                              "name": user['customer_name'],
                                                                              "mobile_number": _mobileController.text,
                                                                              "date_of_birth": _dateController.text,
                                                                              "territory": _areaController.text,
                                                                              "status": _talukController.text,
                                                                              "city": _districtController.text,
                                                                              "state": _talukController.text,
                                                                              "pincode": _pincodeController.text
                                                                            })
                                                                          });

                                                                          if (response.statusCode ==
                                                                              200) {
                                                                            Get.back();
                                                                            final message =
                                                                                json.decode(response.body);
                                                                            Get.snackbar(
                                                                              "Success",
                                                                              message['message'],
                                                                              icon: const HeroIcon(HeroIcons.check, color: Colors.white),
                                                                              snackPosition: SnackPosition.BOTTOM,
                                                                              backgroundColor: const Color(0x0ff35394E),
                                                                              borderRadius: 20,
                                                                              margin: const EdgeInsets.all(15),
                                                                              colorText: Colors.white,
                                                                              duration: const Duration(seconds: 4),
                                                                              isDismissible: true,
                                                                              forwardAnimationCurve: Curves.easeOutBack,
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
                                                },
                                                icon: const HeroIcon(
                                                  HeroIcons.pencilSquare,
                                                  color: Color(0xFF752FFF),
                                                ),
                                              )),
                                        ],
                                      ),
                                      subtitle: Text(user['mobile_no'])),
                                ),
                              );
                            }));
                  }
                },
              ),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Get.toNamed("Customercreation");
        },
        child: const Icon(
          Icons.add,
          color: Color(0xFF752FFF),
        ),
      ),
    );
  }
}
