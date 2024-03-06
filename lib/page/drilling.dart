import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:searchfield/searchfield.dart';
import 'package:senthur_murugan/controller/api.dart';
import 'package:senthur_murugan/widgets/reusable_appbar.dart';
import 'package:senthur_murugan/widgets/reusable_datepicker.dart';

class Drilling extends StatefulWidget {
  const Drilling({Key? key}) : super(key: key);

  @override
  State<Drilling> createState() => _DrillingState();
}

class _DrillingState extends State<Drilling> {
  final Customer customer = Get.put(Customer());

  final _formKey = GlobalKey<FormState>();
  TextEditingController customerName = TextEditingController();
  TextEditingController drillerName = TextEditingController();
  TextEditingController drillingDate = TextEditingController();
  TextEditingController bitSize = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReusableAppBar(
        title: 'Drilling Details',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Obx(() => SearchField(
                    controller: customerName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Customer can't empty ";
                      }

                      return null;
                    },
                    suggestions: customer.customersearchlist_
                        .map((String) => SearchFieldListItem(String))
                        .toList(),
                    suggestionState: Suggestion.expand,
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
                      customer.customerName(customerName.text);
                    },
                    searchInputDecoration: const InputDecoration(
                        labelText: "Customer Name",
                        // suffixIcon: HeroIcon(HeroIcons.mapPin),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0x0ff2d2e4)))),
                  )),
              const SizedBox(
                height: 20,
              ),
              Obx(() => SearchField(
                    controller: drillerName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Driller can't empty ";
                      }

                      return null;
                    },
                    suggestions: customer.employeesearchlist_
                        .map((String) => SearchFieldListItem(String))
                        .toList(),
                    suggestionState: Suggestion.expand,
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
                      customer.employee(drillerName.text);
                    },
                    searchInputDecoration: const InputDecoration(
                        labelText: "Driller Name",
                        // suffixIcon: HeroIcon(HeroIcons.mapPin),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0x0ff2d2e4)))),
                  )),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ReusableDatePickerTextField(
                      controller: drillingDate,
                      labelText: 'Date',
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: Obx(() => SearchField(
                          controller: bitSize,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Bit Size can't empty ";
                            }
                            return null;
                          },
                          suggestions: customer.bitsizelist
                              .map((String) => SearchFieldListItem(String))
                              .toList(),
                          suggestionState: Suggestion.expand,
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
                            customer.bitSize(bitSize.text);
                          },
                          searchInputDecoration: const InputDecoration(
                              labelText: "Bit Size",
                              // suffixIcon: HeroIcon(HeroIcons.mapPin),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0x0ff2d2e4)))),
                        )),
                  )
                ],
              ),
                Row(
                children: [
                  Expanded(
                    child: ReusableDatePickerTextField(
                      controller: drillingDate,
                      labelText: 'Date',
                      
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: Obx(() => SearchField(
                          controller: bitSize,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Bit Size can't empty ";
                            }
                            return null;
                          },
                          suggestions: customer.bitsizelist
                              .map((String) => SearchFieldListItem(String))
                              .toList(),
                          suggestionState: Suggestion.expand,
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
                            customer.bitSize(bitSize.text);
                          },
                          searchInputDecoration: const InputDecoration(
                              labelText: "Bit Size",
                              // suffixIcon: HeroIcon(HeroIcons.mapPin),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0x0ff2d2e4)))),
                        )),
                  )
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, perform your action here
                    // You can access the field values using _field1Controller.text and _field2Controller.text
                    // For example: print(_field1Controller.text);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Drilling(),
  ));
}
