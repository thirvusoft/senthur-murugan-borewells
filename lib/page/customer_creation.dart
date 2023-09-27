import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:senthur_murugan/controller/api.dart';
import 'package:senthur_murugan/controller/apiservice.dart';
import 'package:senthur_murugan/widgets/reusable_appbar.dart';
import 'package:senthur_murugan/widgets/reusable_custom_button.dart';
import 'package:senthur_murugan/widgets/reusable_datepicker.dart';
import 'package:searchfield/searchfield.dart';
import 'package:senthur_murugan/widgets/internet_checker.dart';

import '../widgets/reusable_textformfield.dart';

class Customercreation extends StatefulWidget {
  const Customercreation({super.key});

  @override
  State<Customercreation> createState() => _CustomercreationState();
}

class _CustomercreationState extends State<Customercreation> {
  final _customerFormKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();
  final Customer customer = Get.put(Customer());
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _talukController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ReusableAppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: 'Customer Creation',
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _customerFormKey,
            child: Column(
              children: [
                Visibility(
                  visible: Provider.of<InternetConnectionStatus>(context) ==
                      InternetConnectionStatus.disconnected,
                  child: const InternetNotAvailable(),
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  labelText: 'Customer Name',
                  controller: _usernameController,
                  obscureText: false,
                  suffixIcon: HeroIcons.user,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Customer Name can't be empty";
                    }
                    return null;
                  },
                  readyonly: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  labelText: 'Email',
                  controller: _emailController,
                  obscureText: false,
                  suffixIcon: HeroIcons.envelope,
                  readyonly: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  controller: _mobileController,
                  labelText: 'Mobile Number',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Mobile Number can't be empty";
                    } else if (value.length != 10) {
                      return "Invalid Mobile Number ";
                    }
                    return null;
                  },
                  readyonly: false,
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  obscureText: false,
                  suffixIcon: HeroIcons.devicePhoneMobile,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableDatePickerTextField(
                  controller: _dateController,
                  labelText: 'Date Of Brith',
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => SearchField(
                      controller: _areaController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Area can't empty ";
                        }

                        return null;
                      },
                      suggestions: customer.territorylist_
                          .map((String) => SearchFieldListItem(String))
                          .toList(),
                      suggestionState: Suggestion.expand,
                      onSuggestionTap: (f) async {
                        FocusScope.of(context).unfocus();
                        final response = await apiService.get(
                            "/api/method/ssm_bore_wells.ssm_bore_wells.utlis.api.state_district_list",
                            {
                              "territory": _areaController.text,
                            });
                   

                        if (response.statusCode == 200) {
                          final district = json.decode(response.body);

                          final state = json.decode(response.body);

                          setState(() {
                            List<String> parts =
                                _areaController.text.split('-');
                            _pincodeController.text = parts[1];
                            _districtController.text =
                                district["message"]['district'];
                            _talukController.text = state["message"]['state'];
                          });
                        }
                      },
                      suggestionsDecoration: SuggestionDecoration(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 5, bottom: 20),
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      textInputAction: TextInputAction.next,
                      marginColor: Colors.white,
                      searchStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black.withOpacity(0.8),
                      ),
                      onSearchTextChanged: (p0) {
                        customer.territory(_areaController.text);
                      },
                      searchInputDecoration: const InputDecoration(
                          labelText: "Area",
                          suffixIcon: HeroIcon(HeroIcons.mapPin),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0x0ff2d2e4)))),
                    )),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  readyonly: true,
                  labelText: 'District',
                  controller: _districtController,
                  obscureText: false,
                  suffixIcon: HeroIcons.globeEuropeAfrica,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  readyonly: true,
                  labelText: 'State',
                  controller: _talukController,
                  obscureText: false,
                  suffixIcon: HeroIcons.buildingOffice,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  readyonly: true,
                  labelText: 'Pincode',
                  maxLength: 6,
                  keyboardType: TextInputType.phone,
                  controller: _pincodeController,
                  obscureText: false,
                  suffixIcon: HeroIcons.newspaper,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormButton(
                  innerText: 'Submit',
                  onPressed: () async {
                    if (_customerFormKey.currentState!.validate()) {
                      final response = await apiService.get(
                          '/api/method/ssm_bore_wells.ssm_bore_wells.utlis.api.new_customer',
                          {
                            "customer_name": _usernameController.text,
                            "customer_type": "Individual",
                            "customer_group": "Individual",
                            "date_of_birth": _dateController.text,
                            "territory": _areaController.text,
                            "mobile_number": _mobileController.text,
                            "email_address": _emailController.text,
                            "address_line1": "Test ",
                            "address_line2": "",
                            "city": _districtController.text,
                            "state": _talukController.text,
                            "country": "India",
                            "pincode": _pincodeController.text
                          });

                      if (response.statusCode == 200) {
                        final Customer customer = Get.put(Customer());

                        customer.customerlist_();

                        Get.back();
                        _usernameController.clear();
                        _pincodeController.clear();
                        _usernameController.clear();
                        _areaController.clear();
                        _mobileController.clear();
                        _emailController.clear();
                        _districtController.clear();
                        _talukController.clear();
                        _dateController.clear();

                        final message = json.decode(response.body);
                        Get.snackbar(
                          "Success",
                          message['message'],
                          icon: HeroIcon(HeroIcons.check, color: Colors.white),
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Color(0x0ff35394E),
                          borderRadius: 20,
                          margin: EdgeInsets.all(15),
                          colorText: Colors.white,
                          duration: Duration(seconds: 4),
                          isDismissible: true,
                          forwardAnimationCurve: Curves.easeOutBack,
                        );
                      }
                    }
                  },
                )
              ],
            ),
          ),
        )));
  }
}
