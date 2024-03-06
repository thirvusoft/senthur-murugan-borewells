import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:senthur_murugan/controller/apiservice.dart';
import 'package:senthur_murugan/widgets/reusable_custom_button.dart';
import 'package:senthur_murugan/widgets/reusable_textformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatelessWidget {
  Loginpage({super.key});
  final _loginFormkey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();
  var userImage = "";
  final TextEditingController _mobilenumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF752FFF),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF752FFF),
          toolbarHeight: 120,
          centerTitle: true,
          title: const Text("Senthur Murugan",
              style: TextStyle(
                  fontSize: 25,
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                  letterSpacing: .3)),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
              child: Form(
                key: _loginFormkey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Login",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: .1))),
                    const SizedBox(
                      height: 30,
                    ),
                    ReusableTextField(
                      labelText: 'Mobile Number',
                      controller: _mobilenumberController,
                      obscureText: false,
                      suffixIcon: HeroIcons.devicePhoneMobile,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Mobile Number can't be empty";
                        } else if (value.length != 10) {
                          return "Invalid Mobile Number ";
                        }
                        return null;
                      },
                      maxLength: 10,
                      readyonly: false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ReusableTextField(
                      labelText: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                      suffixIcon: HeroIcons.lockClosed,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password can't be empty";
                        }
                        return null;
                      },
                      readyonly: false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(180, 0, 0, 0),
                      child: const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 'Forget Password ? '),
                            TextSpan(
                                text: 'click here',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2D2E4A))),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomFormButton(
                      innerText: 'Login',
                      onPressed: () async {
                        if (_loginFormkey.currentState!.validate()) {
                          final response = await apiService.get(
                              "/api/method/ssm_bore_wells.ssm_bore_wells.utlis.api.login",
                              {
                                "usr": _mobilenumberController.text,
                                "pwd": _passwordController.text
                              });
                          if (response.statusCode == 200) {

                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                                
                            final Response = json.decode(response.body);
                            await prefs.setString(
                                'full_name', Response["full_name"]);
                            Get.offAllNamed("/Bottomnavigation");
                            response.header['cookie'] =
                                "${response.header['set-cookie'].toString()};";
                            response.header.removeWhere((key, value) =>
                                ["set-cookie", 'content-length'].contains(key));

                            await prefs.setString(
                                'request-header', json.encode(response.header));
                            if (Response["image"] != null) {
                              userImage =
                                  "${dotenv.env['API_URL']}${Response["image"]}";
                            } else {
                              userImage =
                                  "https://i.pinimg.com/736x/87/67/64/8767644bc68a14c50addf8cb2de8c59e.jpg";
                            }

                            var email = Response["email"];

                            await prefs.setString('image', userImage);
                            await prefs.setString('email', email);
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
