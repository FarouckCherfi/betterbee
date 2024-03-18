import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String labelText;
  final TextInputType keyboardType;
  final bool? obscureText;
  final TextEditingController? controller;

  const CustomFormField(
      {super.key,
      required this.labelText,
      required this.keyboardType,
      this.controller,
      this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.all(10),
          
        ),
        obscureText: obscureText ?? false,
        obscuringCharacter: "*",
        keyboardType: keyboardType,
        controller: controller);
  }
}
