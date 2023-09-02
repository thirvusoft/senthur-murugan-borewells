import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:senthur_murugan/widgets/custom_button.dart';
import 'package:senthur_murugan/widgets/textformfield.dart';

class Loginpage extends StatelessWidget {
  Loginpage({super.key});
  final _loginFormkey = GlobalKey<FormState>();

  final TextEditingController _mobilenumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF752FFF),
        appBar: AppBar(
          toolbarHeight: 120,
          centerTitle: true,
          title: const Text("Senthur Murugan",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: .1)),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0), // Adjust these values as needed

                topRight:
                    Radius.circular(20.0), // Adjust these values as needed
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
                        maxLength: 10),
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
                        if (_loginFormkey.currentState!.validate()) {}
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
