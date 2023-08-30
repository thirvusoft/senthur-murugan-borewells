import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class ReusableTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final HeroIcons? suffixIcon;
  final int? maxLength;
  final FormFieldValidator<String>? validator;

  const ReusableTextField({
    required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLength,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x0ff2d2e4))),
        suffixIcon:
            suffixIcon != null ? HeroIcon(suffixIcon as HeroIcons) : null,
      ),
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Please enter some text.';
      //   }
      //   return null;
      // },
    );
  }
}
