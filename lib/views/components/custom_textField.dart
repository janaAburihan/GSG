// ignore_for_file: file_names
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final Function validation;
  final TextEditingController controller;
  bool isPassword;
  final TextInputType textInputType;
  final String label;
  CustomTextField({
    Key? key,
    required this.validation,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      obscureText: isPassword,
      controller: controller,
      validator: (v) => validation(v),
      decoration: InputDecoration(
          label: Text(label),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }
}
