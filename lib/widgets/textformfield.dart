import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class ReusableTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final HeroIcons? suffixIcon;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChange;
  ReusableTextField({
    required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLength,
    this.validator,
    this.onChange,
  });

  @override
  State<ReusableTextField> createState() => _ReusableTextFieldState();
}

class _ReusableTextFieldState extends State<ReusableTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText:
          (widget.obscureText != true) ? widget.obscureText : _obscureText,
      validator: widget.validator,
      maxLength: widget.maxLength,
      onChanged: (text) {
        
        if (widget.onChange != null) {
          widget.onChange!(text);
        }
      },
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x0ff2d2e4))),
        suffixIcon: (widget.obscureText != true)
            ? HeroIcon(widget.suffixIcon as HeroIcons)
            : IconButton(
                icon: HeroIcon(
                  _obscureText ? HeroIcons.lockClosed : HeroIcons.lockOpen,
                  color: Colors.black54,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
      ),
    );
  }
}
