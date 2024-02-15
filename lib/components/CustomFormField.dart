import 'package:flutter/material.dart';



class CustomFormField extends StatelessWidget {
  final String labelText;
  final TextInputType keyboardType;
  final bool? obscureText;

  const CustomFormField({
    super.key,
    required this.labelText,
    required this.keyboardType,
    this.obscureText
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 1,
                    color : Colors.grey
                ),
                borderRadius : BorderRadius.circular(20)
            )
        ),
        obscureText: obscureText ?? false,
        obscuringCharacter: "*",
        keyboardType: keyboardType,
    );
  }}