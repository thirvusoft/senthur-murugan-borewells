import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class ReusableDatePickerTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final FormFieldValidator<String>? validator;

  const ReusableDatePickerTextField({
    required this.controller,
    required this.labelText,
    this.validator,
  });

  @override
  _ReusableDatePickerTextFieldState createState() =>
      _ReusableDatePickerTextFieldState();
}

class _ReusableDatePickerTextFieldState
    extends State<ReusableDatePickerTextField> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != widget.controller.text) {
      widget.controller.text = pickedDate.toString().substring(0, 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      textInputAction: TextInputAction.next,
      validator: widget.validator,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x0ff2d2e4))),
        suffixIcon: const HeroIcon(HeroIcons.calendarDays),
        labelText: widget.labelText,
      ),
      style: const TextStyle(),
      readOnly: true,
      onTap: () => _selectDate(context),
    );
  }
}
