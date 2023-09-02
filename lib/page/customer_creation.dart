import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:senthur_murugan/controller/apiservice.dart';
import 'package:senthur_murugan/widgets/appbar.dart';
import 'package:senthur_murugan/widgets/custom_button.dart';
import 'package:senthur_murugan/widgets/datepicker.dart';

import '../widgets/textformfield.dart';

class Customercreation extends StatefulWidget {
  const Customercreation({super.key});

  @override
  State<Customercreation> createState() => _CustomercreationState();
}

class _CustomercreationState extends State<Customercreation> {
  final _customerFormKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();

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
            icon: const Icon(Icons.arrow_back,
                color: Color(0xFF752FFF)), // Provide your leading icon
            onPressed: () {
              // Add your leading icon functionality here
            },
          ),
          title: 'Customer Creation',
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.search),
          //     onPressed: () {
          //       // Add your search functionality here
          //     },
          //   ),
          //   IconButton(
          //     icon: Icon(Icons.settings),
          //     onPressed: () {
          //       // Add your settings functionality here
          //     },
          //   ),
          // ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _customerFormKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  labelText: 'Customer Name',
                  controller: _usernameController,
                  obscureText: false,
                  suffixIcon: HeroIcons.user,
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  labelText: 'Email',
                  controller: _emailController,
                  obscureText: false,
                  suffixIcon: HeroIcons.envelope,
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
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  obscureText: false,
                  suffixIcon: HeroIcons.devicePhoneMobile,
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
                ReusableTextField(
                  labelText: 'Area',
                  controller: _areaController,
                  obscureText: false,
                  suffixIcon: HeroIcons.mapPin,
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  labelText: 'District',
                  controller: _districtController,
                  obscureText: false,
                  suffixIcon: HeroIcons.globeEuropeAfrica,
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  labelText: 'State',
                  controller: _talukController,
                  obscureText: false,
                  suffixIcon: HeroIcons.buildingOffice,
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  labelText: 'Pincode',
                  keyboardType: TextInputType.phone,
                  controller: _pincodeController,
                  obscureText: false,
                  suffixIcon: HeroIcons.newspaper,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormButton(
                  innerText: 'Submit',
                  onPressed: () async {
                    // final response =
                    //     await apiService.get('frappe.auth.get_logged_user',);

                    // print('Status Code: ${response.statusCode}');
                    // print('Response Body: ${response.body}');
                    if (_customerFormKey.currentState!.validate()) {}
                  },
                )
              ],
            ),
          ),
        )));
  }
}
